-- ====================================
-- Proyecto: NovaTech Colombia
-- Autor: Fernando Rojas
-- Descripción: Creación de tablas del modelo de ventas
-- ====================================


CREATE DATABASE NovaTechColombia;
GO

USE NovaTechColombia;
GO



-----------------------------------------------------------------------------------------------
-- ************************************ Creación de tablas ************************************
-----------------------------------------------------------------------------------------------

-- Crear tabla Clientes

SELECT TOP 5 *
FROM Clientes;
CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    sexo CHAR(1),
    edad INT,
    ciudad VARCHAR(100),
    fecha_registro DATE,
    segmento_cliente VARCHAR(50)
);

-- Crear tabla Productos

CREATE TABLE Productos (
    id_producto INT PRIMARY KEY,
    producto VARCHAR(100),
    categoria VARCHAR(100),
    marca VARCHAR(100),
    precio_base DECIMAL(18,2)
);


-- Crear tabla Ventas

CREATE TABLE Ventas (
    id_venta INT PRIMARY KEY,
    fecha DATE,
    id_cliente INT,
    id_producto INT,
    cantidad INT,
    precio_unitario DECIMAL(18,2),
    descuento DECIMAL(5,2),
    metodo_pago VARCHAR(50),
    canal_venta VARCHAR(50)
);





select *
from Ventas;


SELECT COUNT(*) AS Total_Clientes
FROM Clientes;

SELECT COUNT(*) AS Total_Productos
FROM Productos_Import;

SELECT COUNT(*) AS Total_Ventas
FROM Ventas_Import;






-----------------------------------------------------------------------------------------------
-- ******************************** Primera consulta de negocio ********************************
-----------------------------------------------------------------------------------------------

------------------------------------ 1. Ventas Totales
select
    SUM(cantidad * precio_unitario * (1 - descuento/100.0))
    AS ventas_totales
from Ventas_Import;



------------------------------------ 2. Ventas por Canal
select
    canal_venta,
    COUNT(*) AS Total_Transacciones
from Ventas_Import
group by canal_venta
order by Total_Transacciones desc;

------------------------------------ 3. Top 10 Productos Más Vendidos
select top 10
    id_producto,
    SUM(cantidad) AS Cantidad_vendidad
from Ventas_Import
group by id_producto
order by Cantidad_vendidad desc;


------------------------------------ Primera consulta con JOIN ------------------------------------
select top 10
    p.producto,
    p.categoria,
    SUM(v.cantidad) AS Cantidad_vendida
from Ventas_Import v
inner join Productos_Import p
    on p.id_producto = v.id_producto
group by
    p.producto,
    p.categoria
order by Cantidad_vendida desc;

-----------------------------------------------------------------------------------------------
-- ****************************** Top 10 Clientes por Facturación *****************************
-----------------------------------------------------------------------------------------------


-- Top 10 Clientes por Facturación
select top 10
            c.id_cliente,
            c.nombre,
            c.apellido,
            SUM(v.cantidad * v.precio_unitario * (1 * v.descuento / 100.0))
            AS Facturación
from Ventas_Import v
inner join Clientes c
    on c.id_cliente = v.id_cliente
group by c.id_cliente,
        c.nombre,
        c.apellido
order by Facturación desc;

--Ventas por Ciudad
select
        c.ciudad,
        sum(v.cantidad * v.precio_unitario * (1 * v.descuento / 100.0)) AS ventar_por_ciudad
from Ventas_Import v
inner join Clientes c
    on v.id_cliente = c.id_cliente
group by c.ciudad
order by ventar_por_ciudad desc;

-- Ventas por Categoría
select 
        p.categoria,
        SUM(v.cantidad * v.precio_unitario * (1 - v.descuento/100.0))
        AS Ventas_por_Categoría
from Ventas_Import v
inner join Productos p
    on v.id_cliente = p.id_producto
group by p.categoria
order by Ventas_por_Categoría;




