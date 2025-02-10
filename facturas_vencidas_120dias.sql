SELECT
    T0."DocNum" AS "No. doc",
    T0."CardCode" AS "NIT",
    T0."CardName" AS "Cliente",
    T0."DocTotal" AS "Total",
    DAYS_BETWEEN(T0."DocDueDate", CURRENT_DATE) AS "Días vencidos",
    T1."SlpName" AS "Asesor"

FROM
    "BD_PARTEQUIPOS_PRO".OINV T0
    INNER JOIN "BD_PARTEQUIPOS_PRO".OSLP T1 ON T0."SlpCode" = T1."SlpCode"

WHERE
    DAYS_BETWEEN(T0."DocDueDate", CURRENT_DATE) >= 120
    AND T0."DocStatus" = 'O'