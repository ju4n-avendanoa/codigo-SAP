SELECT
    T0."DocNum" AS "Número de documento",
    T2."SlpName" AS "Asesor",
    T0."DocDate" "Fecha de contabilización",
    T0."CardName" AS "Cliente",
    T1."ItemCode" AS "Referencia",
    T1."Quantity" AS "Cantidad",
    T1."OpenQty",
    T1."LineStatus",
    T1."LineTotal" AS "Total"
FROM
    "BD_PARTEQUIPOS_PRO".ORDR T0
    INNER JOIN "BD_PARTEQUIPOS_PRO".RDR1 T1 ON T0."DocEntry" = T1."DocEntry"
    INNER JOIN "BD_PARTEQUIPOS_PRO".OSLP T2 ON T0."SlpCode" = T2."SlpCode"
WHERE
    T0."DocStatus" = 'O'
    AND T1."LineStatus" = 'O'
