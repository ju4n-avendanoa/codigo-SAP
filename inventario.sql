SELECT
  T1."ItemCode" AS "Código Artículo",
  T1."ItemName" AS "Nombre Artículo",
  T0."WhsCode" AS "Código Almacén",
  T1."OnHand" AS "Stock Disponible",
  T1."AvgPrice" AS "Costo Promedio",
  (T1."OnHand" * T1."AvgPrice") AS "Valor Total"
FROM
  "BD_PARTEQUIPOS_PRO".OITW T0
  JOIN "BD_PARTEQUIPOS_PRO".OITM T1 ON T0."ItemCode" = T1."ItemCode"
WHERE
  T0."OnHand" > 0
  AND T0."WhsCode" = '46CI'
