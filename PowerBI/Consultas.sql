-- ====================================
--		  Ventas por Categoría
-- ====================================

SELECT
    p.categoria,

    SUM(
        v.cantidad *
        v.precio_unitario *
        (1 - v.descuento/100.0)
    ) AS Ventas

FROM Ventas_Import v

INNER JOIN Productos_Import p
    ON v.id_producto = p.id_producto

GROUP BY p.categoria

ORDER BY Ventas DESC;


-- ====================================
--	Top 10 Productos por Facturación
-- ====================================

SELECT TOP 10
    p.producto,

    SUM(
        v.cantidad *
        v.precio_unitario *
        (1 - v.descuento/100.0)
    ) AS Ventas

FROM Ventas_Import v

INNER JOIN Productos_Import p
    ON v.id_producto = p.id_producto

GROUP BY p.producto

ORDER BY Ventas DESC;

-- ====================================
--    Ventas por Segmento de Cliente
-- ====================================

SELECT
    c.segmento_cliente,

    SUM(
        v.cantidad *
        v.precio_unitario *
        (1 - v.descuento/100.0)
    ) AS Ventas

FROM Ventas_Import v

INNER JOIN Clientes c
    ON v.id_cliente = c.id_cliente

GROUP BY c.segmento_cliente

ORDER BY Ventas DESC;