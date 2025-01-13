SELECT
    T0."DocNum",
    T2."SlpName" AS "Asesor",
    T0."DocDate",
    T0."CardName" AS "Cliente",
    T1."ItemCode" AS "Referencia",
    T1."Quantity",
    T1."OpenQty",
    T1."LineStatus",
    T1."LineTotal" AS "Total"
FROM
    ORDR T0
    INNER JOIN RDR1 T1 ON T0."DocEntry" = T1."DocEntry"
    INNER JOIN OSLP T2 ON T0."SlpCode" = T2."SlpCode"
WHERE
    T0."DocStatus" = 'O'
    AND T1."LineStatus" = 'O'
