SELECT DISTINCT
    T1."CardCode",
    T1."CardName",
    T2."SlpName" AS "Asesor",
    T1."DocNum",
    YEAR(T1."DocDate") AS "Year",
    MONTH(T1."DocDate") AS "Month"
FROM
    "BD_PARTEQUIPOS_PRO".OINV T1
    INNER JOIN "BD_PARTEQUIPOS_PRO".OSLP T2 ON T1."SlpCode" = T2."SlpCode"
WHERE
    T1."DocDate" >= '2024-01-01'
    AND T1."DocDate" <= CURRENT_DATE;