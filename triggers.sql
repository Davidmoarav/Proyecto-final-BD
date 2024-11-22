--Comisión
CREATE OR REPLACE TRIGGER TRG_CALCULAR_COMISION
BEFORE INSERT OR UPDATE ON DMJSJSNT_VENTAS
FOR EACH ROW
BEGIN
    :NEW.COMISION := :NEW.TOTAL_VENTA * 0.02;
END;
/

--Actualizar inventario
CREATE OR REPLACE TRIGGER TRG_ACTUALIZAR_INVENTARIO
AFTER INSERT ON DMJSJSNT_DETALLEVENTAS
FOR EACH ROW
BEGIN
    UPDATE DMJSJSNT_MATERIALES
    SET CANTIDAD_DISPONIBLE = CANTIDAD_DISPONIBLE - :NEW.CANTIDAD
    WHERE COD_MATERIAL = :NEW.COD_MATERIAL;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Material no encontrado.');
    END IF;
END;
/

--Alertas por inventario bajo
CREATE OR REPLACE TRIGGER TRG_ALERTA_INVENTARIO_BAJO
AFTER UPDATE ON DMJSJSNT_MATERIALES
FOR EACH ROW
WHEN (NEW.CANTIDAD_DISPONIBLE < 10)
BEGIN
    INSERT INTO ALERTAS_INVENTARIO (FECHA_ALERTA, MENSAJE)
    VALUES (SYSDATE, 'Stock bajo para material: ' || :NEW.NOMBRE_MATERIAL);
END;
/

--Evitar duplicados de ventas
CREATE OR REPLACE TRIGGER TRG_EVITAR_VENTAS_DUPLICADAS
BEFORE INSERT ON DMJSJSNT_DETALLEVENTAS
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM DMJSJSNT_DETALLEVENTAS DV
        JOIN DMJSJSNT_VENTAS V ON DV.COD_VENTA = V.COD_VENTA
        WHERE V.RUT_CLIENTE = :NEW.RUT_CLIENTE
          AND DV.COD_MATERIAL = :NEW.COD_MATERIAL
          AND V.FECHA_VENTA > SYSDATE - 1  -- Últimas 24 horas
    ) THEN
        RAISE_APPLICATION_ERROR(-20003, 'Venta duplicada para el mismo cliente y material.');
    END IF;
END;
/

--Eliminación indebida
CREATE OR REPLACE TRIGGER TRG_BLOQUEAR_ELIMINACION_MATERIAL
BEFORE DELETE ON DMJSJSNT_MATERIALES
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM DMJSJSNT_DETALLEVENTAS WHERE COD_MATERIAL = :OLD.COD_MATERIAL) THEN
        RAISE_APPLICATION_ERROR(-20002, 'No se puede eliminar un material con ventas asociadas.');
    END IF;
END;
/



