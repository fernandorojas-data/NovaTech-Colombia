
-- Top productos


SELECT TOP 10
    p.producto,
    SUM(v.cantidad) AS Cantidad_Vendida
FROM Ventas_Import v
INNER JOIN Productos_Import p
    ON v.id_producto = p.id_producto
GROUP BY p.producto
ORDER BY Cantidad_Vendida DESC;



select*
from Productos_Import;
select*
from Ventas_Import;

	