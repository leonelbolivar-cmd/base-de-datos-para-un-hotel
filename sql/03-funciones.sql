-- ======================================================================
-- VISTAS (Consultas estáticas predefinidas, se consumen con GET)
-- ======================================================================

CREATE OR REPLACE VIEW clientes_frecuentes_restaurante AS
SELECT 
    c.dni_cliente,
    c.nombre_completo,
    COUNT(rc.id_consumo) AS cantidad_consumos,
    SUM(rc.monto_consumo) AS gasto_consumo 
FROM cliente c
INNER JOIN reserva r ON c.dni_cliente = r.dni_cliente
INNER JOIN restaurante_consumos rc ON r.id_reserva = rc.id_reserva
GROUP BY c.dni_cliente, c.nombre_completo
HAVING COUNT(rc.id_consumo) >= 3
ORDER BY gasto_consumo DESC;

-- ======================================================================
-- FUNCIONES DE LECTURA (Consultas dinámicas con parámetros, consumen POST)
-- ======================================================================

CREATE OR REPLACE FUNCTION historial_consumos_cliente(p_dni_cliente VARCHAR)
RETURNS TABLE (
    nombre_cliente VARCHAR,
    fecha_consumo TIMESTAMP,
    detalle_pedido TEXT,
    monto_consumo DECIMAL(10,2),
    id_reserva INT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        c.nombre_completo,
        rc.fecha_hora,
        rc.detalle_pedido,
        rc.monto_consumo,
        r.id_reserva
    FROM cliente c
    INNER JOIN reserva r ON c.dni_cliente = r.dni_cliente
    INNER JOIN restaurante_consumos rc ON r.id_reserva = rc.id_reserva
    WHERE c.dni_cliente = p_dni_cliente;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION reporte_ingresos_habitaciones(monto_minimo DECIMAL)
RETURNS TABLE (
    tipo_habitacion VARCHAR,
    total_reservas BIGINT,
    ingresos_totales DECIMAL
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        h.tipo_habitacion,
        COUNT(r.id_reserva),
        SUM(b.monto_total)
    FROM habitaciones h
    INNER JOIN reserva r ON h.numero_habitacion = r.numero_habitacion
    INNER JOIN boleta b ON r.id_reserva = b.id_reserva
    WHERE r.estado = 'Finalizada' 
    GROUP BY h.tipo_habitacion
    HAVING SUM(b.monto_total) > monto_minimo
    ORDER BY SUM(b.monto_total) DESC;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION reporte_tareas_por_empleado(p_id_empleado INT)
RETURNS TABLE (
    nombre_empleado VARCHAR,
    area_trabajo VARCHAR,
    habitacion_intervenida VARCHAR,
    categoria_habitacion VARCHAR,
    tarea_realizada TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        e.nombre_completo,
        d.nombre_area,
        m.numero_habitacion,
        h.tipo_habitacion,
        m.descripcion_trabajo
    FROM empleados e
    INNER JOIN departamentos d ON e.id_departamento = d.id_departamento
    INNER JOIN mantenimiento_tareas m ON e.id_empleado = m.id_empleado
    INNER JOIN habitaciones h ON m.numero_habitacion = h.numero_habitacion
    WHERE e.id_empleado = p_id_empleado;
END;
$$ LANGUAGE plpgsql;


-- ======================================================================
-- FUNCIONES (Lógica que altera múltiples tablas a la vez)
-- ======================================================================

CREATE OR REPLACE FUNCTION registrar_inicio_mantenimiento(
    p_descripcion TEXT,
    p_id_empleado INT,
    p_numero_habitacion VARCHAR
) 
RETURNS TEXT AS $$
BEGIN
    INSERT INTO mantenimiento_tareas (descripcion_trabajo, fecha_realizacion, id_empleado, numero_habitacion)
    VALUES (p_descripcion, CURRENT_DATE, p_id_empleado, p_numero_habitacion);
    UPDATE habitaciones
    SET estado_habitacion = 'Mantenimiento'
    WHERE numero_habitacion = p_numero_habitacion;

    RETURN 'Operación exitosa: Tarea registrada y habitación ' || p_numero_habitacion || ' puesta en mantenimiento.';
END;
$$ LANGUAGE plpgsql;

-- 5. Función: Calcular estado de cuenta con descuentos (Retorna JSON)
CREATE OR REPLACE FUNCTION calcular_estado_cuenta(p_id_reserva INT)
RETURNS json AS $$
DECLARE
    v_dias INT;
    v_precio_noche DECIMAL(10,2);
    v_costo_habitacion DECIMAL(10,2);
    v_descuento_porcentaje DECIMAL(5,2);
    v_monto_descuento DECIMAL(10,2);
    v_total_restaurante DECIMAL(10,2);
    v_total_pagar DECIMAL(10,2);
    v_nombre_cliente VARCHAR;
    v_resultado json;
BEGIN
    SELECT 
        (r.fecha_checkout - r.fecha_checkin), 
        h.precio_base_noche,
        COALESCE(con.porcentaje_descuento, 0), 
        c.nombre_completo
    INTO 
        v_dias, v_precio_noche, v_descuento_porcentaje, v_nombre_cliente
    FROM reserva r
    JOIN habitaciones h ON r.numero_habitacion = h.numero_habitacion
    JOIN cliente c ON r.dni_cliente = c.dni_cliente
    LEFT JOIN convenios con ON c.id_convenio = con.id_convenio
    WHERE r.id_reserva = p_id_reserva;

    v_costo_habitacion := v_dias * v_precio_noche;
    v_monto_descuento := v_costo_habitacion * (v_descuento_porcentaje / 100);

    SELECT COALESCE(SUM(monto_consumo), 0)
    INTO v_total_restaurante
    FROM restaurante_consumos
    WHERE id_reserva = p_id_reserva;

    v_total_pagar := (v_costo_habitacion - v_monto_descuento) + v_total_restaurante;

    v_resultado := json_build_object(
        'id_reserva', p_id_reserva,
        'cliente', v_nombre_cliente,
        'dias_estadia', v_dias,
        'subtotal_habitacion', v_costo_habitacion,
        'descuento_aplicado', v_monto_descuento,
        'cargos_restaurante', v_total_restaurante,
        'total_final', v_total_pagar
    );

    RETURN v_resultado;
END;
$$ LANGUAGE plpgsql;

--insercion en carcada(al algo asi ya me olvide)


-- =====================================================================
-- REQUISITO CRÍTICO ENTREGABLE 1: INSERCIÓN/ACTUALIZACIÓN EN CASCADA (3+ TABLAS)
-- =====================================================================

CREATE OR REPLACE FUNCTION registrar_checkin_completo(
    p_id_reserva INT,
    p_numero_habitacion VARCHAR,
    p_dni_cliente VARCHAR,
    p_id_empleado INT
) 
RETURNS JSON AS $$
DECLARE
    v_precio_habitacion DECIMAL(10,2);
    v_resultado JSON;
BEGIN
    -- 1. Actualizar el estado de la reserva a 'Activa' (Tabla 1)
    UPDATE reserva 
    SET estado = 'Activa' 
    WHERE id_reserva = p_id_reserva;

    -- 2. Cambiar el estado de la habitación a 'Ocupada' (Tabla 2)
    UPDATE habitaciones 
    SET estado_habitacion = 'Ocupada' 
    WHERE numero_habitacion = p_numero_habitacion;

    -- Obtener el precio de la habitación para la boleta inicial
    SELECT precio_base_noche INTO v_precio_habitacion 
    FROM habitaciones 
    WHERE numero_habitacion = p_numero_habitacion;

    -- 3. Crear el registro base de la boleta de consumo inicial (Tabla 3)
    INSERT INTO boleta (fecha_emision, monto_total, id_reserva, dni_cliente, id_empleado)
    VALUES (CURRENT_TIMESTAMP, v_precio_habitacion, p_id_reserva, p_dni_cliente, p_id_empleado);

    -- Construir respuesta de éxito para PostgREST
    v_resultado := json_build_object(
        'status', 'success',
        'message', 'Check-in procesado correctamente en las 3 tablas.',
        'id_reserva', p_id_reserva,
        'habitacion_ocupada', p_numero_habitacion
    );

    RETURN v_resultado;

EXCEPTION
    WHEN OTHERS THEN
        RETURN json_build_object(
            'status', 'error',
            'message', SQLERRM
        );
END;
$$ LANGUAGE plpgsql;

--otra cosa
CREATE OR REPLACE FUNCTION registrar_consumo_transaccional(
    p_id_reserva INT,
    p_detalle TEXT,
    p_monto DECIMAL(10,2)
) RETURNS JSON AS $$
BEGIN
    -- 1. Insertamos el consumo (Acción A)
    INSERT INTO restaurante_consumos (detalle_pedido, monto_consumo, id_reserva, fecha_hora)
    VALUES (p_detalle, p_monto, p_id_reserva, CURRENT_TIMESTAMP);

    -- Nota: Si usaras una tabla de inventarios, aquí harías el UPDATE del stock.

    RETURN json_build_object('status', 'success', 'message', 'Transacción completada con COMMIT.');
EXCEPTION
    WHEN OTHERS THEN
        -- PostgreSQL hace ROLLBACK automático si algo falla dentro del bloque
        RETURN json_build_object('status', 'error', 'message', SQLERRM);
END;
$$ LANGUAGE plpgsql;