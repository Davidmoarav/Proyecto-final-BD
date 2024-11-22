--Reporte productos mas vendidos y menos vendidos
CREATE OR REPLACE PROCEDURE REPORTE_PRODUCTOS_VENDIDOS AS
BEGIN
    -- Productos más vendidos
    DBMS_OUTPUT.PUT_LINE('=== Productos Más Vendidos ===');
    FOR producto IN (
        SELECT M.NOMBRE_MATERIAL, SUM(DV.CANTIDAD) AS TOTAL_VENDIDO
        FROM DMJSJSNT_DETALLEVENTAS DV
        JOIN DMJSJSNT_MATERIALES M ON DV.COD_MATERIAL = M.COD_MATERIAL
        GROUP BY M.NOMBRE_MATERIAL
        ORDER BY TOTAL_VENDIDO DESC
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Material: ' || producto.NOMBRE_MATERIAL || ', Total Vendido: ' || producto.TOTAL_VENDIDO);
    END LOOP;

    -- Productos menos vendidos
    DBMS_OUTPUT.PUT_LINE('=== Productos Menos Vendidos ===');
    FOR producto IN (
        SELECT M.NOMBRE_MATERIAL, SUM(DV.CANTIDAD) AS TOTAL_VENDIDO
        FROM DMJSJSNT_DETALLEVENTAS DV
        JOIN DMJSJSNT_MATERIALES M ON DV.COD_MATERIAL = M.COD_MATERIAL
        GROUP BY M.NOMBRE_MATERIAL
        ORDER BY TOTAL_VENDIDO ASC
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Material: ' || producto.NOMBRE_MATERIAL || ', Total Vendido: ' || producto.TOTAL_VENDIDO);
    END LOOP;
END;
/


--Reporte de ventas por bodega
CREATE OR REPLACE PROCEDURE REPORTE_MATERIALES_POR_BODEGA(
    COD_BODEGA_P NUMBER
) AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== Materiales Más Demandados en la Bodega ' || COD_BODEGA_P || ' ===');
    FOR material IN (
        SELECT M.NOMBRE_MATERIAL, SUM(DV.CANTIDAD) AS TOTAL_VENDIDO
        FROM DMJSJSNT_DETALLEVENTAS DV
        JOIN DMJSJSNT_MATERIALES M ON DV.COD_MATERIAL = M.COD_MATERIAL
        WHERE M.COD_BODEGA = COD_BODEGA_P
        GROUP BY M.NOMBRE_MATERIAL
        ORDER BY TOTAL_VENDIDO DESC
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Material: ' || material.NOMBRE_MATERIAL || ', Total Vendido: ' || material.TOTAL_VENDIDO);
    END LOOP;
END;
/

--Reporte de ventas al mes
CREATE OR REPLACE PROCEDURE REPORTE_VENTAS_POR_MES AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== Ventas Totales por Mes ===');
    FOR venta IN (
        SELECT TO_CHAR(V.FECHA_VENTA, 'MM-YYYY') AS MES_ANIO, SUM(V.TOTAL_VENTA) AS TOTAL_VENTAS
        FROM DMJSJSNT_VENTAS V
        GROUP BY TO_CHAR(V.FECHA_VENTA, 'MM-YYYY')
        ORDER BY TO_DATE(TO_CHAR(V.FECHA_VENTA, 'MM-YYYY'), 'MM-YYYY')
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Mes: ' || venta.MES_ANIO || ', Total Ventas: ' || venta.TOTAL_VENTAS);
    END LOOP;
END;
/
