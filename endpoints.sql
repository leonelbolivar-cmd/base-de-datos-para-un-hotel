SELECT 
    c.dni_cliente,
    c.nombre_completo ,
    COUNT(r.id_consumo) ,
    SUM(r.monto_consumo) AS "gasto_consumo" 
FROM cliente c
INNER JOIN reserva r ON c.dni_cliente = r.dni_cliente
INNER JOIN restaurante_consumos r ON c.id_reserva = r.id_reserva
GROUP BY c.dni_cliente, c.nombre_completo
HAVING COUNT(r.id_consumo) >= 3 -- Condición avanzada: clientes que consumen frecuentemente
ORDER BY "Gasto_consumo" DESC;


SELECT 
    h.tipo_habitacion ,
    COUNT(r.id_reserva) ,
    SUM(b.monto_total) AS 'Ingresos_totales'
FROM habitaciones h
INNER JOIN reserva r ON h.numero_habitacion = r.numero_habitacion
INNER JOIN boleta b ON r.id_reserva = b.id_reserva
WHERE r.estado = 'Finalizada' 
GROUP BY h.tipo_habitacion
HAVING SUM(b.monto_total) > 500.00
ORDER BY 'Ingresos_totales'DESC;
