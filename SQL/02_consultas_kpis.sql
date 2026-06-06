use NovaTechColombia
go

--- -- Ticket Promedio

select 
	SUM(cantidad * precio_unitario * (1 - descuento / 100.0))
	AS ventas_totales
from Ventas_Import;



-- Venta Promedio por Cliente
SELECT
    SUM(cantidad * precio_unitario * (1 - descuento/100.0))
    / COUNT(DISTINCT id_cliente) AS Venta_Promedio_Cliente
FROM Ventas_Import;


-- Top Clientes por Facturación
SELECT TOP 10
    c.nombre,
    c.apellido,
    SUM(
        v.cantidad * v.precio_unitario *
        (1 - v.descuento/100.0)
    ) AS Facturacion
FROM Ventas_Import v
INNER JOIN Clientes c
    ON v.id_cliente = c.id_cliente
GROUP BY
    c.nombre,
    c.apellido
ORDER BY Facturacion DESC;


-- Ventas por Ciudad

SELECT
    c.ciudad,
    SUM(
        v.cantidad * v.precio_unitario *
        (1 - v.descuento/100.0)
    ) AS Ventas
FROM Ventas_Import v
INNER JOIN Clientes c
    ON v.id_cliente = c.id_cliente
GROUP BY c.ciudad
ORDER BY Ventas DESC;


-- Ventas por Categoría
SELECT
    p.categoria,
    SUM(
        v.cantidad * v.precio_unitario *
        (1 - v.descuento/100.0)
    ) AS Ventas
FROM Ventas_Import v
INNER JOIN Productos_Import p
    ON v.id_producto = p.id_producto
GROUP BY p.categoria
ORDER BY Ventas DESC;



--- -- Total Transacciones
select COUNT(*)
from Ventas_Import;

-- -- Clientes Únicos
select 
	COUNT(distinct id_cliente)
from Ventas_Import;




