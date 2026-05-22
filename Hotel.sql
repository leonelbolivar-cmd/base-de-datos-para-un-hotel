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



CREATE TABLE cliente (
    dni_cliente VARCHAR(15),
    nombre_completo VARCHAR(150) NOT NULL,
    telefono VARCHAR(20),
    email VARCHAR(100),
    id_convenio INT,
    
    CONSTRAINT pk_cliente PRIMARY KEY (dni_cliente),
    CONSTRAINT fk_cliente_convenios FOREIGN KEY (id_convenio) REFERENCES convenios(id_convenio)
);


CREATE TABLE habitaciones (
    numero_habitacion VARCHAR(10),
    tipo_habitacion VARCHAR(50) NOT NULL,
    capacidad_personas INT NOT NULL,
    precio_base_noche DECIMAL(10,2) NOT NULL,
    
    CONSTRAINT pk_habitaciones PRIMARY KEY (numero_habitacion)
);




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
