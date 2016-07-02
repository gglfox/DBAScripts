-- Almacenamiento por archivos
SELECT
	DB_name(database_id) dbName, 
	(CASE type_desc 
		WHEN 'LOG' THEN 'LOG FILES'
		WHEN 'ROWS' THEN 'DATABASE FILES'
		ELSE CAST(type_desc AS VARCHAR)
	END) typeFile, 
	name nameFileLogic,
	physical_name nameFilePhysical,
	MAX(databasepropertyex (DB_name(database_id), 'recovery')) modelRecovery,
	(SUM(size) * 8) / 1024 AS sizeMB,
	CAST(((sum(size) * 8) / 1024) / 1024.0 AS DECIMAL(10,2)) sizeGB
FROM sys.master_files
WHERE database_id > 4 --excluyendo las BD del sistema
AND type_desc = 'LOG'
GROUP BY DB_name(database_id), type_desc, name,physical_name
ORDER BY 6 DESC