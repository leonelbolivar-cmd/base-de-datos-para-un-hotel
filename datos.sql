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
