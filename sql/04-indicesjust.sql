--Consulta sin indice de reservas por cliente
EXPLAIN ANALYZE SELECT * FROM reserva
WHERE dni_cliente = '75000001';

--Se crea el indice 
CREATE INDEX idx_reserva_dni_cliente 
ON reserva(dni_cliente);

--Consulta luego del indice 
EXPLAIN ANALYZE SELECT * FROM reserva
WHERE dni_cliente = '75000001';

--Las reservas se consultan usualmene con el dni para ver reservas 
--y historial, el indice hace que localicemos los registros sin recorrer toa la tabla


--Consulta sin indice consumo de restaurante por reserva

EXPLAIN ANALYZE SELECT * FROM restaurante_consumos
WHERE id_reserva = 2;

--Creacion indice 
CREATE INDEX idx_restaurante_consumos_reserva
ON restaurante_consumos(id_reserva);

--Consulta luego del indice
EXPLAIN ANALYZE SELECT * FROM restaurante_consumos
WHERE id_reserva = 2;



--Consulta tareas mantenimiento 

EXPLAIN ANALYZE SELECT * FROM mantenimiento_tareas
WHERE id_empleado = 5;

--Creacion indice 
CREATE INDEX idx_mantenimiento_empleado
ON mantenimiento_tareas(id_empleado);

--consulta ddespues del indice

EXPLAIN ANALYZE
SELECT * FROM mantenimiento_tareas
WHERE id_empleado = 5;


--ACID

BEGIN;

--  disponibilidad y ocupar habitación
UPDATE habitaciones
SET estado_habitacion = 'Ocupada'
WHERE numero_habitacion = '104'
AND estado_habitacion = 'Disponible';

-- Registrar la reserva
INSERT INTO reserva (
    fecha_checkin,
    fecha_checkout,
    estado,
    dni_cliente,
    numero_habitacion
)
VALUES (
    '2026-07-01',
    '2026-07-05',
    'Confirmada',
    '75000002',
    '104'
);

COMMIT;


--ESTA RESERVA DA ERROR porq el dni 99999 no existe haciendo que se ejecuuta el rolback
DO $$
BEGIN
    -- 1. Intentamos cambiar el estado de la habitación
    UPDATE habitaciones
    SET estado_habitacion = 'Ocupada'
    WHERE numero_habitacion = '104';

    -- 2. Forzamos el error con un DNI que no existe
    INSERT INTO reserva (fecha_checkin, fecha_checkout, estado, dni_cliente, numero_habitacion)
    VALUES ('2026-07-01', '2026-07-05', 'Confirmada', '99999999', '104');

EXCEPTION
    WHEN foreign_key_violation THEN
        RAISE NOTICE 'Transacción abortada correctamente por violación de FK. ACID funcionando (ROLLBACK).';
END $$;