



















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
