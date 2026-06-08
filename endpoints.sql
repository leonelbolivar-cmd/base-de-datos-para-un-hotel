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
