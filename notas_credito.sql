SELECT DISTINCT
    T1."DocType" AS "Tipo de documento",
    T1."DocNum" AS "Número de documento",
    T0."BaseRef",
    T1."DocDate" AS "Fecha de contabilización",
    T1."CardCode" AS "NIT",
    T1."CardName" AS "Cliente",
    CASE
        WHEN T1."U_TipoNota" = 'A' THEN 'Anulacion'
        WHEN T1."U_TipoNota" = 'D' THEN 'Devolucion'
        WHEN T1."U_TipoNota" = 'N' THEN 'Anulacion No Reportable'
    END AS TIPO_NC,
    CASE
        WHEN T0."ReturnRsn" = -1 THEN 'Sin motivo'
        WHEN T0."ReturnRsn" = 0 THEN 'Motivo de devolución'
        WHEN T0."ReturnRsn" = 1 THEN 'Mal despachado Bodega'
        WHEN T0."ReturnRsn" = 2 THEN 'Mal pedido por el Cliente'
        WHEN T0."ReturnRsn" = 3 THEN 'Mal referenciado/homologado'
        WHEN T0."ReturnRsn" = 4 THEN 'Garantia'
        WHEN T0."ReturnRsn" = 5 THEN 'Error de facturacion - anulacion'
        WHEN T0."ReturnRsn" = 6 THEN 'Mal Asesorado'
        WHEN T0."ReturnRsn" = 7 THEN 'Etiquetas plan pionero'
        WHEN T0."ReturnRsn" = 8 THEN 'Descuento comercial'
        WHEN T0."ReturnRsn" = 9 THEN 'No migró a la DIAN'
        WHEN T0."ReturnRsn" = 10 THEN 'Error Contabilidad'
        ELSE 'Otro'
    END AS "Motivo devolucion",
    T1."DocTotal" AS "Total",
    T1."Comments" AS "Comentarios",
    T2."SlpName" AS "Asesor",
    T5."U_NAME" AS "Usuario"
FROM
    "BD_PARTEQUIPOS_PRO".RIN1 T0
    INNER JOIN "BD_PARTEQUIPOS_PRO".ORIN T1 ON T0."DocEntry" = T1."DocEntry"
    INNER JOIN "BD_PARTEQUIPOS_PRO".OSLP T2 ON T0."SlpCode" = T2."SlpCode"
    INNER JOIN "BD_PARTEQUIPOS_PRO".OUSR T5 ON T1."UserSign" = T5."USERID"
WHERE 
    T1."DocDate" >= '2024-01-01'
    