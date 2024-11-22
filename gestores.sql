--Gestor de registrar venta (Función validar_stock)
CREATE OR REPLACE PROCEDURE registrar_venta(
    p_cod_usuario NUMBER,
    p_cod_material NUMBER,
    p_rut_cliente NUMBER,
    p_cantidad NUMBER,
    p_precio_unitario NUMBER
) AS
    v_total NUMBER;
    v_stock_valido NUMBER;
BEGIN
    v_stock_valido := validar_stock(p_cod_material, p_cantidad);

    IF NOT v_stock_valido THEN
        RAISE_APPLICATION_ERROR(-20002, 'Stock insuficiente para el material seleccionado.');
    END IF;

    v_total := p_cantidad * p_precio_unitario;

    INSERT INTO DMJSJSNT_VENTAS (
        cod_venta, cod_usuario, cod_material, rut_cliente, fecha_venta, total_venta) 
        VALUES (seq_cod_venta.NEXTVAL, p_cod_usuario, p_cod_material, p_rut_cliente, SYSDATE, v_total);

    UPDATE DMJSJSNT_MATERIALES
    SET cantidad_disponible = cantidad_disponible - p_cantidad
    WHERE cod_material = p_cod_material;
END;
/

--Reporte de inventarios críticos (Usa cursor)
CREATE OR REPLACE PROCEDURE ReporteInventariosCriticos IS
    CURSOR materiales_criticos_cursor IS
        SELECT COD_MATERIAL, NOMBRE_MATERIAL, CANTIDAD_DISPONIBLE
        FROM DMJSJSNT_MATERIALES
        WHERE CANTIDAD_DISPONIBLE < 10;
BEGIN
    FOR material IN materiales_criticos_cursor LOOP
        DBMS_OUTPUT.PUT_LINE('Material: ' || material.NOMBRE_MATERIAL || ', Cantidad: ' || material.CANTIDAD_DISPONIBLE);
    END LOOP;
END;
/

--Actualizar categoria automaticamente (MATERIALES EN VENTAS)
CREATE OR REPLACE PROCEDURE ActualizarCategoriasAutomAticamente IS
    CURSOR materiales_cursor IS
        SELECT COD_MATERIAL
        FROM DMJSJSNT_MATERIALES;
BEGIN
    FOR material IN materiales_cursor LOOP
        -- Llamar a la función para actualizar la categoría
        DBMS_OUTPUT.PUT_LINE('Categoría actualizada para material ID: ' || material.COD_MATERIAL || ' a: ' || ActualizarCategoria(material.COD_MATERIAL));
    END LOOP;
END;
/

--Productos por demanda (Usa cursor)
CREATE OR REPLACE PROCEDURE OrdenarProductosPorDemanda IS
    CURSOR productos_por_demanda_cursor IS
        SELECT COD_MATERIAL, SUM(CANTIDAD) AS TOTAL_VENDIDO
        FROM DMJSJSNT_DETALLEVENTAS
        GROUP BY COD_MATERIAL
        ORDER BY TOTAL_VENDIDO DESC;
BEGIN
    FOR producto IN productos_por_demanda_cursor LOOP
        DBMS_OUTPUT.PUT_LINE('Material ID: ' || producto.COD_MATERIAL || ' - Total vendido: ' || producto.TOTAL_VENDIDO);
    END LOOP;
END;
/

--GESTOR FALTANTE