USE IVADB
SELECT
	o.name, 
	CASE 
		WHEN m.definition IS NULL 
		THEN 'YES'
		ELSE 'NO'
	END is_encrypted,
	o.type,
	o.type_desc,
	o.create_date,
	o.modify_date
FROM sys.sql_modules m 
INNER JOIN sys.objects o 
	ON m.object_id = o.object_id
ORDER BY o.type

sp_ Gf_ObtenerConsecutivoCompania