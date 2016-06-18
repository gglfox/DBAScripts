-- Almacenamiento por archivos
SELECT TOP 100 DB_name(database_id) database_Name, 
(CASE type_desc 
	WHEN 'LOG' THEN 'LOG FILES'
	WHEN 'ROWS' THEN 'DATABASE FILES'
	ELSE CAST(type_desc AS VARCHAR)
END) tipo, 
name,
physical_name,
(SUM(size) * 8) / 1024 AS Size_MB,
CAST(((sum(size) * 8) / 1024) / 1024.0 AS DECIMAL(10,2)) as Size_GB
FROM   sys.master_files
WHERE database_id > 4 --excluyendo las BD del sistema
GROUP BY DB_name(database_id), type_desc, physical_name,name
ORDER BY 5 DESC