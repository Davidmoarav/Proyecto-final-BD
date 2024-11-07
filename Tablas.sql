--TABLA CLIENTES
CREATE TABLE DJNJ_CLIENTE(
    cod_cliente NUMBER,
    nombre_cliente VARCHAR2(50),
    apellido1_cliente VARCHAR2(50),
    apellido2_cliente VARCHAR2(50),
    correo_cliente VARCHAR2(30)
    CONSTRAINT cod_cliente as primary key
);
