SELECT
    T0."DocNum" AS "Número de documento",
    T0."DocStatus" AS "Estado del documento",
    T0."DocDate" AS "Fecha de contabilización",
    T0."CardCode" AS "NIT",
    T0."CardName" AS "Cliente",
    T2."ItemCode" AS "Referencia",
    T2."ItemName" AS "Descripción",
    T1."Quantity" AS "Cantidad",
    T0."DocTotal" AS "Total del documento",
    T1."LineTotal" AS "Total",
    T3."SlpName" AS "Asesor",
    T4."U_NAME" AS "Usuario",
    CASE
        WHEN T1."TargetType" > 0 THEN 'Vendida'
        WHEN T0."DocStatus" = 'C' THEN 'Perdida'
        ELSE 'En proceso'
    END AS "Estado de la línea",
    CASE
        WHEN T0."U_Motivo_cierre" = '1' THEN 'Precio'
        WHEN T0."U_Motivo_cierre" = '2' THEN 'Calidad'
        WHEN T0."U_Motivo_cierre" = '3' THEN 'Marca'
        WHEN T0."U_Motivo_cierre" = '4' THEN 'Agotado nacional'
        WHEN T0."U_Motivo_cierre" = '5' THEN 'Agotado en sede'
        WHEN T0."U_Motivo_cierre" = '6' THEN 'Por sitio de entrega'
        WHEN T0."U_Motivo_cierre" = '7' THEN 'Por tiempo de importación'
        WHEN T0."U_Motivo_cierre" = '8' THEN 'Duplicado'
        WHEN T0."U_Motivo_cierre" = '9' THEN 'Cambio RUT'
        ELSE T0."U_Motivo_cierre"
    END AS "Motivo de cierre",
    CASE
        WHEN T2."ItmsGrpCod" = 100 THEN 'Artículos'
        WHEN T2."ItmsGrpCod" = 101 THEN 'Filtración'
        WHEN T2."ItmsGrpCod" = 102 THEN 'Lubricantes'
        WHEN T2."ItmsGrpCod" = 103 THEN 'Herramientas de corte'
        WHEN T2."ItmsGrpCod" = 104 THEN 'Tren de rodaje'
        WHEN T2."ItmsGrpCod" = 105 THEN 'Llantas'
        WHEN T2."ItmsGrpCod" = 106 THEN 'Motor Diesel (repuestos)'
        WHEN T2."ItmsGrpCod" = 107 THEN 'Motor Diesel completo'
        WHEN T2."ItmsGrpCod" = 108 THEN 'Hidráulico / Transmisión'
        WHEN T2."ItmsGrpCod" = 109 THEN 'Mangueras'
        WHEN T2."ItmsGrpCod" = 110 THEN 'Misceláneos (representados)'
        WHEN T2."ItmsGrpCod" = 111 THEN 'Misceláneos (no representados)'
        WHEN T2."ItmsGrpCod" = 112 THEN 'Martillos'
        WHEN T2."ItmsGrpCod" = 113 THEN 'Filtración'
        WHEN T2."ItmsGrpCod" = 114 THEN 'Lubricantes'
        WHEN T2."ItmsGrpCod" = 115 THEN 'Herramientas de corte'
        WHEN T2."ItmsGrpCod" = 116 THEN 'Tren de rodaje'
        WHEN T2."ItmsGrpCod" = 117 THEN 'Llantas'
        WHEN T2."ItmsGrpCod" = 118 THEN 'Motor Diesel (repuestos)'
        WHEN T2."ItmsGrpCod" = 119 THEN 'Hidráulico / Transmisión'
        WHEN T2."ItmsGrpCod" = 120 THEN 'Misceláneos (representados)'
        WHEN T2."ItmsGrpCod" = 121 THEN 'Misceláneos (no representados)'
        WHEN T2."ItmsGrpCod" = 122 THEN 'Fletes'
        WHEN T2."ItmsGrpCod" = 123 THEN 'Componentes mayores'
        WHEN T2."ItmsGrpCod" = 124 THEN 'Componentes mayores'
        WHEN T2."ItmsGrpCod" = 125 THEN 'Servicios'
        WHEN T2."ItmsGrpCod" = 126 THEN 'Gastos viaje PQMQ'
        WHEN T2."ItmsGrpCod" = 132 THEN 'Costos de importación'
        WHEN T2."ItmsGrpCod" = 133 THEN 'Depósito contenedor'
    END AS "Grupo de artículo",
    T2."U_Nmarca" AS "Marca",
    T2."U_Nfabricante" AS "Fabricante"
FROM
    "BD_PARTEQUIPOS_PRO".OQUT T0
    INNER JOIN "BD_PARTEQUIPOS_PRO".QUT1 T1 ON T0."DocEntry" = T1."DocEntry"
    INNER JOIN "BD_PARTEQUIPOS_PRO".OITM T2 ON T1."ItemCode" = T2."ItemCode"
    INNER JOIN "BD_PARTEQUIPOS_PRO".OSLP T3 ON T0."SlpCode" = T3."SlpCode"
    INNER JOIN "BD_PARTEQUIPOS_PRO".OUSR T4 ON T0."UserSign" = T4."USERID"
WHERE
    T0."DocDate" >= '2025-01-01'
    AND T0."DocDate" < '2026-01-01'