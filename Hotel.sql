



















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
