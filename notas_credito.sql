SELECT DISTINCT
    T1."DocNum",
    T0."BaseRef",
    T1."DocDate",
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
        WHEN T0."ReturnRsn" = 4 THEN 'Garantia '
        WHEN T0."ReturnRsn" = 5 THEN 'Error de facturacion - anulacion'
        WHEN T0."ReturnRsn" = 6 THEN 'Mal Asesorado '
    END AS "Motivo devolucion",
    T1."DocTotal",
    T1."Comments",
    T2."SlpName" AS "Asesor"
FROM
    RIN1 T0
    INNER JOIN ORIN T1 ON T0."DocEntry" = T1."DocEntry"
    INNER JOIN OSLP T2 ON T0."SlpCode" = T2."SlpCode"

WHERE 
    T1."DocDate" >= [%0]