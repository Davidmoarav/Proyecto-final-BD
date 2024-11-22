--Función para validar stock
CREATE OR REPLACE FUNCTION validarStock (
    p_cod_material NUMBER,
    p_cantidad NUMBER
) RETURN VARCHAR2 IS
    v_cantidad_disponible NUMBER;
BEGIN
    SELECT CANTIDAD_DISPONIBLE
    INTO v_cantidad_disponible
    FROM DMJSJSNT_MATERIALES
    WHERE COD_MATERIAL = p_cod_material;

    IF v_cantidad_disponible >= p_cantidad THEN
        RETURN 'Suficiente stock disponible.';
    ELSE
        RETURN 'Stock insuficiente.';
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 'Material no encontrado.';
END;
/

--Actualizar categoria automaticamente (MATERIALES)
CREATE OR REPLACE FUNCTION ActualizarCategoria (
    p_cod_material NUMBER
) RETURN VARCHAR2 IS
    v_total_vendido NUMBER;
    v_categoria VARCHAR2(50);
BEGIN
    SELECT SUM(CANTIDAD)
    INTO v_total_vendido
    FROM DMJSJSNT_DETALLEVENTAS
    WHERE COD_MATERIAL = p_cod_material;

    IF v_total_vendido > 2000 THEN
        v_categoria := 'Alta demanda';
    ELSE
        v_categoria := 'Baja demanda';
    END IF;

    UPDATE DMJSJSNT_MATERIALES
    SET CATEGORIA = v_categoria
    WHERE COD_MATERIAL = p_cod_material;

    RETURN v_categoria;
END;
/