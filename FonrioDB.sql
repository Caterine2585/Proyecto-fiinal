 CREATE DATABASE FONRIO;
USE FONRIO;


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
    Nombre_Gama VARCHAR(15) NOT NULL,
    ID_Categoria VARCHAR(20) NOT NULL,
    FOREIGN KEY (ID_Categoria) REFERENCES Categorias(ID_Categoria)
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


CREATE TABLE Productos (
    ID_Producto VARCHAR(20) PRIMARY KEY,
    Nombre_Producto VARCHAR(30) NOT NULL,
    Descripcion TEXT NOT NULL,
    Precio_Venta MONEY NOT NULL,
    Stock_Minimo INT NOT NULL,
    ID_Categoria VARCHAR(20) NOT NULL,
    ID_Estado VARCHAR(20) NOT NULL,
    FOREIGN KEY (ID_Categoria) REFERENCES Categorias(ID_Categoria),
    FOREIGN KEY (ID_Estado) REFERENCES Estados(ID_Estado)
);


CREATE TABLE Compras (
    ID_Entrada VARCHAR(20) PRIMARY KEY,
    Fecha_Entrada DATE NOT NULL,
    Precio_Compra MONEY NOT NULL,
    ID_Proveedor VARCHAR(20) NOT NULL,
    ID_Producto VARCHAR(20) NOT NULL,
    Documento_Empleado VARCHAR(20) NOT NULL,
    FOREIGN KEY (ID_Proveedor) REFERENCES Proveedores(ID_Proveedor),
    FOREIGN KEY (ID_Producto) REFERENCES Productos(ID_Producto),
    FOREIGN KEY (Documento_Empleado) REFERENCES Empleados(Documento_Empleado)
);


CREATE TABLE Detalle_Compras (
    Cantidad INT NOT NULL,
    ID_Producto VARCHAR(20) NOT NULL,
    ID_Entrada VARCHAR(20) NOT NULL,
    FOREIGN KEY (ID_Producto) REFERENCES Productos(ID_Producto),
    FOREIGN KEY (ID_Entrada) REFERENCES Compras(ID_Entrada)
);


CREATE TABLE Ventas (
    ID_Venta VARCHAR(20) PRIMARY KEY,
    Fecha_Salida DATE NOT NULL,
    Documento_Cliente VARCHAR(20) NOT NULL,
    Documento_Empleado VARCHAR(20) NOT NULL,
    FOREIGN KEY (Documento_Cliente) REFERENCES Clientes(Documento_Cliente),
    FOREIGN KEY (Documento_Empleado) REFERENCES Empleados(Documento_Empleado)
);


CREATE TABLE Detalle_Ventas (
    Cantidad INT NOT NULL,
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


INSERT INTO Gamas (ID_Gama, Nombre_Gama, ID_Categoria) VALUES
('GAM001', 'Baja', 'CAT001'),
('GAM002', 'Media', 'CAT002'),
('GAM003', 'Alta', 'CAT003'),
('GAM004', 'Media', 'CAT004'),
('GAM005', 'Alta', 'CAT005');


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


INSERT INTO Productos(ID_Producto,Nombre_Producto,Descripcion,Precio_Venta,Stock_Minimo,ID_Categoria,ID_Estado) VALUES
('PROD006', 'Redmi Note 12', 'Celular Xiaomi gama media con buena batería', 850000, 5, 'CAT001', 'EST001'),
('PROD007', 'Motorola G60', 'Smartphone Motorola con cámara de 108MP', 950000, 4, 'CAT001', 'EST001'),
('PROD008', 'Samsung A54', 'Celular Samsung gama media-alta', 1250000, 6, 'CAT001', 'EST001'),
('PROD009', 'iPhone 13', 'iPhone 13 de 128GB', 3300000, 2, 'CAT001', 'EST001'),
('PROD010', 'Cargador Tipo C', 'Cargador rápido universal tipo C', 50000, 10, 'CAT002', 'EST001');


INSERT INTO Compras(ID_Entrada,Fecha_Entrada,Precio_Compra,ID_Proveedor,ID_Producto,Documento_Empleado ) VALUES
('COM001', '2025-01-01', 300000, 'PROV001', 'PROD006', 'EMP006'),
('COM002', '2025-01-05', 60000, 'PROV002', 'PROD007', 'EMP007'),
('COM003', '2025-01-10', 500000, 'PROV003', 'PROD008', 'EMP008'),
('COM004', '2025-01-15', 1500000, 'PROV004', 'PROD009', 'EMP009'),
('COM005', '2025-01-20', 200000, 'PROV005', 'PROD010', 'EMP010');


INSERT INTO Detalle_Compras(Cantidad,ID_Producto,ID_Entrada ) VALUES
(10, 'PROD006', 'COM001'),
(15, 'PROD007', 'COM002'),
(20, 'PROD008', 'COM003'),
(5,  'PROD009', 'COM004'),
(8,  'PROD010', 'COM005');


INSERT INTO Ventas(ID_Venta,Fecha_Salida,Documento_Cliente,Documento_Empleado)VALUES
('VEN001', '2025-02-01', 'CLI006', 'EMP006'),
('VEN002', '2025-02-05', 'CLI007', 'EMP007'),
('VEN003', '2025-02-10', 'CLI008', 'EMP008'),
('VEN004', '2025-02-15', 'CLI009', 'EMP009'),
('VEN005', '2025-02-20', 'CLI010', 'EMP010');


INSERT INTO Detalle_Ventas(Cantidad,ID_Producto,ID_Venta) VALUES
(2, 'PROD006', 'VEN001'),
(1, 'PROD007', 'VEN002'),
(3, 'PROD008', 'VEN003'),
(1, 'PROD009', 'VEN004'),
(2, 'PROD010', 'VEN005');


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


--Clientes que han hecho compras.

SELECT C.Documento_Cliente, CONCAT(C.Nombre_Cliente, ' ', C.Apellido_Cliente) AS Cliente,
       COUNT(V.ID_Venta) AS Total_Compras
FROM Clientes C
JOIN Ventas V ON C.Documento_Cliente = V.Documento_Cliente
GROUP BY C.Documento_Cliente, C.Nombre_Cliente, C.Apellido_Cliente;

--Empleados y el total de ventas que han atendido.

SELECT E.Documento_Empleado, CONCAT(E.Nombre_Usuario, ' ', E.Apellido_Usuario) AS Empleado,
       COUNT(V.ID_Venta) AS Ventas_Realizadas
FROM Empleados E
JOIN Ventas V ON E.Documento_Empleado = V.Documento_Empleado
GROUP BY E.Documento_Empleado, E.Nombre_Usuario, E.Apellido_Usuario;

--Empleados por rol.
SELECT R.Nombre AS Rol, COUNT(*) AS Total_Empleados
FROM Empleados E
JOIN Roles R ON E.ID_Rol = R.ID_Rol
GROUP BY R.Nombre;
