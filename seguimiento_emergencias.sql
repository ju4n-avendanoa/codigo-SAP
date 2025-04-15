SELECT DISTINCT
  T0."DocNum" AS Solicitudcompra,
  T0."DocDate" as fecha_solicitud,
  T0."DocTime",
  T0."UpdateDate" AS fecha_procesado,
  T0."ReqName" as solicita,
  T2."DocNum" AS pedidocompra,
  CASE
    when T2."DocStatus" = 'C' then 'SI'
    when T2."DocStatus" = 'O' then 'NO'
  END AS procesado,
  T2."DocTime" as hora_creacion_pedido,
  CASE
    WHEN T0."U_Emergencia" = '1' THEN 'RED'
    WHEN T0."U_Emergencia" = '2' THEN 'BLUE'
    WHEN T0."U_Emergencia" = '3' THEN 'GROUND'
    WHEN T0."U_Emergencia" = '0' THEN 'NO'
  END Emergencia
FROM
  "BD_PARTEQUIPOS_PRO".OPRQ T0
  INNER JOIN "BD_PARTEQUIPOS_PRO".PRQ1 T1 ON T0."DocEntry" = T1."DocEntry"
  INNER JOIN "BD_PARTEQUIPOS_PRO".OPOR T2 ON T1."TrgetEntry" = T2."DocEntry"
  INNER JOIN "BD_PARTEQUIPOS_PRO".ORDR T3 ON T1."BaseEntry" = T3."DocEntry"
WHERE
  T0."U_Emergencia" != 0
  and T0."DocDate" >= '2024-01-01'
  and T0."DocDate" <= '2025-01-01'