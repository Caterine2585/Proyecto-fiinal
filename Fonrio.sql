-- DDL
-- Creación de la base de datos
-- Creación de las tablas y sus atributos

-- Creación de la base de datos

CREATE TABLE Estados (
    ID_Estado VARCHAR(20) PRIMARY KEY,
    Nombre_Estado VARCHAR(15) NOT NULL
);


CREATE TABLE Roles (
    ID_Rol VARCHAR(20) PRIMARY KEY,
    Nombre VARCHAR(30) NOT NULL
);


CREATE TABLE Categorias (
    ID_Categoria VARCHAR(20) PRIMARY KEY,
    Nombre_Categoria VARCHAR(30) NOT NULL
);


CREATE TABLE Gamas (
    ID_Gama VARCHAR(20) PRIMARY KEY,
    Nombre_Gama VARCHAR(15) NOT NULL
);


CREATE TABLE Proveedores (
    ID_Proveedor VARCHAR(20) PRIMARY KEY,
    Nombre_Proveedor VARCHAR(45) NOT NULL,
    Correo_Electronico VARCHAR(30) UNIQUE NOT NULL,
    Telefono VARCHAR(15) NOT NULL,
    ID_Estado VARCHAR(20) NOT NULL,
    FOREIGN KEY (ID_Estado) REFERENCES Estados(ID_Estado)
);


CREATE TABLE Clientes (
    Documento_Cliente VARCHAR(20) PRIMARY KEY,
    Nombre_Cliente VARCHAR(20) NOT NULL,
    Apellido_Cliente VARCHAR(20) NOT NULL,
    Telefono VARCHAR(15) NOT NULL,
    Fecha_Nacimiento DATE NOT NULL,
    Genero CHAR(1) CHECK (Genero IN ('F','M')) NOT NULL,
    ID_Estado VARCHAR(20) NOT NULL,
    FOREIGN KEY (ID_Estado) REFERENCES Estados(ID_Estado)
);


CREATE TABLE Empleados (
    Documento_Empleado VARCHAR(20) PRIMARY KEY,
    Nombre_Usuario NVARCHAR(30) NOT NULL,
    Apellido_Usuario NVARCHAR(30) NOT NULL,
    Contrasena VARCHAR(20) NOT NULL,
    Correo_Electronico VARCHAR(100) UNIQUE NOT NULL,
    Telefono VARCHAR(10) NOT NULL,
    Genero CHAR(1) CHECK (Genero IN ('F','M')) NOT NULL,
    ID_Estado VARCHAR(20) NOT NULL,
    ID_Rol VARCHAR(20) NOT NULL,
    FOREIGN KEY (ID_Estado) REFERENCES Estados(ID_Estado),
    FOREIGN KEY (ID_Rol) REFERENCES Roles(ID_Rol)
);

CREATE TABLE Contrasenas (
    ID_Contrasena INT IDENTITY(1,1) PRIMARY KEY,
    Documento_Empleado VARCHAR(20) UNIQUE NOT NULL,
    Contrasena_Hash VARCHAR(255) NOT NULL,
    Fecha_Creacion DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (Documento_Empleado) REFERENCES Empleados(Documento_Empleado)
);

CREATE TABLE Productos (
    ID_Producto VARCHAR(20) PRIMARY KEY,
    Nombre_Producto VARCHAR(30) NOT NULL,
    Descripcion TEXT NOT NULL,
    Precio_Venta MONEY NOT NULL,
    Stock_Minimo INT NOT NULL,
    ID_Categoria VARCHAR(20) NOT NULL,
    ID_Estado VARCHAR(20) NOT NULL,
    ID_Gama VARCHAR(20) NOT NULL,
    FOREIGN KEY (ID_Categoria) REFERENCES Categorias(ID_Categoria),
    FOREIGN KEY (ID_Estado) REFERENCES Estados(ID_Estado),
    FOREIGN KEY (ID_Gama) REFERENCES Gamas(ID_Gama)
);


CREATE TABLE Compras (
    ID_Entrada VARCHAR(20) PRIMARY KEY,
    Precio_Compra MONEY NOT NULL,
    ID_Producto VARCHAR(20) NOT NULL,
    Documento_Empleado VARCHAR(20) NOT NULL,
    FOREIGN KEY (ID_Producto) REFERENCES Productos(ID_Producto),
    FOREIGN KEY (Documento_Empleado) REFERENCES Empleados(Documento_Empleado)
);


CREATE TABLE Detalle_Compras (
    Fecha_Entrada DATE NOT NULL,
    Cantidad INT NOT NULL,
    ID_Proveedor VARCHAR(20) NOT NULL,
    ID_Entrada VARCHAR(20) NOT NULL,
    FOREIGN KEY (ID_Proveedor) REFERENCES Proveedores(ID_Proveedor),
    FOREIGN KEY (ID_Entrada) REFERENCES Compras(ID_Entrada)
);


CREATE TABLE Ventas (
    ID_Venta VARCHAR(20) PRIMARY KEY,
    Documento_Cliente VARCHAR(20) NOT NULL,
    Documento_Empleado VARCHAR(20) NOT NULL,
    FOREIGN KEY (Documento_Cliente) REFERENCES Clientes(Documento_Cliente),
    FOREIGN KEY (Documento_Empleado) REFERENCES Empleados(Documento_Empleado)
);


CREATE TABLE Detalle_Ventas (
    Cantidad INT NOT NULL,
    Fecha_Salida DATE NOT NULL,
    ID_Producto VARCHAR(20) NOT NULL,
    ID_Venta VARCHAR(20) NOT NULL,
    FOREIGN KEY (ID_Producto) REFERENCES Productos(ID_Producto),
    FOREIGN KEY (ID_Venta) REFERENCES Ventas(ID_Venta)
);


CREATE TABLE Detalle_Devoluciones (
    ID_Devolucion VARCHAR(20) PRIMARY KEY,
    Cantidad_Devuelta INT NOT NULL,
    ID_Venta VARCHAR(20) NOT NULL,
    FOREIGN KEY (ID_Venta) REFERENCES Ventas(ID_Venta)
);


CREATE TABLE Devoluciones (
    ID_Devolucion VARCHAR(20) PRIMARY KEY,
    Fecha_Devolucion DATE NOT NULL,
    FOREIGN KEY (ID_Devolucion) REFERENCES Detalle_Devoluciones(ID_Devolucion)
);


--DML  Inserción de datos en las tablas

INSERT INTO Estados (ID_Estado, Nombre_Estado) VALUES
('EST001', 'Activo'),
('EST002', 'Inactivo'),
('EST003', 'En proceso');


INSERT INTO Roles (ID_Rol, Nombre) VALUES
('ROL001', 'Administrador'),
('ROL002', 'Empleado');


INSERT INTO Categorias (ID_Categoria, Nombre_Categoria) VALUES
('CAT001', 'Celulares'),
('CAT002', 'Cargadores'),
('CAT003', 'Audifonos'),
('CAT004', 'Forros'),
('CAT005', 'Strap_Phone');


INSERT INTO Gamas (ID_Gama, Nombre_Gama) VALUES
('GAM001', 'Baja'),
('GAM002', 'Media'),
('GAM003', 'Alta'),
('GAM004', 'Media'),
('GAM005', 'Alta');

-- Elimina las gamas con ID GAM004 y GAM005 de la tabla Gamas
DELETE FROM Gamas
WHERE ID_Gama IN ('GAM004', 'GAM005');



INSERT INTO Proveedores(ID_Proveedor,Nombre_Proveedor,Correo_electronico,Telefono,ID_Estado) VALUES
('PROV001', 'Claro_Colombia', 'Claro1@proveedor.com', '3012345678', 'EST001'),
('PROV002', 'Alkosto', 'Alkosto@proveedor.com', '3023456789', 'EST001'),
('PROV003', 'Éxito', 'Éxito@proveedor.com', '3034567890', 'EST002'),
('PROV004', 'Mercado_Libre', 'Mercado_Libre@proveedor.com', '3045678901', 'EST001'),
('PROV005', 'Accesorios_Colombia', 'Accesorios@proveedor.com', '3056789012', 'EST003');


INSERT INTO Clientes(Documento_Cliente,Nombre_Cliente,Apellido_Cliente,Telefono,Fecha_Nacimiento,Genero,ID_Estado ) VALUES
('CLI006', 'Juan', 'Pérez', '3144574273', '1990-05-10', 'M', 'EST001'),
('CLI007', 'Ana', 'Gómez', '3144574272', '1985-03-15', 'F', 'EST001'),
('CLI008', 'Luis', 'Ramírez', '3124574271', '2000-07-20', 'M', 'EST002'),
('CLI009', 'Carla', 'López', '3144774271', '1998-12-01', 'F', 'EST001'),
('CLI010', 'Alex', 'Moreno', '3144574275', '1995-09-30', 'M', 'EST003');

INSERT INTO Empleados(Documento_Empleado,Nombre_Usuario,Apellido_Usuario,Contrasena,Correo_electronico,Telefono,Genero,ID_Estado,ID_Rol) VALUES
('EMP006', 'Pedro', 'Cruz', '1234', 'pedrc@correo.com', '3023456784', 'M', 'EST001', 'ROL001'),
('EMP007', 'Lucía', 'Mendoza', 'abcd', 'luciaa@correo.com', '3023456781', 'F', 'EST001', 'ROL002'),
('EMP008', 'Miguel', 'Ortiz', 'pass', 'miguell@correo.com', '3023406789', 'M', 'EST002', 'ROL002'),
('EMP009', 'Paula', 'Reyes', 'clave', 'paulaa@correo.com', '3023454789', 'F', 'EST001', 'ROL001'),
('EMP010', 'Chris', 'Vega', 'test', 'chriss@correo.com', '3013456789', 'F', 'EST003', 'ROL002');

-- Eliminar columna Contrasena (si existe)
ALTER TABLE Empleados DROP COLUMN Contrasena;

INSERT INTO Contrasenas (Documento_Empleado, Contrasena_Hash)
VALUES
('EMP006', '1234'),
('EMP007', 'abcd'),
('EMP008', 'pass'),
('EMP009', 'clave'),
('EMP010', 'test');

-- Actualización para hashear las contraseñas
UPDATE Contrasenas
SET Contrasena_Hash = CONVERT(VARCHAR(255), HASHBYTES('SHA2_256', Contrasena_Hash), 2);

INSERT INTO Productos(ID_Producto,Nombre_Producto,Descripcion,Precio_Venta,Stock_Minimo,ID_Categoria,ID_Estado,ID_Gama) VALUES
('PROD006', 'Redmi Note 12', 'Celular Xiaomi gama media con buena batería', 850000, 5, 'CAT001', 'EST001','GAM001'),
('PROD007', 'Motorola G60', 'Smartphone Motorola con cámara de 108MP', 950000, 4, 'CAT001', 'EST001','GAM001'),
('PROD008', 'Samsung A54', 'Celular Samsung gama media-alta', 1250000, 6, 'CAT001', 'EST001','GAM001'),
('PROD009', 'iPhone 13', 'iPhone 13 de 128GB', 3300000, 2, 'CAT001', 'EST001','GAM001'),
('PROD010', 'Cargador Tipo C', 'Cargador rápido universal tipo C', 50000, 10, 'CAT002', 'EST001','GAM001');


INSERT INTO Compras(ID_Entrada,Precio_Compra,ID_Producto,Documento_Empleado ) VALUES
('COM001',  300000,  'PROD006', 'EMP006'),
('COM002',  60000,  'PROD007', 'EMP007'),
('COM003',  500000,  'PROD008', 'EMP008'),
('COM004',  1500000,  'PROD009', 'EMP009'),
('COM005',  200000,  'PROD010', 'EMP010');

INSERT INTO Detalle_Compras(Cantidad,ID_Entrada,Fecha_Entrada,ID_Proveedor ) VALUES
(10,  'COM001','2025-02-01','PROV001'),
(15, 'COM002','2025-03-04','PROV002'),
(20,  'COM003','2025-12-05','PROV003'),
(5,   'COM004','2025-10-11','PROV004'),
(8,  'COM005','2025-9-12','PROV005');


INSERT INTO Ventas(ID_Venta,Documento_Cliente,Documento_Empleado)VALUES
('VEN001',  'CLI006', 'EMP006'),
('VEN002',  'CLI007', 'EMP007'),
('VEN003',  'CLI008', 'EMP008'),
('VEN004',  'CLI009', 'EMP009'),
('VEN005',  'CLI010', 'EMP010');


INSERT INTO Detalle_Ventas(Cantidad,ID_Producto,ID_Venta, Fecha_Salida ) VALUES
(2, 'PROD006', 'VEN001','2025-02-01'),
(1, 'PROD007', 'VEN002','2025-01-06'),
(3, 'PROD008', 'VEN003','2025-04-04'),
(1, 'PROD009', 'VEN004','2025-06-09'),
(2, 'PROD010', 'VEN005','2025-09-20');


INSERT INTO Detalle_Devoluciones(ID_Devolucion,Cantidad_Devuelta,ID_Venta) VALUES
('DEV001', 1, 'VEN001'),
('DEV002', 1, 'VEN002'),
('DEV003', 2, 'VEN003'),
('DEV004', 1, 'VEN004'),
('DEV005', 1, 'VEN005');

INSERT INTO Devoluciones(ID_Devolucion,Fecha_Devolucion) VALUES
('DEV001', '2025-03-01'),
('DEV002', '2025-03-03'),
('DEV003', '2025-03-05'),
('DEV004', '2025-03-07'),
('DEV005', '2025-03-09');

--DQL Consultas

-- Consulta total de compras por cliente

SELECT C.Documento_Cliente, CONCAT(C.Nombre_Cliente, ' ', C.Apellido_Cliente) AS Cliente,
       COUNT(V.ID_Venta) AS Total_Compras
FROM Clientes C
JOIN Ventas V ON C.Documento_Cliente = V.Documento_Cliente
GROUP BY C.Documento_Cliente, C.Nombre_Cliente, C.Apellido_Cliente;

--Consulta total de ventas por empleado

SELECT E.Documento_Empleado, CONCAT(E.Nombre_Usuario, ' ', E.Apellido_Usuario) AS Empleado,
       COUNT(V.ID_Venta) AS Ventas_Realizadas
FROM Empleados E
JOIN Ventas V ON E.Documento_Empleado = V.Documento_Empleado
GROUP BY E.Documento_Empleado, E.Nombre_Usuario, E.Apellido_Usuario;

-- Cuenta empleados por rol mostrando nombre del rol y total
SELECT R.Nombre AS Rol, COUNT(*) AS Total_Empleados
FROM Empleados E
JOIN Roles R ON E.ID_Rol = R.ID_Rol
GROUP BY R.Nombre;

-- Cuenta total de personas por género (empleados y clientes juntos)
SELECT Genero, COUNT(*) AS Cantidad
FROM (
    SELECT Genero FROM Empleados
    UNION ALL
    SELECT Genero FROM Clientes
) AS Personas
GROUP BY Genero;

-- Consulta, cuenta la cantidad de productos con estado Activo
SELECT COUNT(*) AS Productos_Activos
FROM Productos
WHERE ID_Estado = 'EST001'


-- Lista correos electrónicos indicando si son de proveedores o empleados
SELECT  'Proveedores' AS Rol, Correo_Electronico
FROM Proveedores
UNION
SELECT 'Empleados' AS Rol,Correo_Electronico
FROM Empleados;


-- Muestra todas las gamas ordenadas alfabéticamente por nombre
SELECT * FROM Gamas ORDER BY Nombre_Gama;

-- Muestra una lista de los productos vendidos con la fecha de salida,
--el nombre completo del cliente y la cantidad, ordenados desde la venta más reciente.

SELECT 
    DV.Fecha_Salida, 
    CONCAT(C.Nombre_Cliente, ' ', C.Apellido_Cliente) AS Cliente,
    P.Nombre_Producto,
    DV.Cantidad
FROM Detalle_Ventas DV
JOIN Ventas V ON DV.ID_Venta = V.ID_Venta
JOIN Clientes C ON V.Documento_Cliente = C.Documento_Cliente
JOIN Productos P ON DV.ID_Producto = P.ID_Producto
ORDER BY DV.Fecha_Salida DESC;


-- Muestra el nombre de los proveedores activos y la cantidad de 
--compras únicas que han realizado.

SELECT 
    PR.Nombre_Proveedor, 
    COUNT(DISTINCT DC.ID_Entrada) AS Numero_Compras
FROM Proveedores PR
JOIN Detalle_Compras DC ON PR.ID_Proveedor = DC.ID_Proveedor
WHERE PR.ID_Estado = 'EST001'
GROUP BY PR.Nombre_Proveedor
ORDER BY Numero_Compras DESC;

--Muestra el documento, nombre y contraseña encriptada de los empleados
SELECT 
    E.Documento_Empleado,
    CONCAT(E.Nombre_Usuario, ' ', E.Apellido_Usuario) AS Empleado,
    C.Contrasena_Hash
FROM Empleados E
JOIN Contrasenas C ON E.Documento_Empleado = C.Documento_Empleado;


--TRIGGER
-- Resta la cantidad vendida del stock mínimo del producto después de una venta.
GO
CREATE TRIGGER trg_UpdateStockAfterVenta
ON Detalle_Ventas
AFTER INSERT
AS
BEGIN
    -- Actualizar el stock restando la cantidad vendida
    UPDATE p
    SET p.Stock_Minimo = p.Stock_Minimo - i.Cantidad
    FROM Productos p
    INNER JOIN inserted i ON p.ID_Producto = i.ID_Producto;
END;

-- Trigger que actualiza el Stock_Minimo en Productos 
-- al registrar una nueva compra en Detalle_Compras
GO
CREATE TRIGGER trg_UpdateStockAfterCompra
ON Detalle_Compras
AFTER INSERT
AS
BEGIN
    UPDATE p
    SET p.Stock_Minimo = p.Stock_Minimo + i.Cantidad
    FROM Productos p
    INNER JOIN Compras c ON p.ID_Producto = c.ID_Producto
    INNER JOIN inserted i ON c.ID_Entrada = i.ID_Entrada;
END;




--Procedimientos Almacenados en SQL Server
--Consultar productos con bajo stock
GO
CREATE PROCEDURE sp_ProductosBajoStock
    @Minimo INT
AS
BEGIN
    SELECT ID_Producto, Nombre_Producto , Stock_Minimo
    FROM Productos
    WHERE Stock_Minimo <= @Minimo;
END;

--Consultar resumen de ventas por fecha
GO
CREATE PROCEDURE sp_ResumenVentasPorFecha
    @FechaInicio DATE,
    @FechaFin DATE
AS
BEGIN
    SELECT 
        V.ID_Venta, 
        DV.Fecha_Salida AS Fecha,
        C.Nombre_Cliente + ' ' + C.Apellido_Cliente AS Cliente,
        DV.ID_Producto, 
        P.Nombre_Producto AS Producto,
        DV.Cantidad, 
        P.Precio_Venta, 
        (DV.Cantidad * P.Precio_Venta) AS Total
    FROM Ventas V
    INNER JOIN Clientes C ON V.Documento_Cliente = C.Documento_Cliente
    INNER JOIN Detalle_Ventas DV ON V.ID_Venta = DV.ID_Venta
    INNER JOIN Productos P ON DV.ID_Producto = P.ID_Producto
    WHERE DV.Fecha_Salida BETWEEN @FechaInicio AND @FechaFin;
END;


-- Registrar  ventas
GO
CREATE PROCEDURE sp_RegistrarVenta
    @Documento_Cliente VARCHAR(20),
    @Fecha DATETIME,
    @ID_Producto VARCHAR(20),
    @Cantidad INT,
    @Documento_Empleado VARCHAR(20)
AS
BEGIN
    DECLARE @ID_Venta VARCHAR(20);
SET @ID_Venta = LEFT(NEWID(), 20); 

    INSERT INTO Ventas (ID_Venta, Documento_Cliente, Documento_Empleado)
    VALUES (@ID_Venta, @Documento_Cliente, @Documento_Empleado); 

    INSERT INTO Detalle_Ventas (ID_Venta, ID_Producto, Cantidad, Fecha_Salida)
    VALUES (@ID_Venta, @ID_Producto, @Cantidad, @Fecha);

END;
GO