SELECT
    T0."DocNum" AS "Número de documento",
    T0."CardCode" AS "NIT",
    T2."SlpName" AS "Asesor",
    T0."DocDate" AS "Fecha de contabilización",
    T0."CardName" AS "Cliente",
    T1."ItemCode" AS "Referencia",
    T1."Quantity" AS "Cantidad",
    T1."OpenQty" AS "Cantidad abierta restante",
    T1."LineStatus",
    T1."LineTotal" AS "Total",
    T1."WhsCode" AS "Almacén"
FROM
    "BD_PARTEQUIPOS_PRO".ODLN T0
    INNER JOIN "BD_PARTEQUIPOS_PRO".DLN1 T1 ON T0."DocEntry" = T1."DocEntry"
    INNER JOIN "BD_PARTEQUIPOS_PRO".OSLP T2 ON T0."SlpCode" = T2."SlpCode"
    INNER JOIN "BD_PARTEQUIPOS_PRO".OUSR T4 ON T0."UserSign" = T4."USERID"
WHERE
    T0."DocStatus" = 'O'
    AND T1."LineStatus" = 'O'