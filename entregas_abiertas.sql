SELECT
    T0."DocNum",
    T0."CardCode" AS "NIT",
    T2."SlpName" AS "Asesor",
    T0."DocDate",   
    T0."CardName" AS "Cliente",
    T1."ItemCode",
    T1."Quantity",
    T1."OpenQty",
    T1."LineStatus",
    T1."LineTotal" AS "Total",
FROM
    ODLN T0
    INNER JOIN DLN1 T1 ON T0."DocEntry" = T1."DocEntry"
    INNER JOIN OSLP T2 ON T0."SlpCode" = T2."SlpCode"
    INNER JOIN OUSR T4 ON T0."UserSign" = T4."USERID"
WHERE
    T0."DocStatus" = 'O'
    and T1."LineStatus" = 'O'