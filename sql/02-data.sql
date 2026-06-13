-- ==========================================
-- Modulo 1: ESTRUCTURA INTERNA Y PERSONAL
-- ==========================================

INSERT INTO departamentos (id_departamento, nombre_area, anexo_telefonico) VALUES 
  (10, 'Cocina', '101'),
  (20, 'Administracion', '102'),
  (30, 'Limpieza', '103'),
  (40, 'Seguridad', '104'),
  (50, 'Guardería', '106'); 

INSERT INTO empleados (id_empleado, nombre_completo, cargo, turno, id_departamento, id_jefe_directo) VALUES
  (1, 'Miguel Velazquez Vega', 'Chef', 'Mañana', 10, NULL),
  (2, 'Ángel Auxilio Mena', 'Vigilante', 'Noche', 40, NULL),
  (3, 'Paco Vega Osmos', 'Vigilante', 'Mañana', 40, 2), 
  (4, 'Susana Oria Ramos', 'Recepcionista', 'Mañana', 20, NULL),
  (5, 'Tomas Castelo Pishy', 'Conserje', 'Tarde', 30, NULL);


-- ==========================================
-- Modulo 2: CLIENTES Y RESERVAS (NUEVO COMPLETADO)
-- ==========================================

INSERT INTO convenios(id_convenio, empresa_asociada, porcentaje_descuento) VALUES
  (1, 'Banco Continental', 15.00), 
  (2, 'Banco Intercontinental', 15.50),
  (3, 'Universidad Nacional', 20.00),
  (4, 'Ministerio de Salud', 12.75),
  (5, 'Aerolíneas Latam', 18.00);

INSERT INTO cliente(dni_cliente, nombre_completo, telefono, email, id_convenio) VALUES
  ('70123456', 'Carlos Mendoza Pantigoso', '999888777', 'carlos@gmail.com', 1), 
  ('71234567', 'Armando Banco Torres', '998877665', 'armando@gmail.com', 2),
  ('72345678', 'Cristian Castro Diaz', '955443322', 'cristian@gmail.com', 3),
  ('73456789', 'Mariana López Díaz', '966112233', 'mariana@gmail.com', 4),
  ('74567890', 'José Juan Vega', '977889900', 'jose@gmail.com', 5),
  ('75000001', 'Rodrigo Lovon', '988111222', 'rodrigo.lovon@email.com', NULL),
  ('75000002', 'Dugan Paul Nina Ortiz', '988333444', 'dugan.nina@email.com', 3);

INSERT INTO habitaciones(numero_habitacion, tipo_habitacion, capacidad_personas, precio_base_noche, estado_habitacion) VALUES
  ('101', 'Sencilla', 1, 120.00, 'Disponible'),
  ('102', 'Doble', 2, 200.00, 'Ocupada'),
  ('103', 'Matrimonial', 2, 250.00, 'Ocupada'),
  ('104', 'Familiar', 4, 350.00, 'Disponible'),
  ('105', 'Suite', 2, 500.00, 'Mantenimiento'),
  ('205B', 'Suite Doble', 4, 450.00, 'Ocupada');


INSERT INTO reserva(id_reserva, fecha_checkin, fecha_checkout, estado, dni_cliente, numero_habitacion) VALUES
  (2, '2026-06-01', '2026-06-05', 'Finalizada', '70123456', '101'),
  (4, '2026-06-10', '2026-06-15', 'Confirmada', '71234567', '102'),
  (5, '2026-06-12', '2026-06-18', 'Confirmada', '72345678', '103'),
  (101, '2026-06-01', '2026-06-10', 'Finalizada', '73456789', '104'),
  (102, '2026-06-05', '2026-06-08', 'Finalizada', '74567890', '105'),
  (103, '2026-06-15', '2026-06-20', 'Confirmada', '75000001', '205B'),
  (104, '2026-06-20', '2026-06-25', 'Confirmada', '75000002', '101'),
  (105, '2026-05-20', '2026-05-25', 'Finalizada', '75000001', '102');


-- ==========================================
-- Modulo 3: LOGISTICA Y OPERACIONES (COMPLETADO)
-- ==========================================

INSERT INTO proveedores(ruc_proveedor, razon_social, telefono_contacto) VALUES
  ('201547610', 'MANUEL', '959342123'),
  ('210234821', 'Distribuidora Rico Tambo E.I.R.L.', '932746428'),
  ('204127447', 'Transportes Canael E.I.R.L.', '932753104'),
  ('204871246', 'DIEGO', '932141241'),
  ('202384724', 'ADT Logistica', '976124320');

INSERT INTO almacen_productos(id_producto, nombre_producto, cantidad_stock, ruc_proveedor) VALUES
  (20, 'PESCADO', 20, '201547610'), 
  (23, 'DESINFECTANTES', 145, '210234821'),
  (12, 'TELEVISORES', 200, '204127447'),
  (14, 'CHAMPAÑA', 235, '204871246'),
  (1, 'COPAS', 401, '202384724');

INSERT INTO movimientos_almacen(id_producto, id_empleado, cantidad, tipo_movimiento, fecha_movimiento) VALUES
  (20, 1, 5, 'Salida', CURRENT_TIMESTAMP),
  (23, 5, 10, 'Salida', CURRENT_TIMESTAMP),
  (14, 4, 50, 'Ingreso', CURRENT_TIMESTAMP);

INSERT INTO presupuestos(monto_asignado, fecha_inicio, fecha_fin, id_departamento) VALUES
  (15000.00, '2026-01-01', '2026-12-31', 10),
  (8000.00, '2026-01-01', '2026-12-31', 30);

INSERT INTO mantenimiento_tareas(descripcion_trabajo, fecha_realizacion, id_empleado, numero_habitacion) VALUES
  ('Reparación de aire acondicionado', '2026-06-10', 5, '105'),
  ('Pintura de paredes', '2026-06-11', 5, '205B');


-- ==========================================
-- Modulo 4: SERVICIOS ADICIONALES (COMPLETADO)
-- ==========================================

INSERT INTO restaurante_consumos(id_consumo, detalle_pedido, monto_consumo, fecha_hora, id_reserva, id_empleado) VALUES 
  (1, 'bebidas', 15.00, CURRENT_TIMESTAMP, 2, 3),   
  (2, 'plato de fondo', 42.00, CURRENT_TIMESTAMP, 2, 3),  
  (3, 'postres', 20.00, CURRENT_TIMESTAMP, 4, 1),      
  (4, 'entradas', 30.00, CURRENT_TIMESTAMP, 5, 2),        
  (5, 'cafetería', 12.00, CURRENT_TIMESTAMP, 2, 3);       

INSERT INTO guarderia_registros(id_registro_guarderia, nombre_nino, hora_ingreso, hora_salida, id_reserva, id_empleado) VALUES
  (1, 'Mateo Benavides', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 101, 5), 
  (2, 'Valentina Paz', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 102, 5),       
  (3, 'Thiago Sosa', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 103, 3), 
  (4, 'Sofía Méndez', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 104, 2),        
  (5, 'Lucas Torres', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, 105, 1); 


INSERT INTO cochera(numero_estacionamiento, placa_vehiculo, id_reserva) VALUES
  ('A-01', 'V7B-123', 2),
  ('A-02', 'F3C-456', 101);

INSERT INTO eventos(nombre_evento, fecha_evento, costo_alquiler, id_reserva, id_empleado) VALUES
  ('Matrimonio Civil', '2026-06-15', 1200.00, 4, 4),
  ('Conferencia Empresarial', '2026-06-20', 800.00, 103, 4);


-- ==========================================
-- Modulo 5: FACTURACIÓN (NUEVO COMPLETADO)
-- ==========================================
INSERT INTO boleta(fecha_emision, monto_total, id_reserva, dni_cliente, id_empleado) VALUES
  (CURRENT_TIMESTAMP, 542.00, 2, '70123456', 4),  
  (CURRENT_TIMESTAMP, 3150.00, 101, '73456789', 4), 
  (CURRENT_TIMESTAMP, 1500.00, 102, '74567890', 4), 
  (CURRENT_TIMESTAMP, 1000.00, 105, '75000001', 4); 

-- ==========================================
-- Sincronizar secuencias (Crucial en PostgreSQL)
-- Al forzar IDs manualmente, debemos avisarle a la BD dónde continuar
-- ==========================================
SELECT setval('reserva_id_reserva_seq', (SELECT MAX(id_reserva) FROM reserva));
SELECT setval('departamentos_id_departamento_seq', (SELECT MAX(id_departamento) FROM departamentos));