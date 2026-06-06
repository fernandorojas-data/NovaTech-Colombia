-- ====================================
-- Top 10 clientes por facturación
-- ====================================

WITH RankingClientes AS
(
    SELECT
        c.id_cliente,
        c.nombre,
        c.apellido,

        SUM(
            v.cantidad *
            v.precio_unitario *
            (1 - v.descuento/100.0)
        ) AS Facturacion,

        ROW_NUMBER() OVER(
            ORDER BY
            SUM(
                v.cantidad *
                v.precio_unitario *
                (1 - v.descuento/100.0)
            ) DESC
        ) AS Ranking

    FROM Ventas_Import v

    INNER JOIN Clientes c
        ON v.id_cliente = c.id_cliente

    GROUP BY
        c.id_cliente,
        c.nombre,
        c.apellido
)

SELECT *
FROM RankingClientes
WHERE Ranking <= 10;



-- ====================================
--         Ranking por Ciudad
-- ====================================

WITH RankingCiudades AS
(
    SELECT
        c.ciudad,

        SUM(
            v.cantidad *
            v.precio_unitario *
            (1 - v.descuento/100.0)
        ) AS Ventas,

        ROW_NUMBER() OVER(
            ORDER BY
            SUM(
                v.cantidad *
                v.precio_unitario *
                (1 - v.descuento/100.0)
            ) DESC
        ) AS Ranking

    FROM Ventas_Import v

    INNER JOIN Clientes c
        ON v.id_cliente = c.id_cliente

    GROUP BY c.ciudad
)

SELECT *
FROM RankingCiudades;



-- ====================================
--    Participación por Canal (%)
-- ====================================

SELECT
    canal_venta,

    SUM(
        cantidad *
        precio_unitario *
        (1 - descuento/100.0)
    ) AS Ventas,

    ROUND(
        100.0 *
        SUM(
            cantidad *
            precio_unitario *
            (1 - descuento/100.0)
        )
        /
        SUM(
            SUM(
                cantidad *
                precio_unitario *
                (1 - descuento/100.0)
            )
        ) OVER(),
        2
    ) AS Porcentaje
FROM Ventas_Import

GROUP BY canal_venta;