SELECT
    CASE
        WHEN T1."ItmsGrpCod" = 100 THEN 'Artículos'
        WHEN T1."ItmsGrpCod" = 101 THEN 'Filtración'
        WHEN T1."ItmsGrpCod" = 102 THEN 'Lubricantes'
        WHEN T1."ItmsGrpCod" = 103 THEN 'Herramientas de corte'
        WHEN T1."ItmsGrpCod" = 104 THEN 'Tren de rodaje'
        WHEN T1."ItmsGrpCod" = 105 THEN 'Llantas'
        WHEN T1."ItmsGrpCod" = 106 THEN 'Motor Diesel (repuestos)'
        WHEN T1."ItmsGrpCod" = 107 THEN 'Motor Diesel completo'
        WHEN T1."ItmsGrpCod" = 108 THEN 'Hidráulico / Transmisión'
        WHEN T1."ItmsGrpCod" = 109 THEN 'Mangueras'
        WHEN T1."ItmsGrpCod" = 110 THEN 'Misceláneos (representados)'
        WHEN T1."ItmsGrpCod" = 111 THEN 'Misceláneos (no representados)'
        WHEN T1."ItmsGrpCod" = 112 THEN 'Martillos'
        WHEN T1."ItmsGrpCod" = 113 THEN 'Filtración'
        WHEN T1."ItmsGrpCod" = 114 THEN 'Lubricantes'
        WHEN T1."ItmsGrpCod" = 115 THEN 'Herramientas de corte'
        WHEN T1."ItmsGrpCod" = 116 THEN 'Tren de rodaje'
        WHEN T1."ItmsGrpCod" = 117 THEN 'Llantas'
        WHEN T1."ItmsGrpCod" = 118 THEN 'Motor Diesel (repuestos)'
        WHEN T1."ItmsGrpCod" = 119 THEN 'Hidráulico / Transmisión'
        WHEN T1."ItmsGrpCod" = 120 THEN 'Misceláneos (representados)'
        WHEN T1."ItmsGrpCod" = 121 THEN 'Misceláneos (no representados)'
        WHEN T1."ItmsGrpCod" = 122 THEN 'Fletes'
        WHEN T1."ItmsGrpCod" = 123 THEN 'Componentes mayores'
        WHEN T1."ItmsGrpCod" = 124 THEN 'Componentes mayores'
        WHEN T1."ItmsGrpCod" = 125 THEN 'Servicios'
        WHEN T1."ItmsGrpCod" = 126 THEN 'Gastos viaje PQMQ'
        WHEN T1."ItmsGrpCod" = 132 THEN 'Costos de importación'
        WHEN T1."ItmsGrpCod" = 133 THEN 'Depósito contenedor'
    END AS "Grupo de artículo",
    T1."U_GranFamilia" AS "Gran Familia",
    T1."U_Familia" AS "Familia",
    T1."U_SubFamilia" AS "Subfamilia",
    T1."ItemCode" AS "Referencia",
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
    END AS "Categoría",
    T1."U_Clasificacion" AS "Clasificación",
    T1."CardCode" AS "Código Proveedor",
    T3."CardName" AS "Nombre Proveedor",
    T3."U_Tiempolleg" AS "Tiempo de llegada",
    T1."PurPackUn" AS "Unidades por empaque",
    T1."BHeight1" AS "Alto (cm)",
    T1."BWidth1" AS "Ancho (cm)",
    T1."BLength1" AS "Largo (cm)",
    T1."BWeight1" AS "Peso (Kg)",
    T1."BVolume" AS "Volumen (m3)",
    S."Asesor"
FROM
    BD_PARTEQUIPOS_PRO.OITM T1
    LEFT JOIN BD_PARTEQUIPOS_PRO.OCRD T3 ON T1."CardCode" = T3."CardCode"
    CROSS JOIN (
    SELECT 'LB ANDREA GRISALES' AS "Asesor" FROM DUMMY UNION ALL
    SELECT 'LB ANDREA REAL CORTES' FROM DUMMY UNION ALL
    SELECT 'LB BARRANQUILLA' FROM DUMMY UNION ALL
    SELECT 'LB BOGOTA CENTRO' FROM DUMMY UNION ALL
    SELECT 'LB BOGOTA NORTE' FROM DUMMY UNION ALL
    SELECT 'LB BOGOTA SUR' FROM DUMMY UNION ALL
    SELECT 'LB DENIS RIVERA' FROM DUMMY UNION ALL
    SELECT 'LB ECOMMERCE' FROM DUMMY UNION ALL
    SELECT 'LB EDISON CRISTANCHO' FROM DUMMY UNION ALL
    SELECT 'LB GERENCIA' FROM DUMMY UNION ALL
    SELECT 'LB KAM' FROM DUMMY UNION ALL
    SELECT 'LB LUIS CARLOS MOLINA' FROM DUMMY UNION ALL
    SELECT 'LB MARILLY GALLEGO' FROM DUMMY UNION ALL
    SELECT 'LB MAURICIO VARON PEDROZA' FROM DUMMY UNION ALL
    SELECT 'LB MAYERLY RODRIGUEZ' FROM DUMMY UNION ALL
    SELECT 'LB MEDELLIN NORTE' FROM DUMMY UNION ALL
    SELECT 'LB MEDELLIN SUR' FROM DUMMY UNION ALL
    SELECT 'LB SANTANDER' FROM DUMMY UNION ALL
    SELECT 'LB SERGIO ARENAS' FROM DUMMY UNION ALL
    SELECT 'LB VALLE DEL CAUCA' FROM DUMMY UNION ALL
    SELECT 'LB XIMENA MUNERA' FROM DUMMY UNION ALL
    SELECT 'LB YASMIN LUCIA PLAZAS' FROM DUMMY UNION ALL
    SELECT 'LB DIEGO PEREZ' FROM DUMMY 
    ) S
WHERE
    T1."validFor" = 'Y'