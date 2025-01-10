SELECT 
    T0."DocNum", 
    T0."DocStatus",
    T0."DocDate", 
    T1."DiscPrcnt", 
    T0."CardName", 
    T0."CardCode" AS "NIT", 
    T2."ItemCode" AS "Referencia", 
    T2."ItemName", 
    T2."ItmsGrpCod", 
    T1."Quantity", 
    T1."LineTotal" AS "Total",
    T1."DocTotal", 
    T3."SlpName" AS "Asesor", 
    T4."U_NAME",
    CASE
        WHEN T0."U_Motivo_cierre" = '1' THEN 'Precio'
        WHEN T0."U_Motivo_cierre" = '9' THEN 'Cambio RUT' 
        WHEN T0."U_Motivo_cierre" IN ('2', '14') THEN 'Calidad'
        WHEN T0."U_Motivo_cierre" IN ('3', '13') THEN 'Marca'
        WHEN T0."U_Motivo_cierre" IN ('4', '12', '11') THEN 'Agotado nacional'
        WHEN T0."U_Motivo_cierre" = '5' THEN 'Agotado en sede'
        WHEN T0."U_Motivo_cierre" = '6' THEN 'Por sitio de entrega'
        WHEN T0."U_Motivo_cierre" = '7' THEN 'Por tiempo de importación'
        WHEN T0."U_Motivo_cierre" IN ('8', '10') THEN 'Duplicado'
        ELSE 'Sin motivo'
    END AS "Motivo de cierre",
    CASE
        WHEN T2."ItmsGrpCod" = 100 THEN 'Artículos'        
        WHEN T2."ItmsGrpCod" = 101 THEN 'Filtración IM'
        WHEN T2."ItmsGrpCod" = 102 THEN 'Lubricantes IM'        
        WHEN T2."ItmsGrpCod" = 103 THEN 'Herramientas de corte IM'        
        WHEN T2."ItmsGrpCod" = 104 THEN 'Tren de rodaje IM'        
        WHEN T2."ItmsGrpCod" = 105 THEN 'Llantas IM'        
        WHEN T2."ItmsGrpCod" = 106 THEN 'Motor Diesel (repuestos) IM'        
        WHEN T2."ItmsGrpCod" = 107 THEN 'Motor Diesel completo IM'        
        WHEN T2."ItmsGrpCod" = 108 THEN 'Hidráulico / Transmisión IM'        
        WHEN T2."ItmsGrpCod" = 109 THEN 'Mangueras'        
        WHEN T2."ItmsGrpCod" = 110 THEN 'Misceláneos (representados) IM'        
        WHEN T2."ItmsGrpCod" = 111 THEN 'Misceláneos (no representados) IM'        
        WHEN T2."ItmsGrpCod" = 112 THEN 'Martillos IM'        
        WHEN T2."ItmsGrpCod" = 113 THEN 'Filtración CL'        
        WHEN T2."ItmsGrpCod" = 114 THEN 'Lubricantes CL'        
        WHEN T2."ItmsGrpCod" = 115 THEN 'Herramientas de corte CL'        
        WHEN T2."ItmsGrpCod" = 116 THEN 'Tren de rodaje CL'        
        WHEN T2."ItmsGrpCod" = 117 THEN 'Llantas CL'        
        WHEN T2."ItmsGrpCod" = 118 THEN 'Motor Diesel (repuestos) CL'        
        WHEN T2."ItmsGrpCod" = 119 THEN 'Hidráulico / Transmisión CL'        
        WHEN T2."ItmsGrpCod" = 120 THEN 'Misceláneos (representados) CL'        
        WHEN T2."ItmsGrpCod" = 121 THEN 'Misceláneos (no representados) CL'        
        WHEN T2."ItmsGrpCod" = 122 THEN 'Fletes'        
        WHEN T2."ItmsGrpCod" = 123 THEN 'Componentes mayores IM'        
        WHEN T2."ItmsGrpCod" = 124 THEN 'Componentes mayores CL'        
        WHEN T2."ItmsGrpCod" = 125 THEN 'Servicios'        
        WHEN T2."ItmsGrpCod" = 126 THEN 'Gastos viaje PQMQ'        
        WHEN T2."ItmsGrpCod" = 132 THEN 'Costos de importación'        
        WHEN T2."ItmsGrpCod" = 133 THEN 'Depósito contenedor'    
    END AS "Grupo de artículo"

FROM OQUT T0  INNER JOIN QUT1 T1 ON T0."DocEntry" = T1."DocEntry" 
INNER JOIN OITM T2 ON T1."ItemCode" = T2."ItemCode" 
INNER JOIN OSLP T3 ON T0."SlpCode" = T3."SlpCode"
INNER JOIN OUSR T4 ON T0."UserSign" = T4."USERID"

WHERE T0."DocDate" >= [%0] AND T0."DocDate" <= [%1]