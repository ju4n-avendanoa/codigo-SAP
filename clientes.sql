SELECT DISTINCT
    T0."CardCode" AS "NIT",
    T0."CardName" AS "Cliente",
    T0."CreateDate",
    T0."Address",
    T0."City",
    T3."Name" AS "Municipio",
    T0."Phone1",
    T0."Phone2",
    T0."Cellular",
    T0."E_Mail",
    T2."SlpName" AS "Asesor",
    T0."U_vendedor1",
    T0."U_Vendedor2"
FROM
    OCRD T0
    INNER JOIN CRD1 T1 ON T0."CardCode" = T1."CardCode"
    INNER JOIN OSLP T2 ON T0."SlpCode" = T2."SlpCode"
    LEFT JOIN "BD_PARTEQUIPOS_PRO"."@BPCO_MU" T3 ON T3."Code" = T0."U_BPCO_CS"
WHERE
    T0."validFor" = 'Y'
    AND T0."CardType" = 'C'