SELECT
    T0."DocDate" AS "Fecha de contabilización",
    T0."DocNum" AS "Número de documento",
    'Factura' AS "Tipo de documento",
    CASE
        WHEN T0."GroupNum" = -1 THEN 'Contado'
        ELSE 'Crédito'
    END AS "Tipo de pago",
    T0."NumAtCard" AS "Ecommerce",
    CASE
        WHEN T4."ItmsGrpCod" = 100 THEN 'Artículos'
        WHEN T4."ItmsGrpCod" = 101 THEN 'Filtración'
        WHEN T4."ItmsGrpCod" = 102 THEN 'Lubricantes'
        WHEN T4."ItmsGrpCod" = 103 THEN 'Herramientas de corte'
        WHEN T4."ItmsGrpCod" = 104 THEN 'Tren de rodaje'
        WHEN T4."ItmsGrpCod" = 105 THEN 'Llantas'
        WHEN T4."ItmsGrpCod" = 106 THEN 'Motor Diesel (repuestos)'
        WHEN T4."ItmsGrpCod" = 107 THEN 'Motor Diesel completo'
        WHEN T4."ItmsGrpCod" = 108 THEN 'Hidráulico / Transmisión'
        WHEN T4."ItmsGrpCod" = 109 THEN 'Mangueras'
        WHEN T4."ItmsGrpCod" = 110 THEN 'Misceláneos (representados)'
        WHEN T4."ItmsGrpCod" = 111 THEN 'Misceláneos (no representados)'
        WHEN T4."ItmsGrpCod" = 112 THEN 'Martillos'
        WHEN T4."ItmsGrpCod" = 113 THEN 'Filtración'
        WHEN T4."ItmsGrpCod" = 114 THEN 'Lubricantes'
        WHEN T4."ItmsGrpCod" = 115 THEN 'Herramientas de corte'
        WHEN T4."ItmsGrpCod" = 116 THEN 'Tren de rodaje'
        WHEN T4."ItmsGrpCod" = 117 THEN 'Llantas'
        WHEN T4."ItmsGrpCod" = 118 THEN 'Motor Diesel (repuestos)'
        WHEN T4."ItmsGrpCod" = 119 THEN 'Hidráulico / Transmisión'
        WHEN T4."ItmsGrpCod" = 120 THEN 'Misceláneos (representados)'
        WHEN T4."ItmsGrpCod" = 121 THEN 'Misceláneos (no representados)'
        WHEN T4."ItmsGrpCod" = 122 THEN 'Fletes'
        WHEN T4."ItmsGrpCod" = 123 THEN 'Componentes mayores'
        WHEN T4."ItmsGrpCod" = 124 THEN 'Componentes mayores'
        WHEN T4."ItmsGrpCod" = 125 THEN 'Servicios'
        WHEN T4."ItmsGrpCod" = 126 THEN 'Gastos viaje PQMQ'
        WHEN T4."ItmsGrpCod" = 132 THEN 'Costos de importación'
        WHEN T4."ItmsGrpCod" = 133 THEN 'Depósito contenedor'
    END AS "Grupo de artículo",
    T0."CardCode" AS "NIT",
    T0."CardName" AS "Cliente",
    CASE
        WHEN T3."GroupCode" = 100 THEN 'Contratistas'
        WHEN T3."GroupCode" = 102 THEN 'Sector oficial'
        WHEN T3."GroupCode" = 103 THEN 'Construcción/Vivienda'
        WHEN T3."GroupCode" = 104 THEN 'Construcción/Vías'
        WHEN T3."GroupCode" = 105 THEN 'Transporte'
        WHEN T3."GroupCode" = 119 THEN 'Saneamiento ambiental/Gestión desechos'
        WHEN T3."GroupCode" = 107 THEN 'Alquiler/Renta'
        WHEN T3."GroupCode" = 108 THEN 'Mecánico/Taller'
        WHEN T3."GroupCode" = 109 THEN 'Agro/Industria'
        WHEN T3."GroupCode" = 110 THEN 'Minería/Oro'
        WHEN T3."GroupCode" = 111 THEN 'Cantera/Agregados'
        WHEN T3."GroupCode" = 112 THEN 'Construcción/Infraestructura'
        WHEN T3."GroupCode" = 113 THEN 'Servicios petroleros'
        WHEN T3."GroupCode" = 101 THEN 'Proveedor Nacional'
        WHEN T3."GroupCode" = 114 THEN 'Proveedor Extranjero'
        WHEN T3."GroupCode" = 115 THEN 'Empleado'
        WHEN T3."GroupCode" = 116 THEN 'Otros'
        WHEN T3."GroupCode" = 117 THEN 'Lubricantes'
        WHEN T3."GroupCode" = 118 THEN 'Minerales no metálicos/Cemento'
        WHEN T3."GroupCode" = 120 THEN 'Energéticos'
        WHEN T3."GroupCode" = 106 THEN 'Almacén/Distribuidor'
        WHEN T3."GroupCode" = 121 THEN 'Asalariados'
    END AS "Grupo de clientes",
    T2."SlpName" AS "Asesor",
    T1."ItemCode" AS "Referencia",
    T4."U_Nmarca" AS "Marca",
    T4."U_Nfabricante" AS "Fabricante",
    T1."Dscription" AS "Descripción",
    T1."StockPrice" * T1."Quantity" AS "Costo total",
    T1."Quantity" AS "Cantidad",
    T1."LineTotal" AS "Total",
    T5."U_NAME" AS "Usuario",
    T4."U_Ntipo" AS "Tipo referencia",
    T1."WhsCode" AS "Almacén",
    T4."U_Clasificacion" AS "Clasificación",
    T0."U_Vendedor",
    T4."CardCode" AS "Proveedor",
    T6."CardName" AS "Nombre Proveedor"
FROM
    "BD_PARTEQUIPOS_PRO".OINV T0
    INNER JOIN "BD_PARTEQUIPOS_PRO".INV1 T1 ON T0."DocEntry" = T1."DocEntry"
    INNER JOIN "BD_PARTEQUIPOS_PRO".OSLP T2 ON T0."SlpCode" = T2."SlpCode"
    INNER JOIN "BD_PARTEQUIPOS_PRO".OCRD T3 ON T0."CardCode" = T3."CardCode"
    INNER JOIN "BD_PARTEQUIPOS_PRO".OITM T4 ON T1."ItemCode" = T4."ItemCode"
    INNER JOIN "BD_PARTEQUIPOS_PRO".OUSR T5 ON T0."UserSign" = T5."USERID"
    LEFT JOIN "BD_PARTEQUIPOS_PRO".OCRD T6 ON T4."CardCode" = T6."CardCode"
WHERE
    T0."DocDate" >= '2024-01-01'
    AND T0."DocDate" < '2026-04-01'
UNION ALL
SELECT
    T0."DocDate" AS "Fecha de contabilización",
    T0."DocNum" AS "Número de documento",
    'Nota crédito' AS "Tipo de documento",
    CASE
        WHEN T0."GroupNum" = -1 THEN 'Contado'
        ELSE 'Crédito'
    END AS "Tipo de pago",
    T0."NumAtCard" AS "Ecommerce",
    CASE
        WHEN T4."ItmsGrpCod" = 100 THEN 'Artículos'
        WHEN T4."ItmsGrpCod" = 101 THEN 'Filtración'
        WHEN T4."ItmsGrpCod" = 102 THEN 'Lubricantes'
        WHEN T4."ItmsGrpCod" = 103 THEN 'Herramientas de corte'
        WHEN T4."ItmsGrpCod" = 104 THEN 'Tren de rodaje'
        WHEN T4."ItmsGrpCod" = 105 THEN 'Llantas'
        WHEN T4."ItmsGrpCod" = 106 THEN 'Motor Diesel (repuestos)'
        WHEN T4."ItmsGrpCod" = 107 THEN 'Motor Diesel completo'
        WHEN T4."ItmsGrpCod" = 108 THEN 'Hidráulico / Transmisión'
        WHEN T4."ItmsGrpCod" = 109 THEN 'Mangueras'
        WHEN T4."ItmsGrpCod" = 110 THEN 'Misceláneos (representados)'
        WHEN T4."ItmsGrpCod" = 111 THEN 'Misceláneos (no representados)'
        WHEN T4."ItmsGrpCod" = 112 THEN 'Martillos'
        WHEN T4."ItmsGrpCod" = 113 THEN 'Filtración'
        WHEN T4."ItmsGrpCod" = 114 THEN 'Lubricantes'
        WHEN T4."ItmsGrpCod" = 115 THEN 'Herramientas de corte'
        WHEN T4."ItmsGrpCod" = 116 THEN 'Tren de rodaje'
        WHEN T4."ItmsGrpCod" = 117 THEN 'Llantas'
        WHEN T4."ItmsGrpCod" = 118 THEN 'Motor Diesel (repuestos)'
        WHEN T4."ItmsGrpCod" = 119 THEN 'Hidráulico / Transmisión'
        WHEN T4."ItmsGrpCod" = 120 THEN 'Misceláneos (representados)'
        WHEN T4."ItmsGrpCod" = 121 THEN 'Misceláneos (no representados)'
        WHEN T4."ItmsGrpCod" = 122 THEN 'Fletes'
        WHEN T4."ItmsGrpCod" = 123 THEN 'Componentes mayores'
        WHEN T4."ItmsGrpCod" = 124 THEN 'Componentes mayores'
        WHEN T4."ItmsGrpCod" = 125 THEN 'Servicios'
        WHEN T4."ItmsGrpCod" = 126 THEN 'Gastos viaje PQMQ'
        WHEN T4."ItmsGrpCod" = 132 THEN 'Costos de importación'
        WHEN T4."ItmsGrpCod" = 133 THEN 'Depósito contenedor'
    END AS "Grupo de artículo",
    T0."CardCode" AS "NIT",
    T0."CardName" AS "Cliente",
    CASE
        WHEN T3."GroupCode" = 100 THEN 'Contratistas'
        WHEN T3."GroupCode" = 102 THEN 'Sector oficial'
        WHEN T3."GroupCode" = 103 THEN 'Construcción/Vivienda'
        WHEN T3."GroupCode" = 104 THEN 'Construcción/Vías'
        WHEN T3."GroupCode" = 105 THEN 'Transporte'
        WHEN T3."GroupCode" = 119 THEN 'Saneamiento ambiental/Gestión desechos'
        WHEN T3."GroupCode" = 107 THEN 'Alquiler/Renta'
        WHEN T3."GroupCode" = 108 THEN 'Mecánico/Taller'
        WHEN T3."GroupCode" = 109 THEN 'Agro/Industria'
        WHEN T3."GroupCode" = 110 THEN 'Minería/Oro'
        WHEN T3."GroupCode" = 111 THEN 'Cantera/Agregados'
        WHEN T3."GroupCode" = 112 THEN 'Construcción/Infraestructura'
        WHEN T3."GroupCode" = 113 THEN 'Servicios petroleros'
        WHEN T3."GroupCode" = 101 THEN 'Proveedor Nacional'
        WHEN T3."GroupCode" = 114 THEN 'Proveedor Extranjero'
        WHEN T3."GroupCode" = 115 THEN 'Empleado'
        WHEN T3."GroupCode" = 116 THEN 'Otros'
        WHEN T3."GroupCode" = 117 THEN 'Lubricantes'
        WHEN T3."GroupCode" = 118 THEN 'Minerales no metálicos/Cemento'
        WHEN T3."GroupCode" = 120 THEN 'Energéticos'
        WHEN T3."GroupCode" = 106 THEN 'Almacén/Distribuidor'
        WHEN T3."GroupCode" = 121 THEN 'Asalariados'
    END AS "Grupo de clientes",
    T2."SlpName" AS "Asesor",
    T1."ItemCode" AS "Referencia",
    T4."U_Nmarca" AS "Marca",
    T4."U_Nfabricante" AS "Fabricante",
    T1."Dscription" AS "Descripción",
    (T1."StockPrice" * T1."Quantity") * -1 AS "Costo total",
    T1."Quantity" * (-1) AS "Cantidad",
    T1."LineTotal" * (-1) AS "Total",
    T5."U_NAME" AS "Usuario",
    T4."U_Ntipo" AS "Tipo referencia",
    T1."WhsCode" AS "Almacén",
    T4."U_Clasificacion" AS "Clasificación",
    T0."U_Vendedor",
    T4."CardCode" AS "Proveedor",
    T6."CardName" AS "Nombre Proveedor"
FROM
    "BD_PARTEQUIPOS_PRO".ORIN T0
    INNER JOIN "BD_PARTEQUIPOS_PRO".RIN1 T1 ON T0."DocEntry" = T1."DocEntry"
    INNER JOIN "BD_PARTEQUIPOS_PRO".OSLP T2 ON T0."SlpCode" = T2."SlpCode"
    INNER JOIN "BD_PARTEQUIPOS_PRO".OCRD T3 ON T0."CardCode" = T3."CardCode"
    INNER JOIN "BD_PARTEQUIPOS_PRO".OITM T4 ON T1."ItemCode" = T4."ItemCode"
    INNER JOIN "BD_PARTEQUIPOS_PRO".OUSR T5 ON T0."UserSign" = T5."USERID"
    LEFT JOIN "BD_PARTEQUIPOS_PRO".OCRD T6 ON T4."CardCode" = T6."CardCode"
WHERE
    T0."DocDate" >= '2024-01-01'
    AND T0."DocDate" < '2026-04-01'