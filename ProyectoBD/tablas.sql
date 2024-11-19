-- TABLA USUARIO
CREATE TABLE DMJSJSNT_USUARIOS (
    cod_usuario NUMBER PRIMARY KEY,
    nombre_usuario VARCHAR2(50),
    apellido_usuario VARCHAR2(50),
    correo_usuario VARCHAR2(100),
    contraseña VARCHAR2(10),
    rol VARCHAR2(20)
);
--TABLA BODEGAS
CREATE TABLE DMJSJSNT_BODEGAS (
    cod_bodega NUMBER PRIMARY KEY,
    nombre_bodega VARCHAR2(20),
    ubicacion_bodega VARCHAR2(100)
);
TABLA MATERIALEA
CREATE TABLE DMJSJSNT_MATERIALES (
    cod_material NUMBER PRIMARY KEY,
    nombre_material VARCHAR2(50),
    descripcion CLOB,
    cantidad_disponible NUMBER,
    estado VARCHAR2(20),
    precio NUMBER,
    cod_bodega NUMBER,
    CONSTRAINT fk_cod_bodega FOREIGN KEY (cod_bodega) REFERENCES DMJSJSNT_BODEGAS(cod_bodega)
);
TABLA CLIENTES
CREATE TABLE DMJSJSNT_CLIENTES (
    cod_cliente NUMBER PRIMARY KEY,
    nombre_cliente VARCHAR2(50),
    rut_cliente NUMBER,
    direccion_cliente VARCHAR2(70),
    correo_cliente VARCHAR2(70),
    telefono NUMBER
);
TABLA VENTAS
CREATE TABLE DMJSJSNT_VENTAS (
    cod_venta NUMBER PRIMARY KEY,
    cod_usuario NUMBER,
    cod_material NUMBER,
    cod_cliente NUMBER,
    fecha_venta DATE,
    total_venta NUMBER,
    comision NUMBER,
    CONSTRAINT fk_cod_usuario FOREIGN KEY (cod_usuario) REFERENCES DMJSJSNT_USUARIOS(cod_usuario),
    CONSTRAINT fk_cod_material FOREIGN KEY (cod_material) REFERENCES DMJSJSNT_MATERIALES(cod_material),
    CONSTRAINT fk_cod_cliente FOREIGN KEY (cod_cliente) REFERENCES DMJSJSNT_CLIENTES(cod_cliente)
);
TABLA DETALLE VENTAS
CREATE TABLE DMJSJSNT_DETALLEVENTAS (
    cod_detalle_venta NUMBER,
    cod_venta NUMBER,
    cod_material NUMBER,
    cantidad NUMBER,
    precio_unitario NUMBER,
    total NUMBER,
    PRIMARY KEY (cod_detalle_venta, cod_venta, cod_material),
    CONSTRAINT fk_cod_venta FOREIGN KEY (cod_venta) REFERENCES DMJSJSNT_VENTAS(cod_venta),
    CONSTRAINT fk_cod_material_detalle FOREIGN KEY (cod_material) REFERENCES DMJSJSNT_MATERIALES(cod_material)
);
