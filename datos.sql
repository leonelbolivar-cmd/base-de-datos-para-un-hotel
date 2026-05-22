-- Modulo 1: ESTRUCTURA INTERNA Y PERSONAL

INSERT INTO departamentos (id_departamento, nombre_area, anexo_telefonico)
VALUES 
  (10, 'Cocina', '101'),
  (20, 'Administracion', '102'),
  (30, 'Limpieza', '103'),
  (40, 'Seguridad', '104'),
  (50, 'Guardería', '105');


INSERT INTO empleados (id_empleado, nombre_completo, cargo, turno, id_departamento, id_jefe_directo)
VALUES
  (1, 'Miguel Velazquez Vega', 'Chef', 'Mañana', 10, 5),
  (2, 'Ángel Auxilio Mena', 'Vigilante', 'Noche', 40, 3),
  (3, 'Paco Vega Osmos', 'Vigilante', 'Mañana', 40, NULL),
  (4, 'Susana Oria Ramos', 'Recepcionista', 'Mañana', 20, 6),
  (5, 'Tomas Castelo Pishy', 'Conserje', 'Tarde', 30, 7);
UPDATE empleados
SET id_empleado = 60, anexo_telefonico = '106'
WHERE id_empleado = 50 AND anexo_telefonico = '105';

--Modulo 3--

INSERT INTO proveedores(ruc_proveedor,razon_social,telefono_contacto)
VALUES
("201547610","MANUEL","959342123"),
("210234821","EDUARDO","932746428"),
("204127447","LOVON","932753104"),
("204871246","DIEGO","932141241"),
("202384724","TAM","976124320");
INSERT INTO almacen_productos(id_producto,nombre_producto,id_empleado,cantidad_stock,ruc_proveeedor)
VALUES
("20","PESCADO",3,23,"201547610"),
("23","DESINFECTANTES",5,145,"210234821"),
("12","TELEVISORES",3,200,"204127447"),
("14","CHAMPAÑA",1,235,"204871246"),
("1","COPAS",1,401,"202384724");
 UPDATE almacen_productos
SET cantidad_stock=20
where id_producto=20;
