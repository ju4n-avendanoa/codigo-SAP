SELECT
  T0."WddCode" AS CodigoFlujo,
  T2."Remarks" AS Plantilla,
  T0."WtmCode" AS CodigoPlantilla,
  T0."ObjType" AS TipoDocumento,
  CASE
    WHEN T0."ObjType" = 13 THEN 'Factura de venta'
    WHEN T0."ObjType" = 15 THEN 'Entrega'
    WHEN T0."ObjType" = 17 THEN 'Orden de venta'
    WHEN T0."ObjType" = 22 THEN 'Orden de compra'
    ELSE 'Otro'
  END AS Tipo,
  T0."CreateDate" AS FechaCreacion,
  T0."CreateTime" AS HoraCreacion,
  T1."UpdateDate" AS FechaAprobacion,
  T1."UpdateTime" AS HoraAprobacion,
  DAYS_BETWEEN (T0."CreateDate", T1."UpdateDate") AS Dias,
  ABS(
    (
      FLOOR(T0."CreateTime" / 100) * 60 + MOD(T0."CreateTime", 100)
    ) - (
      FLOOR(T1."UpdateTime" / 100) * 60 + MOD(T1."UpdateTime", 100)
    )
  ) AS MinutosEnAutorizar,
  T1."Status" AS Estado,
  T3."U_NAME" AS Aprobador
FROM
  "BD_PARTEQUIPOS_PRO".OWDD T0
  INNER JOIN "BD_PARTEQUIPOS_PRO".WDD1 T1 ON T0."WddCode" = T1."WddCode"
  AND T1."Status" = 'Y'
  INNER JOIN "BD_PARTEQUIPOS_PRO".OWTM T2 ON T0."WtmCode" = T2."WtmCode"
  INNER JOIN "BD_PARTEQUIPOS_PRO".OUSR T3 ON T3."USERID" = T1."UserID";
