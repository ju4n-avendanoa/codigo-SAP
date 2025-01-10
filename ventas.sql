SELECT     
    YEAR(T0."DocDate") AS "Year",
    T0."DocDate",
    T0."DocNum",
    CASE        
        WHEN T0."GroupNum" = -1 THEN 'Contado'        
        ELSE 'Crédito'    
    END AS "Tipo de pago",
    'Factura' AS "Tipo documento",
    T0."NumAtCard" AS "Ecommerce",
    CASE
        WHEN T4."ItmsGrpCod" = 100 THEN 'Artículos'        
        WHEN T4."ItmsGrpCod" = 101 THEN 'Filtración IM'
        WHEN T4."ItmsGrpCod" = 102 THEN 'Lubricantes IM'        
        WHEN T4."ItmsGrpCod" = 103 THEN 'Herramientas de corte IM'        
        WHEN T4."ItmsGrpCod" = 104 THEN 'Tren de rodaje IM'        
        WHEN T4."ItmsGrpCod" = 105 THEN 'Llantas IM'        
        WHEN T4."ItmsGrpCod" = 106 THEN 'Motor Diesel (repuestos) IM'        
        WHEN T4."ItmsGrpCod" = 107 THEN 'Motor Diesel completo IM'        
        WHEN T4."ItmsGrpCod" = 108 THEN 'Hidráulico / Transmisión IM'        
        WHEN T4."ItmsGrpCod" = 109 THEN 'Mangueras'        
        WHEN T4."ItmsGrpCod" = 110 THEN 'Misceláneos (representados) IM'        
        WHEN T4."ItmsGrpCod" = 111 THEN 'Misceláneos (no representados) IM'        
        WHEN T4."ItmsGrpCod" = 112 THEN 'Martillos IM'        
        WHEN T4."ItmsGrpCod" = 113 THEN 'Filtración CL'        
        WHEN T4."ItmsGrpCod" = 114 THEN 'Lubricantes CL'        
        WHEN T4."ItmsGrpCod" = 115 THEN 'Herramientas de corte CL'        
        WHEN T4."ItmsGrpCod" = 116 THEN 'Tren de rodaje CL'        
        WHEN T4."ItmsGrpCod" = 117 THEN 'Llantas CL'        
        WHEN T4."ItmsGrpCod" = 118 THEN 'Motor Diesel (repuestos) CL'        
        WHEN T4."ItmsGrpCod" = 119 THEN 'Hidráulico / Transmisión CL'        
        WHEN T4."ItmsGrpCod" = 120 THEN 'Misceláneos (representados) CL'        
        WHEN T4."ItmsGrpCod" = 121 THEN 'Misceláneos (no representados) CL'        
        WHEN T4."ItmsGrpCod" = 122 THEN 'Fletes'        
        WHEN T4."ItmsGrpCod" = 123 THEN 'Componentes mayores IM'        
        WHEN T4."ItmsGrpCod" = 124 THEN 'Componentes mayores CL'        
        WHEN T4."ItmsGrpCod" = 125 THEN 'Servicios'        
        WHEN T4."ItmsGrpCod" = 126 THEN 'Gastos viaje PQMQ'        
        WHEN T4."ItmsGrpCod" = 132 THEN 'Costos de importación'        
        WHEN T4."ItmsGrpCod" = 133 THEN 'Depósito contenedor'    
    END AS "Grupo de artículo",
    T0."CardCode" AS "NIT",    
    T0."CardName",
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
    T2."SlpName" AS "Asesores",
    T1."ItemCode" AS "Referencias",    
    T4."U_Nmarca" AS "Marca",    
    T4."U_Nfabricante" AS "Fabricante",
    T1."Dscription" AS "Descripción",
    T1."Quantity" AS "Cantidad",
    T1."LineTotal" AS "Total",
    T5."U_NAME"

FROM OINV T0
INNER JOIN INV1 T1 ON T0."DocEntry" = T1."DocEntry"
INNER JOIN OSLP T2 ON T0."SlpCode" = T2."SlpCode"
INNER JOIN OCRD T3 ON T0."CardCode" = T3."CardCode"
INNER JOIN OITM T4 ON T1."ItemCode" = T4."ItemCode"
INNER JOIN OUSR T5 ON T0."UserSign" = T5."USERID"

WHERE T0."DocDate" >= [%0]

UNION ALL

SELECT
    YEAR(T0."DocDate") AS "Year",
    T0."DocDate",
    T0."DocNum",
    CASE        
        WHEN T0."GroupNum" = -1 THEN 'Contado'        
        ELSE 'Crédito'    
    END AS "Tipo de pago",
    'Nota crédito' AS "Tipo documento",
    T0."NumAtCard" AS "Ecommerce",
    CASE
        WHEN T4."ItmsGrpCod" = 100 THEN 'Artículos'        
        WHEN T4."ItmsGrpCod" = 101 THEN 'Filtración IM'
        WHEN T4."ItmsGrpCod" = 102 THEN 'Lubricantes IM'        
        WHEN T4."ItmsGrpCod" = 103 THEN 'Herramientas de corte IM'        
        WHEN T4."ItmsGrpCod" = 104 THEN 'Tren de rodaje IM'        
        WHEN T4."ItmsGrpCod" = 105 THEN 'Llantas IM'        
        WHEN T4."ItmsGrpCod" = 106 THEN 'Motor Diesel (repuestos) IM'        
        WHEN T4."ItmsGrpCod" = 107 THEN 'Motor Diesel completo IM'        
        WHEN T4."ItmsGrpCod" = 108 THEN 'Hidráulico / Transmisión IM'        
        WHEN T4."ItmsGrpCod" = 109 THEN 'Mangueras'        
        WHEN T4."ItmsGrpCod" = 110 THEN 'Misceláneos (representados) IM'        
        WHEN T4."ItmsGrpCod" = 111 THEN 'Misceláneos (no representados) IM'        
        WHEN T4."ItmsGrpCod" = 112 THEN 'Martillos IM'        
        WHEN T4."ItmsGrpCod" = 113 THEN 'Filtración CL'        
        WHEN T4."ItmsGrpCod" = 114 THEN 'Lubricantes CL'        
        WHEN T4."ItmsGrpCod" = 115 THEN 'Herramientas de corte CL'        
        WHEN T4."ItmsGrpCod" = 116 THEN 'Tren de rodaje CL'        
        WHEN T4."ItmsGrpCod" = 117 THEN 'Llantas CL'        
        WHEN T4."ItmsGrpCod" = 118 THEN 'Motor Diesel (repuestos) CL'        
        WHEN T4."ItmsGrpCod" = 119 THEN 'Hidráulico / Transmisión CL'        
        WHEN T4."ItmsGrpCod" = 120 THEN 'Misceláneos (representados) CL'        
        WHEN T4."ItmsGrpCod" = 121 THEN 'Misceláneos (no representados) CL'        
        WHEN T4."ItmsGrpCod" = 122 THEN 'Fletes'        
        WHEN T4."ItmsGrpCod" = 123 THEN 'Componentes mayores IM'        
        WHEN T4."ItmsGrpCod" = 124 THEN 'Componentes mayores CL'        
        WHEN T4."ItmsGrpCod" = 125 THEN 'Servicios'        
        WHEN T4."ItmsGrpCod" = 126 THEN 'Gastos viaje PQMQ'        
        WHEN T4."ItmsGrpCod" = 132 THEN 'Costos de importación'        
        WHEN T4."ItmsGrpCod" = 133 THEN 'Depósito contenedor'    
    END AS "Grupo de artículo",
    T0."CardCode" AS "NIT",    
    T0."CardName",
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
    T2."SlpName" AS "Asesores",
    T1."ItemCode" AS "Referencias",    
    T4."U_Nmarca" AS "Marca",    
    T4."U_Nfabricante" AS "Fabricante",
    T1."Dscription" AS "Descripción",
    T1."Quantity" * (-1) as "Cantidad",
    T1."LineTotal" * (-1) as "Total",
    T5."U_NAME"

FROM ORIN T0 
INNER JOIN RIN1 T1 ON T0."DocEntry" = T1."DocEntry" 
INNER JOIN OSLP T2 ON T0."SlpCode" = T2."SlpCode"
INNER JOIN OCRD T3 ON T0."CardCode" = T3."CardCode"
INNER JOIN OITM T4 ON T1."ItemCode" = T4."ItemCode"
INNER JOIN OUSR T5 ON T0."UserSign" = T5."USERID"

WHERE T0."DocDate" >= [%0] AND T0."DocType" = 'I' AND T1."BaseType" <> 16 
