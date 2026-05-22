-- Modulo 1: ESTRUCTURA INTERNA Y PERSONAL

CREATE TABLE departamentos (
    id_departamento SERIAL,
    nombre_area VARCHAR(100) NOT NULL,
    anexo_telefonico VARCHAR(10),
    
    CONSTRAINT pk_departamentos PRIMARY KEY (id_departamento)
);

CREATE TABLE empleados (
    id_empleado SERIAL,
    nombre_completo VARCHAR(150) NOT NULL,
    cargo VARCHAR(50),
    turno VARCHAR(20),
    id_departamento INT,
    id_jefe_directo INT,
    
    CONSTRAINT pk_empleados PRIMARY KEY (id_empleado),
    
    CONSTRAINT fk_empleados_departamentos FOREIGN KEY (id_departamento) REFERENCES departamentos(id_departamento),
    CONSTRAINT fk_empleados_jefe FOREIGN KEY (id_jefe_directo) REFERENCES empleados(id_empleado)
);


-- Modulo 2: CLIENTES Y RESERVAS

CREATE TABLE convenios (
    id_convenio SERIAL,
    empresa_asociada VARCHAR(100) NOT NULL,
    porcentaje_descuento DECIMAL(5,2) NOT NULL,
    
    CONSTRAINT pk_convenios PRIMARY KEY (id_convenio)
);

INSERT INTO convenios (empresa_asociada, porcentaje_descuento)
VALUES 
('Banco Continental', 10.00),
('Tech Solutions SAC', 15.50),
('Universidad Nacional', 20.00),
('Ministerio de Salud', 12.75),
('Aerolíneas Perú', 18.00);

UPDATE convenios
SET porcentaje_descuento = 25.00
WHERE id_convenio = 3;




CREATE TABLE cliente (
    dni_cliente VARCHAR(15),
    nombre_completo VARCHAR(150) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100),
    id_convenio INT,
    
    CONSTRAINT pk_cliente PRIMARY KEY (dni_cliente),
    CONSTRAINT fk_cliente_convenios FOREIGN KEY (id_convenio) REFERENCES convenios(id_convenio)
);

INSERT INTO cliente (dni_cliente, nombre_completo, telefono, email, id_convenio)
VALUES
('70123456', 'Carlos Mendoza Ruiz', '987654321', 'carlos@gmail.com', 1),
('71234567', 'Ana Torres Silva', '998877665', 'ana@gmail.com', 2),
('72345678', 'Luis Fernández Castro', '955443322', 'luis@gmail.com', 3),
('73456789', 'María López Díaz', '966112233', 'maria@gmail.com', 4),
('74567890', 'José Ramírez Vega', '977889900', 'jose@gmail.com', 5);


UPDATE cliente
SET telefono = '999888777'
WHERE dni_cliente = '70123456';



CREATE TABLE habitaciones (
    numero_habitacion VARCHAR(10),
    tipo_habitacion VARCHAR(50) NOT NULL,
    capacidad_personas INT NOT NULL,
    precio_base_noche DECIMAL(10,2) NOT NULL,
    
    CONSTRAINT pk_habitaciones PRIMARY KEY (numero_habitacion)
);

INSERT INTO habitaciones (numero_habitacion, tipo_habitacion, capacidad_personas, precio_base_noche)
VALUES
('101', 'Simple', 1, 120.00),
('102', 'Doble', 2, 180.00),
('201', 'Matrimonial', 2, 220.00),
('202', 'Suite', 4, 450.00),
('301', 'Familiar', 5, 550.00);

UPDATE habitaciones
SET precio_base_noche = 250.00
WHERE numero_habitacion = '201';



CREATE TABLE reserva (
    id_reserva SERIAL,
    fecha_checkin DATE NOT NULL,
    fecha_checkout DATE NOT NULL,
    estado VARCHAR(20) NOT NULL,
    dni_cliente VARCHAR(15),
    numero_habitacion VARCHAR(10),
    
    CONSTRAINT pk_reserva PRIMARY KEY (id_reserva),
    CONSTRAINT fk_reserva_cliente FOREIGN KEY (dni_cliente) REFERENCES cliente(dni_cliente),
    CONSTRAINT fk_reserva_habitaciones FOREIGN KEY (numero_habitacion) REFERENCES habitaciones(numero_habitacion)
);


INSERT INTO reserva (fecha_checkin, fecha_checkout, estado, dni_cliente, numero_habitacion)
VALUES
('2026-06-01', '2026-06-05', 'Confirmada', '70123456', '101'),
('2026-06-03', '2026-06-06', 'Pendiente', '71234567', '102'),
('2026-06-10', '2026-06-15', 'Confirmada', '72345678', '201'),
('2026-06-12', '2026-06-14', 'Cancelada', '73456789', '202'),
('2026-06-20', '2026-06-25', 'Confirmada', '74567890', '301');


UPDATE reserva
SET estado = 'Finalizada'
WHERE id_reserva = 1;


-- Modulo 3: Logistica y Operaciones


CREATE TABLE proveedores (
    ruc_proveedor VARCHAR(20),
    razon_social VARCHAR(150) NOT NULL,
    telefono_contacto VARCHAR(20),
    
    CONSTRAINT pk_proveedores PRIMARY KEY (ruc_proveedor)
);

CREATE TABLE almacen_productos (
    id_producto SERIAL,
    nombre_producto VARCHAR(100) NOT NULL,
    id_empleado INT,
    cantidad_stock INT NOT NULL,
    ruc_proveedor VARCHAR(20),
    
    CONSTRAINT pk_almacen_productos PRIMARY KEY (id_producto),
    CONSTRAINT fk_almacen_proveedores FOREIGN KEY (ruc_proveedor) REFERENCES proveedores(ruc_proveedor),
    CONSTRAINT fk_almacen_empleados FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);

CREATE TABLE presupuestos (
    id_presupuesto SERIAL,
    monto_asignado DECIMAL(12,2) NOT NULL,
    fecha_periodo VARCHAR(50),
    id_departamento INT,
    
    CONSTRAINT pk_presupuestos PRIMARY KEY (id_presupuesto),
    CONSTRAINT fk_presupuestos_departamentos FOREIGN KEY (id_departamento) REFERENCES departamentos(id_departamento)
);

CREATE TABLE mantenimiento_tareas (
    id_tarea SERIAL,
    descripcion_trabajo TEXT NOT NULL,
    fecha_realizacion DATE,
    id_empleado INT,
    numero_habitacion VARCHAR(10),
    
    CONSTRAINT pk_mantenimiento_tareas PRIMARY KEY (id_tarea),
    CONSTRAINT fk_mantenimiento_empleados FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    CONSTRAINT fk_mantenimiento_habitaciones FOREIGN KEY (numero_habitacion) REFERENCES habitaciones(numero_habitacion)
);

-- Modulo 4: SERVICIOS ADICIONALES 

CREATE TABLE restaurante_consumos (
    id_consumo SERIAL,
    detalle_pedido TEXT NOT NULL,
    monto_consumo DECIMAL(10,2) NOT NULL,
    fecha_hora TIMESTAMP,
    id_reserva INT,
    id_empleado INT,
    
    CONSTRAINT pk_restaurante_consumos PRIMARY KEY (id_consumo),
    CONSTRAINT fk_restaurante_reserva FOREIGN KEY (id_reserva) REFERENCES reserva(id_reserva),
    CONSTRAINT fk_restaurante_empleados FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);

CREATE TABLE guarderia_registros (
    id_registro_guarderia SERIAL,
    nombre_nino VARCHAR(100) NOT NULL,
    hora_ingreso TIMESTAMP,
    hora_salida TIMESTAMP,
    id_reserva INT,
    id_empleado INT,
    
    CONSTRAINT pk_guarderia_registros PRIMARY KEY (id_registro_guarderia),
    CONSTRAINT fk_guarderia_reserva FOREIGN KEY (id_reserva) REFERENCES reserva(id_reserva),
    CONSTRAINT fk_guarderia_empleados FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);

CREATE TABLE cochera (
    id_espacio SERIAL,
    numero_estacionamiento VARCHAR(10),
    placa_vehiculo VARCHAR(15),
    id_reserva INT,
    
    CONSTRAINT pk_cochera PRIMARY KEY (id_espacio),
    CONSTRAINT fk_cochera_reserva FOREIGN KEY (id_reserva) REFERENCES reserva(id_reserva)
);

CREATE TABLE eventos (
    id_evento SERIAL,
    nombre_evento VARCHAR(100) NOT NULL,
    fecha_evento DATE,
    costo_alquiler DECIMAL(10,2),
    dni_cliente VARCHAR(15),
    id_empleado INT,
    
    CONSTRAINT pk_eventos PRIMARY KEY (id_evento),
    CONSTRAINT fk_eventos_cliente FOREIGN KEY (dni_cliente) REFERENCES cliente(dni_cliente),
    CONSTRAINT fk_eventos_empleados FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);
-- Modulo 5: FACTURACIÓN

CREATE TABLE boleta (
    id_comprobante SERIAL,
    fecha_emision TIMESTAMP NOT NULL,
    monto_total DECIMAL(10,2) NOT NULL,
    id_reserva INT,
    dni_cliente VARCHAR(15),
    id_empleado INT,
    
    CONSTRAINT pk_boleta PRIMARY KEY (id_comprobante),
    CONSTRAINT fk_boleta_reserva FOREIGN KEY (id_reserva) REFERENCES reserva(id_reserva),
    CONSTRAINT fk_boleta_cliente FOREIGN KEY (dni_cliente) REFERENCES cliente(dni_cliente),
    CONSTRAINT fk_boleta_empleados FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);
