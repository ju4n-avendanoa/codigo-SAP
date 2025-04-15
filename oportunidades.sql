SELECT
    T0."DocNum" AS "Numero de documento",
    T0."DocDate" AS "Fecha de documento",
    T0."CardCode" AS "NIT",
    T0."CardName" AS "Cliente",
    T3."SlpName" AS "Asesor",
    T1."ItemCode" AS "Referencia",
    T1."Dscription" AS "Descripcion",
    T4."U_Nmarca" AS "Marca",  
    T4."U_Nfabricante" AS "Fabricante",
    CASE
        WHEN T4."ItmsGrpCod" = 100 THEN 'Artículos'
        WHEN T4."ItmsGrpCod" = 101 THEN 'Filtración'
        WHEN T4."ItmsGrpCod" = 102 THEN 'Lubricantes'
        WHEN T4."ItmsGrpCod" = 103 THEN 'Herramientas de corte'
        WHEN T4."ItmsGrpCod" = 104 THEN 'Tren de rodaje'
        WHEN T4."ItmsGrpCod" = 105 THEN 'Llantas'
        WHEN T4."ItmsGrpCod" = 106 THEN 'Motor Diesel (repuestos)'
        WHEN T4."ItmsGrpCod" = 107 THEN 'Motor Diesel completo'
        WHEN T4."ItmsGrpCod" = 108 THEN 'Hidráulico / Transmisión'
        WHEN T4."ItmsGrpCod" = 109 THEN 'Mangueras'
        WHEN T4."ItmsGrpCod" = 110 THEN 'Misceláneos (representados)'
        WHEN T4."ItmsGrpCod" = 111 THEN 'Misceláneos (no representados)'
        WHEN T4."ItmsGrpCod" = 112 THEN 'Martillos'
        WHEN T4."ItmsGrpCod" = 113 THEN 'Filtración'
        WHEN T4."ItmsGrpCod" = 114 THEN 'Lubricantes'
        WHEN T4."ItmsGrpCod" = 115 THEN 'Herramientas de corte'
        WHEN T4."ItmsGrpCod" = 116 THEN 'Tren de rodaje'
        WHEN T4."ItmsGrpCod" = 117 THEN 'Llantas'
        WHEN T4."ItmsGrpCod" = 118 THEN 'Motor Diesel (repuestos)'
        WHEN T4."ItmsGrpCod" = 119 THEN 'Hidráulico / Transmisión'
        WHEN T4."ItmsGrpCod" = 120 THEN 'Misceláneos (representados)'
        WHEN T4."ItmsGrpCod" = 121 THEN 'Misceláneos (no representados)'
        WHEN T4."ItmsGrpCod" = 122 THEN 'Fletes'
        WHEN T4."ItmsGrpCod" = 123 THEN 'Componentes mayores'
        WHEN T4."ItmsGrpCod" = 124 THEN 'Componentes mayores'
        WHEN T4."ItmsGrpCod" = 125 THEN 'Servicios'
        WHEN T4."ItmsGrpCod" = 126 THEN 'Gastos viaje PQMQ'
        WHEN T4."ItmsGrpCod" = 132 THEN 'Costos de importación'
        WHEN T4."ItmsGrpCod" = 133 THEN 'Depósito contenedor'
    END AS "Grupo de artículo",
    CASE
        WHEN T4."U_Categoria" = 1 THEN 'Stock'
        WHEN T4."U_Categoria" = 2 THEN 'Filtracion'
        WHEN T4."U_Categoria" = 3 THEN 'Lubricantes CORE'
        WHEN T4."U_Categoria" = 4 THEN 'Lubricantes NO CORE'
        WHEN T4."U_Categoria" = 5 THEN 'Inmovil'
        WHEN T4."U_Categoria" = 6 THEN 'Obsoleto'
        WHEN T4."U_Categoria" = 7 THEN 'Homologado'
        WHEN T4."U_Categoria" = 8 THEN 'Emergencia'
        WHEN T4."U_Categoria" = 9 THEN 'Informativa'
        WHEN T4."U_Categoria" = 10 THEN 'Compra local'
        WHEN T4."U_Categoria" = 11 THEN 'Usados'
        WHEN T4."U_Categoria" = 12 THEN 'Inactivo'
    END AS "Categoria",
    SUM(T1."Quantity") AS "Cantidad",
    T1."Price" AS "Precio",    
    SUM(T1."Quantity" * T1."Price") AS "Total",
    T5."WhsCode" AS "Almacen",
    T1."U_Stock_Disponible" AS "Stock disponible en almacen generado",
    T1."U_Stock_dis_md",
    T1."U_Stock_dis_bg",
    T1."U_Stock_General" AS "Stock general nacional"
FROM
    BD_PARTEQUIPOS_PRO.OQUT T0
    INNER JOIN BD_PARTEQUIPOS_PRO.QUT1 T1 ON T0."DocEntry" = T1."DocEntry"
    INNER JOIN BD_PARTEQUIPOS_PRO.OCRD T2 ON T0."CardCode" = T2."CardCode"
    INNER JOIN BD_PARTEQUIPOS_PRO.OSLP T3 ON T0."SlpCode" = T3."SlpCode"
    INNER JOIN BD_PARTEQUIPOS_PRO.OITM T4 ON T1."ItemCode" = T4."ItemCode"
    INNER JOIN BD_PARTEQUIPOS_PRO.OWHS T5 ON T1."WhsCode" = T5."WhsCode"
    INNER JOIN BD_PARTEQUIPOS_PRO.OITW T6 ON T6."ItemCode" = T1."ItemCode"
    AND T6."WhsCode" = T1."WhsCode"
WHERE T0."DocDate" >= '2025-01-01' AND T0."DocDate" < '2026-01-01' 
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
    T5."WhsCode",
    T6."OnOrder",
    T4."ItmsGrpCod"