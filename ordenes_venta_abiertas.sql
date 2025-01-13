SELECT
    T0."DocNum",
    T2."SlpName",
    T0."DocDate",
    T0."CardName",
    T1."ItemCode",
    T1."Quantity",
    T1."OpenQty",
    T1."LineStatus",
    T1."LineTotal"
FROM
    ORDR T0
    INNER JOIN RDR1 T1 ON T0."DocEntry" = T1."DocEntry"
    INNER JOIN OSLP T2 ON T0."SlpCode" = T2."SlpCode"
WHERE
    T0."DocStatus" = 'O'
    and T1."LineStatus" = 'O'
