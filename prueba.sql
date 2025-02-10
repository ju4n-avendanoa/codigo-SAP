SELECT
    T0."U_Cmarca",
    T0."U_Ctipo",
    T0."U_Cfabricante",
    CASE
        WHEN T0."U_Categoria" = 1 THEN 'Stock '
        WHEN T0."U_Categoria" = 2 THEN 'Filtracion '
        WHEN T0."U_Categoria" = 3 THEN 'Lubricantes CORE '
        WHEN T0."U_Categoria" = 4 THEN 'Lubricantes NO CORE '
        WHEN T0."U_Categoria" = 5 THEN 'Inmovil '
        WHEN T0."U_Categoria" = 6 THEN 'Obsoleto '
        WHEN T0."U_Categoria" = 7 THEN 'Homologado '
        WHEN T0."U_Categoria" = 8 THEN 'Emergencia '
        WHEN T0."U_Categoria" = 9 THEN 'Informativa '
        WHEN T0."U_Categoria" = 10 THEN 'Compra local '
        WHEN T0."U_Categoria" = 11 THEN 'Usados '
        WHEN T0."U_Categoria" = 12 THEN 'Inactivo '
    END AS Categoria,
    T0."U_Clasificacion",
    T0."U_CodiCata",
    T0."ItemCode",
    T0."ItemName",
    T0."FrgnName",
    T0."OnHand",
    (
        (
            select
                SUM("OnHand")
            FROM
                "BD_PARTEQUIPOS_PRO".OITW
            WHERE
                "ItemCode" = T0."ItemCode"
                AND "WhsCode" = '17VBG'
        ) + (
            select
                SUM("OnHand")
            FROM
                "BD_PARTEQUIPOS_PRO".OITW
            WHERE
                "ItemCode" = T0."ItemCode"
                AND "WhsCode" = '43GT'
        ) + (
            select
                SUM("OnHand")
            FROM
                "BD_PARTEQUIPOS_PRO".OITW
            WHERE
                "ItemCode" = T0."ItemCode"
                AND "WhsCode" = '46CI'
        )
    ) AS GARANTIAS,
    IFNULL (
        (
            SELECT
                SUM(TA."OpenInvQty")
            FROM
                "BD_PARTEQUIPOS_PRO".PQT1 TA
            WHERE
                TA."ItemCode" = T0."ItemCode"
                and TA."LineStatus" = 'O'
        ),
        0
    ) AS "SOLITADO PROVEEDOR",
    IFNULL (
        (
            SELECT
                SUM(TC."Quantity")
            FROM
                "BD_PARTEQUIPOS_PRO".OPOR TB
                INNER JOIN "BD_PARTEQUIPOS_PRO".POR1 TC ON TB."DocEntry" = TC."DocEntry"
            WHERE
                TC."ItemCode" = T0."ItemCode"
                AND TB."Series" = '153'
                and TC."LineStatus" = 'O'
        ),
        0
    ) AS "despachado proveedor ",
    IFNULL (
        (
            SELECT
                SUM(TC."Quantity")
            FROM
                "BD_PARTEQUIPOS_PRO".OPOR TB
                INNER JOIN "BD_PARTEQUIPOS_PRO".POR1 TC ON TB."DocEntry" = TC."DocEntry"
            WHERE
                TC."ItemCode" = T0."ItemCode"
                AND TB."Series" != '153'
                and TC."LineStatus" = 'O'
        ),
        0
    ) AS "solicitado emergencia ",
    IFNULL (
        (
            SELECT
                SUM(TC."Quantity")
            FROM
                "BD_PARTEQUIPOS_PRO".OINV TB
                INNER JOIN "BD_PARTEQUIPOS_PRO".INV1 TC ON TB."DocEntry" = TC."DocEntry"
            WHERE
                TC."ItemCode" = T0."ItemCode"
                AND TB."DocDate" >= ADD_MONTHS (CURRENT_DATE, -6)
        ),
        0
    ) AS "VENTAS 6MESES",
    IFNULL (
        (
            SELECT
                SUM(TC."Quantity")
            FROM
                "BD_PARTEQUIPOS_PRO".ORIN TB
                INNER JOIN "BD_PARTEQUIPOS_PRO".RIN1 TC ON TB."DocEntry" = TC."DocEntry"
            WHERE
                TC."ItemCode" = T0."ItemCode"
                AND TB."DocDate" >= ADD_MONTHS (CURRENT_DATE, -6)
        ),
        0
    ) AS "NOTAS 6MESES",
    IFNULL (
        (
            SELECT
                SUM(TC."Quantity")
            FROM
                "BD_PARTEQUIPOS_PRO".ODLN TB
                INNER JOIN "BD_PARTEQUIPOS_PRO".DLN1 TC ON TB."DocEntry" = TC."DocEntry"
            WHERE
                TC."ItemCode" = T0."ItemCode"
                and TC."LineStatus" = 'O'
        ),
        0
    ) AS "ENTREGAS",
    (
        IFNULL (
            (
                SELECT
                    SUM(TC."Quantity")
                FROM
                    "BD_PARTEQUIPOS_PRO".OINV TB
                    INNER JOIN "BD_PARTEQUIPOS_PRO".INV1 TC ON TB."DocEntry" = TC."DocEntry"
                WHERE
                    TC."ItemCode" = T0."ItemCode"
                    AND TB."DocDate" >= ADD_MONTHS (CURRENT_DATE, -6)
            ),
            0
        ) - IFNULL (
            (
                SELECT
                    SUM(TC."Quantity")
                FROM
                    "BD_PARTEQUIPOS_PRO".ORIN TB
                    INNER JOIN "BD_PARTEQUIPOS_PRO".RIN1 TC ON TB."DocEntry" = TC."DocEntry"
                WHERE
                    TC."ItemCode" = T0."ItemCode"
                    AND TB."DocDate" >= ADD_MONTHS (CURRENT_DATE, -6)
            ),
            0
        )
    ) + IFNULL (
        (
            SELECT
                SUM(TC."Quantity")
            FROM
                "BD_PARTEQUIPOS_PRO".ODLN TB
                INNER JOIN "BD_PARTEQUIPOS_PRO".DLN1 TC ON TB."DocEntry" = TC."DocEntry"
            WHERE
                TC."ItemCode" = T0."ItemCode"
                and TC."LineStatus" = 'O'
        ),
        0
    ) AS "VENTAS NETAS 6MESES",
    T0."OnOrder",
    T0."IsCommited",
    T0."MinLevel",
    T0."MaxLevel",
    T0."CardCode",
    T0."U_GranFamilia",
    T0."U_Familia",
    T0."U_SubFamilia",
    T0."U_Metodo_Pedido",
    T0."SuppCatNum",
    T0."LstEvlPric",
    T0."LastPurPrc",
    T0."LstSalDate",
    T0."AvgPrice",
    T0."U_SuppCatNum",
    T0."U_Descfabricante",
    T0."U_PorcUtil",
    (
        select
            "MinStock"
        FROM
            "BD_PARTEQUIPOS_PRO".OITW
        WHERE
            "ItemCode" = T0."ItemCode"
            and "WhsCode" = '01BGW'
    ) as Min01BGW,
    (
        select
            "MinStock"
        FROM
            "BD_PARTEQUIPOS_PRO".OITW
        WHERE
            "ItemCode" = T0."ItemCode"
            and "WhsCode" = '02MD'
    ) as Min02MD,
    (
        select
            "MinStock"
        FROM
            "BD_PARTEQUIPOS_PRO".OITW
        WHERE
            "ItemCode" = T0."ItemCode"
            and "WhsCode" = '03BQ'
    ) as Min03BQ,
    (
        select
            "MinStock"
        FROM
            "BD_PARTEQUIPOS_PRO".OITW
        WHERE
            "ItemCode" = T0."ItemCode"
            and "WhsCode" = '04BU'
    ) as Min04BU,
    (
        select
            "MinStock"
        FROM
            "BD_PARTEQUIPOS_PRO".OITW
        WHERE
            "ItemCode" = T0."ItemCode"
            and "WhsCode" = '05CL'
    ) as Min05CL,
    (
        select
            "MinStock"
        FROM
            "BD_PARTEQUIPOS_PRO".OITW
        WHERE
            "ItemCode" = T0."ItemCode"
            and "WhsCode" = '06TMD'
    ) as Min06TMD,
    (
        select
            "MinStock"
        FROM
            "BD_PARTEQUIPOS_PRO".OITW
        WHERE
            "ItemCode" = T0."ItemCode"
            and "WhsCode" = '07TBG'
    ) as Min07TBG,
    (
        select
            "MinStock"
        FROM
            "BD_PARTEQUIPOS_PRO".OITW
        WHERE
            "ItemCode" = T0."ItemCode"
            and "WhsCode" = '08CC'
    ) as Min08CC,
    (
        select
            "MinStock"
        FROM
            "BD_PARTEQUIPOS_PRO".OITW
        WHERE
            "ItemCode" = T0."ItemCode"
            and "WhsCode" = '09MT'
    ) as Min09MT,
    (
        select
            "MinStock"
        FROM
            "BD_PARTEQUIPOS_PRO".OITW
        WHERE
            "ItemCode" = T0."ItemCode"
            and "WhsCode" = '10CH'
    ) as Min10CH,
    (
        select
            "MaxStock"
        FROM
            "BD_PARTEQUIPOS_PRO".OITW
        WHERE
            "ItemCode" = T0."ItemCode"
            and "WhsCode" = '01BGW'
    ) as Max01BGW,
    (
        select
            "MaxStock"
        FROM
            "BD_PARTEQUIPOS_PRO".OITW
        WHERE
            "ItemCode" = T0."ItemCode"
            and "WhsCode" = '02MD'
    ) as Max02MD,
    (
        select
            "MaxStock"
        FROM
            "BD_PARTEQUIPOS_PRO".OITW
        WHERE
            "ItemCode" = T0."ItemCode"
            and "WhsCode" = '03BQ'
    ) as Max03BQ,
    (
        select
            "MaxStock"
        FROM
            "BD_PARTEQUIPOS_PRO".OITW
        WHERE
            "ItemCode" = T0."ItemCode"
            and "WhsCode" = '04BU'
    ) as Max04BU,
    (
        select
            "MaxStock"
        FROM
            "BD_PARTEQUIPOS_PRO".OITW
        WHERE
            "ItemCode" = T0."ItemCode"
            and "WhsCode" = '05CL'
    ) as Max05CL,
    (
        select
            "MaxStock"
        FROM
            "BD_PARTEQUIPOS_PRO".OITW
        WHERE
            "ItemCode" = T0."ItemCode"
            and "WhsCode" = '06TMD'
    ) as Max06TMD,
    (
        select
            "MaxStock"
        FROM
            "BD_PARTEQUIPOS_PRO".OITW
        WHERE
            "ItemCode" = T0."ItemCode"
            and "WhsCode" = '07TBG'
    ) as Max07TBG,
    (
        select
            "MaxStock"
        FROM
            "BD_PARTEQUIPOS_PRO".OITW
        WHERE
            "ItemCode" = T0."ItemCode"
            and "WhsCode" = '08CC'
    ) as Max08CC,
    (
        select
            "MaxStock"
        FROM
            "BD_PARTEQUIPOS_PRO".OITW
        WHERE
            "ItemCode" = T0."ItemCode"
            and "WhsCode" = '09MT'
    ) as Max09MT,
    (
        select
            "MaxStock"
        FROM
            "BD_PARTEQUIPOS_PRO".OITW
        WHERE
            "ItemCode" = T0."ItemCode"
            and "WhsCode" = '10CH'
    ) as Max10CH,
    T11."DocEntry",
    T11."U_Cambio",
    T11."U_Marca",
    T12."U_Cambio",
    T12."U_Marca",
    T13."U_Cambio",
    T13."U_Marca",
    T14."U_Cambio",
    T14."U_Marca",
    T15."U_Cambio",
    T15."U_Marca",
    T16."U_Cambio",
    T16."U_Marca",
    T17."U_Cambio",
    T17."U_Marca",
    T18."U_Cambio",
    T18."U_Marca",
    T19."U_Cambio",
    T19."U_Marca",
    T20."U_Cambio",
    T20."U_Marca",
    T21."U_Cambio",
    T21."U_Marca",
    T22."U_Cambio",
    T22."U_Marca",
    T23."U_Cambio",
    T23."U_Marca",
    T24."U_Cambio",
    T24."U_Marca",
    T25."U_Cambio",
    T25."U_Marca",
    U11."U_Modelo",
    U11."U_Marca",
    U12."U_Modelo",
    U12."U_Marca",
    U13."U_Modelo",
    U13."U_Marca",
    U14."U_Modelo",
    U14."U_Marca",
    U15."U_Modelo",
    U15."U_Marca",
    U16."U_Modelo",
    U16."U_Marca",
    U17."U_Modelo",
    U17."U_Marca",
    U18."U_Modelo",
    U18."U_Marca",
    U19."U_Modelo",
    U19."U_Marca",
    U20."U_Modelo",
    U20."U_Marca",
    U21."U_Modelo",
    U21."U_Marca",
    U22."U_Modelo",
    U22."U_Marca",
    U23."U_Modelo",
    U23."U_Marca",
    U24."U_Modelo",
    U24."U_Marca",
    U25."U_Modelo",
    U25."U_Marca",
    V11."U_RefRe",
    V11."U_DesRe",
    V11."U_QtyRe",
    V11."U_ObsRe",
    V12."U_RefRe",
    V12."U_DesRe",
    V12."U_QtyRe",
    V12."U_ObsRe",
    V13."U_RefRe",
    V13."U_DesRe",
    V13."U_QtyRe",
    V13."U_ObsRe",
    V14."U_RefRe",
    V14."U_DesRe",
    V14."U_QtyRe",
    V14."U_ObsRe",
    V15."U_RefRe",
    V15."U_DesRe",
    V15."U_QtyRe",
    V15."U_ObsRe",
    V16."U_RefRe",
    V16."U_DesRe",
    V16."U_QtyRe",
    V16."U_ObsRe",
    V17."U_RefRe",
    V17."U_DesRe",
    V17."U_QtyRe",
    V17."U_ObsRe",
    V18."U_RefRe",
    V18."U_DesRe",
    V18."U_QtyRe",
    V18."U_ObsRe",
    V19."U_RefRe",
    V19."U_DesRe",
    V19."U_QtyRe",
    V19."U_ObsRe",
    V20."U_RefRe",
    V20."U_DesRe",
    V20."U_QtyRe",
    V20."U_ObsRe",
    V21."U_RefRe",
    V21."U_DesRe",
    V21."U_QtyRe",
    V21."U_ObsRe",
    V22."U_RefRe",
    V22."U_DesRe",
    V22."U_QtyRe",
    V22."U_ObsRe",
    V23."U_RefRe",
    V23."U_DesRe",
    V23."U_QtyRe",
    V23."U_ObsRe",
    V24."U_RefRe",
    V24."U_DesRe",
    V24."U_QtyRe",
    V24."U_ObsRe",
    V25."U_RefRe",
    V25."U_DesRe",
    V25."U_QtyRe",
    V25."U_ObsRe"
FROM
    "BD_PARTEQUIPOS_PRO".OITM T0
    LEFT JOIN (
        SELECT
            T11."U_Cambio",
            T11."U_Marca",
            T11."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_D" T11 on T2."DocEntry" = T11."DocEntry"
        WHERE
            T11."LineId" = 1
            AND T2."CreateDate" >= '20240418'
    ) T11 ON T11."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            T12."U_Cambio",
            T12."U_Marca",
            T12."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_D" T12 on T2."DocEntry" = T12."DocEntry"
        WHERE
            T12."LineId" = 2
            AND T2."CreateDate" >= '20240418'
    ) T12 ON T12."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            T13."U_Cambio",
            T13."U_Marca",
            T13."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_D" T13 on T2."DocEntry" = T13."DocEntry"
        WHERE
            T13."LineId" = 3
            AND T2."CreateDate" >= '20240418'
    ) T13 ON T13."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            T14."U_Cambio",
            T14."U_Marca",
            T14."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_D" T14 on T2."DocEntry" = T14."DocEntry"
        WHERE
            T14."LineId" = 4
            AND T2."CreateDate" >= '20240418'
    ) T14 ON T14."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            T15."U_Cambio",
            T15."U_Marca",
            T15."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_D" T15 on T2."DocEntry" = T15."DocEntry"
        WHERE
            T15."LineId" = 5
            AND T2."CreateDate" >= '20240418'
    ) T15 ON T15."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            T16."U_Cambio",
            T16."U_Marca",
            T16."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_D" T16 on T2."DocEntry" = T16."DocEntry"
        WHERE
            T16."LineId" = 6
            AND T2."CreateDate" >= '20240418'
    ) T16 ON T16."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            T17."U_Cambio",
            T17."U_Marca",
            T17."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_D" T17 on T2."DocEntry" = T17."DocEntry"
        WHERE
            T17."LineId" = 7
            AND T2."CreateDate" >= '20240418'
    ) T17 ON T17."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            T18."U_Cambio",
            T18."U_Marca",
            T18."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_D" T18 on T2."DocEntry" = T18."DocEntry"
        WHERE
            T18."LineId" = 8
            AND T2."CreateDate" >= '20240418'
    ) T18 ON T18."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            T19."U_Cambio",
            T19."U_Marca",
            T19."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_D" T19 on T2."DocEntry" = T19."DocEntry"
        WHERE
            T19."LineId" = 9
            AND T2."CreateDate" >= '20240418'
    ) T19 ON T19."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            T20."U_Cambio",
            T20."U_Marca",
            T20."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_D" T20 on T2."DocEntry" = T20."DocEntry"
        WHERE
            T20."LineId" = 10
            AND T2."CreateDate" >= '20240418'
    ) T20 ON T20."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            T21."U_Cambio",
            T21."U_Marca",
            T21."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_D" T21 on T2."DocEntry" = T21."DocEntry"
        WHERE
            T21."LineId" = 11
            AND T2."CreateDate" >= '20240418'
    ) T21 ON T21."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            T22."U_Cambio",
            T22."U_Marca",
            T22."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_D" T22 on T2."DocEntry" = T22."DocEntry"
        WHERE
            T22."LineId" = 12
            AND T2."CreateDate" >= '20240418'
    ) T22 ON T22."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            T23."U_Cambio",
            T23."U_Marca",
            T23."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_D" T23 on T2."DocEntry" = T23."DocEntry"
        WHERE
            T23."LineId" = 13
            AND T2."CreateDate" >= '20240418'
    ) T23 ON T23."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            T24."U_Cambio",
            T24."U_Marca",
            T24."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_D" T24 on T2."DocEntry" = T24."DocEntry"
        WHERE
            T24."LineId" = 14
            AND T2."CreateDate" >= '20240418'
    ) T24 ON T24."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            T25."U_Cambio",
            T25."U_Marca",
            T25."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_D" T25 on T2."DocEntry" = T25."DocEntry"
        WHERE
            T25."LineId" = 15
            AND T2."CreateDate" >= '20240418'
    ) T25 ON T25."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            U11."U_Modelo",
            U11."U_Marca",
            U11."U_Equipo",
            U11."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_M" U11 on T2."DocEntry" = U11."DocEntry"
        WHERE
            U11."LineId" = 1
            and T2."CreateDate" >= '20240418'
    ) U11 ON U11."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            U12."U_Modelo",
            U12."U_Marca",
            U12."U_Equipo",
            U12."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_M" U12 on T2."DocEntry" = U12."DocEntry"
        WHERE
            U12."LineId" = 2
            and T2."CreateDate" >= '20240418'
    ) U12 ON U12."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            U13."U_Modelo",
            U13."U_Marca",
            U13."U_Equipo",
            U13."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_M" U13 on T2."DocEntry" = U13."DocEntry"
        WHERE
            U13."LineId" = 3
            and T2."CreateDate" >= '20240418'
    ) U13 ON U13."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            U14."U_Modelo",
            U14."U_Marca",
            U14."U_Equipo",
            U14."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_M" U14 on T2."DocEntry" = U14."DocEntry"
        WHERE
            U14."LineId" = 4
            and T2."CreateDate" >= '20240418'
    ) U14 ON U14."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            U15."U_Modelo",
            U15."U_Marca",
            U15."U_Equipo",
            U15."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_M" U15 on T2."DocEntry" = U15."DocEntry"
        WHERE
            U15."LineId" = 5
            and T2."CreateDate" >= '20240418'
    ) U15 ON U15."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            U16."U_Modelo",
            U16."U_Marca",
            U16."U_Equipo",
            U16."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_M" U16 on T2."DocEntry" = U16."DocEntry"
        WHERE
            U16."LineId" = 6
            and T2."CreateDate" >= '20240418'
    ) U16 ON U16."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            U17."U_Modelo",
            U17."U_Marca",
            U17."U_Equipo",
            U17."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_M" U17 on T2."DocEntry" = U17."DocEntry"
        WHERE
            U17."LineId" = 7
            and T2."CreateDate" >= '20240418'
    ) U17 ON U17."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            U18."U_Modelo",
            U18."U_Marca",
            U18."U_Equipo",
            U18."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_M" U18 on T2."DocEntry" = U18."DocEntry"
        WHERE
            U18."LineId" = 8
            and T2."CreateDate" >= '20240418'
    ) U18 ON U18."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            U19."U_Modelo",
            U19."U_Marca",
            U19."U_Equipo",
            U19."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_M" U19 on T2."DocEntry" = U19."DocEntry"
        WHERE
            U19."LineId" = 9
            and T2."CreateDate" >= '20240418'
    ) U19 ON U19."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            U20."U_Modelo",
            U20."U_Marca",
            U20."U_Equipo",
            U20."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_M" U20 on T2."DocEntry" = U20."DocEntry"
        WHERE
            U20."LineId" = 10
            and T2."CreateDate" >= '20240418'
    ) U20 ON U20."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            U21."U_Modelo",
            U21."U_Marca",
            U21."U_Equipo",
            U21."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_M" U21 on T2."DocEntry" = U21."DocEntry"
        WHERE
            U21."LineId" = 11
            and T2."CreateDate" >= '20240418'
    ) U21 ON U21."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            U22."U_Modelo",
            U22."U_Marca",
            U22."U_Equipo",
            U22."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_M" U22 on T2."DocEntry" = U22."DocEntry"
        WHERE
            U22."LineId" = 12
            and T2."CreateDate" >= '20240418'
    ) U22 ON U22."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            U23."U_Modelo",
            U23."U_Marca",
            U23."U_Equipo",
            U23."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_M" U23 on T2."DocEntry" = U23."DocEntry"
        WHERE
            U23."LineId" = 13
            and T2."CreateDate" >= '20240418'
    ) U23 ON U23."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            U24."U_Modelo",
            U24."U_Marca",
            U24."U_Equipo",
            U24."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_M" U24 on T2."DocEntry" = U24."DocEntry"
        WHERE
            U24."LineId" = 14
            and T2."CreateDate" >= '20240418'
    ) U24 ON U24."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            U25."U_Modelo",
            U25."U_Marca",
            U25."U_Equipo",
            U25."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_M" U25 on T2."DocEntry" = U25."DocEntry"
        WHERE
            U25."LineId" = 15
            and T2."CreateDate" >= '20240418'
    ) U25 ON U25."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            V11."U_RefRe",
            V11."U_DesRe",
            V11."U_QtyRe",
            V11."U_ObsRe",
            V11."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_R" V11 on T2."DocEntry" = V11."DocEntry"
        WHERE
            V11."LineId" = 1
            and T2."CreateDate" >= '20240418'
    ) V11 ON V11."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            V12."U_RefRe",
            V12."U_DesRe",
            V12."U_QtyRe",
            V12."U_ObsRe",
            V12."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_R" V12 on T2."DocEntry" = V12."DocEntry"
        WHERE
            V12."LineId" = 2
            and T2."CreateDate" >= '20240418'
    ) V12 ON V12."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            V13."U_RefRe",
            V13."U_DesRe",
            V13."U_QtyRe",
            V13."U_ObsRe",
            V13."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_R" V13 on T2."DocEntry" = V13."DocEntry"
        WHERE
            V13."LineId" = 3
            and T2."CreateDate" >= '20240418'
    ) V13 ON V13."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            V14."U_RefRe",
            V14."U_DesRe",
            V14."U_QtyRe",
            V14."U_ObsRe",
            V14."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_R" V14 on T2."DocEntry" = V14."DocEntry"
        WHERE
            V14."LineId" = 4
            and T2."CreateDate" >= '20240418'
    ) V14 ON V14."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            V15."U_RefRe",
            V15."U_DesRe",
            V15."U_QtyRe",
            V15."U_ObsRe",
            V15."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_R" V15 on T2."DocEntry" = V15."DocEntry"
        WHERE
            V15."LineId" = 5
            and T2."CreateDate" >= '20240418'
    ) V15 ON V15."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            V16."U_RefRe",
            V16."U_DesRe",
            V16."U_QtyRe",
            V16."U_ObsRe",
            V16."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_R" V16 on T2."DocEntry" = V16."DocEntry"
        WHERE
            V16."LineId" = 6
            and T2."CreateDate" >= '20240418'
    ) V16 ON V16."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            V17."U_RefRe",
            V17."U_DesRe",
            V17."U_QtyRe",
            V17."U_ObsRe",
            V17."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_R" V17 on T2."DocEntry" = V17."DocEntry"
        WHERE
            V17."LineId" = 7
            and T2."CreateDate" >= '20240418'
    ) V17 ON V17."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            V18."U_RefRe",
            V18."U_DesRe",
            V18."U_QtyRe",
            V18."U_ObsRe",
            V18."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_R" V18 on T2."DocEntry" = V18."DocEntry"
        WHERE
            V18."LineId" = 8
            and T2."CreateDate" >= '20240418'
    ) V18 ON V18."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            V19."U_RefRe",
            V19."U_DesRe",
            V19."U_QtyRe",
            V19."U_ObsRe",
            V19."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_R" V19 on T2."DocEntry" = V19."DocEntry"
        WHERE
            V19."LineId" = 9
            and T2."CreateDate" >= '20240418'
    ) V19 ON V19."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            V20."U_RefRe",
            V20."U_DesRe",
            V20."U_QtyRe",
            V20."U_ObsRe",
            V20."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_R" V20 on T2."DocEntry" = V20."DocEntry"
        WHERE
            V20."LineId" = 10
            and T2."CreateDate" >= '20240418'
    ) V20 ON V20."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            V21."U_RefRe",
            V21."U_DesRe",
            V21."U_QtyRe",
            V21."U_ObsRe",
            V21."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_R" V21 on T2."DocEntry" = V21."DocEntry"
        WHERE
            V21."LineId" = 11
            and T2."CreateDate" >= '20240418'
    ) V21 ON V21."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            V22."U_RefRe",
            V22."U_DesRe",
            V22."U_QtyRe",
            V22."U_ObsRe",
            V22."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_R" V22 on T2."DocEntry" = V22."DocEntry"
        WHERE
            V22."LineId" = 12
            and T2."CreateDate" >= '20240418'
    ) V22 ON V22."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            V23."U_RefRe",
            V23."U_DesRe",
            V23."U_QtyRe",
            V23."U_ObsRe",
            V23."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_R" V23 on T2."DocEntry" = V23."DocEntry"
        WHERE
            V23."LineId" = 13
            and T2."CreateDate" >= '20240418'
    ) V23 ON V23."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            V24."U_RefRe",
            V24."U_DesRe",
            V24."U_QtyRe",
            V24."U_ObsRe",
            V24."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_R" V24 on T2."DocEntry" = V24."DocEntry"
        WHERE
            V24."LineId" = 14
            and T2."CreateDate" >= '20240418'
    ) V24 ON V24."U_ItemCode" = T0."ItemCode"
    LEFT JOIN (
        SELECT
            V25."U_RefRe",
            V25."U_DesRe",
            V25."U_QtyRe",
            V25."U_ObsRe",
            V25."LineId",
            T2."U_ItemCode",
            T2."CreateDate",
            T2."DocEntry"
        FROM
            "BD_PARTEQUIPOS_PRO"."@Q_CAM_MOD" T2
            INNER JOIN "BD_PARTEQUIPOS_PRO"."@Q_CAM_R" V25 on T2."DocEntry" = V25."DocEntry"
        WHERE
            V25."LineId" = 15
            and T2."CreateDate" >= '20240418'
    ) V25 ON V25."U_ItemCode" = T0."ItemCode"