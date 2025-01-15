SELECT
    T0."DocNum",
    T0."CardCode" AS "NIT",
    T0."CardName" AS "Cliente",
    T0."DocTotal",
    T0."DocDueDate",
    DAYS_BETWEEN(T0."DocDueDate", CURRENT_DATE) AS "Días vencidos",
    T1."SlpName" AS "Asesor"

FROM
    OINV T0
    INNER JOIN OSLP T1 ON T0."SlpCode" = T1."SlpCode"

WHERE
    DAYS_BETWEEN(T0."DocDueDate", CURRENT_DATE) >= 120
    AND T0."DocStatus" = 'O';