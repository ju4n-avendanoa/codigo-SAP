SELECT
    T0."DocNum",
    T0."DocDate",
    T0."CardCode",
    T0."CardName",
    T3."SlpName",
    T1."ItemCode",
    T1."Dscription",
    T4."U_Nmarca",
    T4."U_Nfabricante",
    CASE
        WHEN T4."U_Categoria" = 1 THEN ' Stock	'
        WHEN T4."U_Categoria" = 2 THEN ' Filtracion	'
        WHEN T4."U_Categoria" = 3 THEN ' Lubricantes CORE	'
        WHEN T4."U_Categoria" = 4 THEN ' Lubricantes NO CORE	'
        WHEN T4."U_Categoria" = 5 THEN ' Inmovil	'
        WHEN T4."U_Categoria" = 6 THEN ' Obsoleto	'
        WHEN T4."U_Categoria" = 7 THEN ' Homologado	'
        WHEN T4."U_Categoria" = 8 THEN ' Emergencia	'
        WHEN T4."U_Categoria" = 9 THEN ' Informativa	'
        WHEN T4."U_Categoria" = 10 THEN ' Compra local	'
        WHEN T4."U_Categoria" = 11 THEN ' Usados	'
        WHEN T4."U_Categoria" = 12 THEN ' Inactivo	'
    END CATEGORIA,
    SUM(T1."Quantity") as cantidad,
    T1."Price",
    SUM(T1."Quantity" * T1."Price") as total_linea,
    T5."WhsName",
    T1."U_Stock_Disponible" as stock_disponible_en_almacen_relacionado,
    T1."U_Stock_dis_md",
    T1."U_Stock_dis_bg",
    T1."U_Stock_General" as stock_disponible_general,
    T6."OnOrder"
FROM
    OQUT T0
    INNER JOIN QUT1 T1 ON T0."DocEntry" = T1."DocEntry"
    INNER JOIN OCRD T2 ON T0."CardCode" = T2."CardCode"
    INNER JOIN OSLP T3 ON T0."SlpCode" = T3."SlpCode"
    INNER JOIN OITM T4 ON T1."ItemCode" = T4."ItemCode"
    INNER JOIN OWHS T5 ON T1."WhsCode" = T5."WhsCode"
    INNER JOIN OITW T6 ON T6."ItemCode" = T1."ItemCode"
    AND T6."WhsCode" = T1."WhsCode"

WHERE T0."DocDate" >= [%0] AND T0."DocDate" <= [%1] 

GROUP BY
    T0."DocNum",
    T0."DocDate",
    T0."CardCode",
    T0."CardName",
    T0."SlpCode",
    T3."SlpName",
    T1."U_Stock_General",
    T1."ItemCode",
    T1."Dscription",
    T0."CardCode",
    T1."Price",
    T1."U_Stock_Disponible",
    T1."U_Stock_dis_md",
    T1."U_Stock_dis_bg",
    T4."U_Nmarca",
    T4."U_Ntipo",
    T4."U_Nfabricante",
    T4."U_Clasificacion",
    T4."U_Categoria",
    T5."WhsName",
    T6."OnOrder"
ORDER BY
    T1."ItemCode"