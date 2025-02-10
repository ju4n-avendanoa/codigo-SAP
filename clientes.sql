SELECT DISTINCT
    T0."CardCode" AS "NIT",
    T0."CardName" AS "Cliente",
    T0."CreateDate" AS "Fecha de creación",
    (
        SELECT
            MAX(T2."DocDate")
        FROM
            BD_PARTEQUIPOS_PRO.OINV T2
        WHERE
            T2."CardCode" = T0."CardCode"
    ) AS "Ultima factura",
    (
        SELECT
            MAX(T2."DocDate")
        FROM
            BD_PARTEQUIPOS_PRO.OQUT T2
        WHERE
            T2."CardCode" = T0."CardCode"
    ) AS "Ultima Cotización",
    T0."Address" AS "Dirección",
    T0."City" AS "Ciudad",
    T3."Name" AS "Municipio",
    T4."FirstName" || ' ' || T4."MiddleName" || ' ' || T4."LastName" AS "Persona contacto",
    T0."Phone1" AS "Teléfono 1",
    T0."Phone2" AS "Teléfono 2",
    T0."Cellular" AS "Celular",
    T0."E_Mail" AS "Correo electrónico",
    T2."SlpName" AS "Asesor",
    T0."U_vendedor1" AS "Vendedor 1"
FROM
    "BD_PARTEQUIPOS_PRO".OCRD T0
    INNER JOIN "BD_PARTEQUIPOS_PRO".OSLP T2 ON T0."SlpCode" = T2."SlpCode"
    LEFT JOIN "BD_PARTEQUIPOS_PRO"."@BPCO_MU" T3 ON T3."Code" = T0."U_BPCO_CS"
    LEFT JOIN "BD_PARTEQUIPOS_PRO".OCPR T4 ON T0."CardCode" = T4."CardCode"
WHERE
    T0."validFor" = 'Y'
    AND T0."CardType" = 'C'
