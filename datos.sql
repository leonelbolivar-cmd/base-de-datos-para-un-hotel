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


--Modulo 2--

INSERT INTO convenios(empresa_asociada, porcentaje_descuento)
VALUES
("Banco Continental", 10.00),
("Banco Intercontinental", 15.50),
("Universidad Nacional", 20.00),
("Ministerio de Salud", 12.75),
("Aerolíneas Latam", 18.00);

UPDATE convenios
SET porcentaje_descuento = 15.00
WHERE id_convenio = 1;

INSERT INTO cliente(dni_cliente, nombre_completo, telefono, email, id_convenio)
VALUES
("70123456", "Carlos Mendoza Pantigoso", "987654321", "carlos@gmail.com", 1),
("71234567", "Armando Banco Torres", "998877665", "armando@gmail.com", 2),
("72345678", "Cristian Castro Diaz", "955443322", "cristian@gmail.com", 3),
("73456789", "Mariana López Díaz", "966112233", "mariana@gmail.com", 4),
("74567890", "José Juan Vega", "977889900", "jose@gmail.com", 5);

UPDATE cliente
SET telefono = "999888777"
WHERE dni_cliente = "70123456";


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
