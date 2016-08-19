SELECT
	op.process_date Fecha_a_Cerrar,
	TO_CHAR(op.finihs_date_time,'DD/MM/YY HH24:MI:SS') FinCierre_CambioFecha
FROM opencard.op_process_schedule op
WHERE op.process_date >= '08/08/16'
AND op.group_code = 999
ORDER BY process_date DESC, op.finihs_date_time DESC;