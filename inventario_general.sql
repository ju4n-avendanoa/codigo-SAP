SELECT
  T1."ItemCode" AS "Referencia",
  T1."ItemName" AS "Descripción",
  CASE
    WHEN T1."ItmsGrpCod" = 100 THEN 'Artículos'
    WHEN T1."ItmsGrpCod" = 101 THEN 'Filtración IM'
    WHEN T1."ItmsGrpCod" = 102 THEN 'Lubricantes IM'
    WHEN T1."ItmsGrpCod" = 103 THEN 'Herramientas de corte IM'
    WHEN T1."ItmsGrpCod" = 104 THEN 'Tren de rodaje IM'
    WHEN T1."ItmsGrpCod" = 105 THEN 'Llantas IM'
    WHEN T1."ItmsGrpCod" = 106 THEN 'Motor Diesel (repuestos) IM'
    WHEN T1."ItmsGrpCod" = 107 THEN 'Motor Diesel completo IM'
    WHEN T1."ItmsGrpCod" = 108 THEN 'Hidráulico / Transmisión IM'
    WHEN T1."ItmsGrpCod" = 109 THEN 'Mangueras'
    WHEN T1."ItmsGrpCod" = 110 THEN 'Misceláneos (representados) IM'
    WHEN T1."ItmsGrpCod" = 111 THEN 'Misceláneos (no representados) IM'
    WHEN T1."ItmsGrpCod" = 112 THEN 'Martillos IM'
    WHEN T1."ItmsGrpCod" = 113 THEN 'Filtración CL'
    WHEN T1."ItmsGrpCod" = 114 THEN 'Lubricantes CL'
    WHEN T1."ItmsGrpCod" = 115 THEN 'Herramientas de corte CL'
    WHEN T1."ItmsGrpCod" = 116 THEN 'Tren de rodaje CL'
    WHEN T1."ItmsGrpCod" = 117 THEN 'Llantas CL'
    WHEN T1."ItmsGrpCod" = 118 THEN 'Motor Diesel (repuestos) CL'
    WHEN T1."ItmsGrpCod" = 119 THEN 'Hidráulico / Transmisión CL'
    WHEN T1."ItmsGrpCod" = 120 THEN 'Misceláneos (representados) CL'
    WHEN T1."ItmsGrpCod" = 121 THEN 'Misceláneos (no representados) CL'
    WHEN T1."ItmsGrpCod" = 122 THEN 'Fletes'
    WHEN T1."ItmsGrpCod" = 123 THEN 'Componentes mayores IM'
    WHEN T1."ItmsGrpCod" = 124 THEN 'Componentes mayores CL'
    WHEN T1."ItmsGrpCod" = 125 THEN 'Servicios'
    WHEN T1."ItmsGrpCod" = 126 THEN 'Gastos viaje PQMQ'
    WHEN T1."ItmsGrpCod" = 132 THEN 'Costos de importación'
    WHEN T1."ItmsGrpCod" = 133 THEN 'Depósito contenedor'
    ELSE 'Otro'
  END AS "Grupo de Artículo",
  T1."OnHand" AS "Stock Real",
  T1."IsCommited" AS "Comprometido",
  T1."OnOrder" AS "En Orden",
  T1."U_Ntipo" AS "Tipo de Artículo",
  T1."U_Nmarca" AS "Marca",
  T1."U_Nfabricante" AS "Fabricante",
  T1."U_Clasificacion" AS "Clasificación",
  T1."AvgPrice" AS "Costo",
  (T1."AvgPrice" * T1."OnHand") AS "Valor en Inventario",
  CASE 
    WHEN T1."U_Categoria" = 1 THEN 'Stock'
    WHEN T1."U_Categoria" = 2 THEN 'Filtracion'
    WHEN T1."U_Categoria" = 3 THEN 'Lubricantes CORE'
    WHEN T1."U_Categoria" = 4 THEN 'Lubricantes NO CORE'
    WHEN T1."U_Categoria" = 5 THEN 'Inmovil'
    WHEN T1."U_Categoria" = 6 THEN 'Obsoleto'
    WHEN T1."U_Categoria" = 7 THEN 'Homologado'
    WHEN T1."U_Categoria" = 8 THEN 'Emergencia'
    WHEN T1."U_Categoria" = 9 THEN 'Informativa'
    WHEN T1."U_Categoria" = 10 THEN 'Compra local'
    WHEN T1."U_Categoria" = 11 THEN 'Usados'
    WHEN T1."U_Categoria" = 12 THEN 'Inactivo'
    ELSE 'Desconocido'
END AS "Categoria"
FROM
  BD_PARTEQUIPOS_PRO.OITM T1
WHERE
  T1."validFor" = 'Y' 
