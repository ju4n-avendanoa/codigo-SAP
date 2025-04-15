SELECT distinct
  T1."DocNum" AS PEDIDO,
  T1."U_SerieUSA",
  T1."U_Linea",
  T2."ItemCode",
  T2."Dscription",
  CASE
    WHEN T5."U_Categoria" = 1 THEN ' Stock '
    WHEN T5."U_Categoria" = 2 THEN ' Emergencia '
    WHEN T5."U_Categoria" = 3 THEN ' Obsoleto '
    WHEN T5."U_Categoria" = 4 THEN ' Inactivo '
    WHEN T5."U_Categoria" = 5 THEN ' Compra local '
    WHEN T5."U_Categoria" = 6 THEN ' Inmovil '
    WHEN T5."U_Categoria" = 7 THEN ' Lubricantes NO CORE '
    WHEN T5."U_Categoria" = 8 THEN ' Filtracion '
    WHEN T5."U_Categoria" = 9 THEN ' Lubricantes CORE '
    WHEN T5."U_Categoria" = 10 THEN ' Homologado '
    WHEN T5."U_Categoria" = 11 THEN ' Usados '
  END Categoria,
  CASE
    WHEN T1."U_Emergencia" = 1 THEN 'RED'
    WHEN T1."U_Emergencia" = 2 THEN 'BLUE'
    WHEN T1."U_Emergencia" = 3 THEN 'GROUND'
    WHEN T1."U_Emergencia" = 4 THEN 'NO'
  END Emergencia,
  T1."DocDate",
  T1."DocDueDate",
  T1."DocStatus",
  T4."DocDate" fecha_entrada,
  DAYS_BETWEEN (T1."DocDate", T4."DocDate") AS dias,
  CASE
    WHEN T1."U_EstaPeImpor" = 1 THEN 'Vuelo'
    WHEN T1."U_EstaPeImpor" = 2 THEN 'Miami'
    WHEN T1."U_EstaPeImpor" = 3 THEN 'Cancelado'
    WHEN T1."U_EstaPeImpor" = 4 THEN 'Backorder'
    WHEN T1."U_EstaPeImpor" = 5 THEN 'Solicitado a usa'
    WHEN T1."U_EstaPeImpor" = 6 THEN 'En bodega'
  END Estadopedido,
  T1."U_ComEstaPed"
FROM
  "BD_PARTEQUIPOS_PRO".OPOR T1
    INNER JOIN "BD_PARTEQUIPOS_PRO".POR1 T2 ON T1."DocEntry" = T2."DocEntry"
    INNER JOIN "BD_PARTEQUIPOS_PRO".PDN1 T3 ON T1."DocEntry" = T3."BaseEntry"
    INNER JOIN "BD_PARTEQUIPOS_PRO".OPDN T4 ON T3."DocEntry" = T4."DocEntry"
    INNER JOIN "BD_PARTEQUIPOS_PRO".OITM T5 ON T2."ItemCode" = T5."ItemCode"
WHERE
  T2."BaseEntry" IS NOT NULL
  and T1."U_Emergencia" IN ('1', '2', '3')
  AND T1."DocDate" BETWEEN '2024-10-01' AND '2025-01-01'
