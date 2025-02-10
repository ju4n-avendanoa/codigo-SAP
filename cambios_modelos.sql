SELECT
    T0."ItemCode",
    T3."U_Cambio" AS "Cambio",
    NULL AS "Modelo",
    T3."U_Marca" AS "Marca"
FROM
    "BD_PARTEQUIPOS_PRO".OITM T0
    INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T1 ON T1."U_ItemCode" = T0."ItemCode"
    INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_D" T3 ON T1."DocEntry" = T3."DocEntry"
WHERE
    T1."U_ItemCode" = '119802-55710-GYAR'
UNION ALL
SELECT
    T0."ItemCode",
    NULL AS "Cambio",
    T2."U_Modelo" AS "Modelo",
    T2."U_Marca" AS "Marca"
FROM
    "BD_PARTEQUIPOS_PRO".OITM T0
    INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T1 ON T1."U_ItemCode" = T0."ItemCode"
    INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_M" T2 ON T1."DocEntry" = T2."DocEntry"
WHERE
    T1."U_ItemCode" = '119802-55710-GYAR';


