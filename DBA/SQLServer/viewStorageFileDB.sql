-- Almacenamiento por archivos
SELECT
	DB_NAME(database_id) dbName, 
	(CASE type_desc 
		WHEN 'LOG' THEN 'LOG FILES'
		WHEN 'ROWS' THEN 'DATABASE FILES'
		ELSE CAST(type_desc AS VARCHAR)
	END) typeFile, 
	name nameFileLogic,
	physical_name nameFilePhysical,
	MAX(databasepropertyex (DB_NAME(database_id), 'recovery')) modelRecovery,
	((SUM(CAST(size AS BIGINT))*8)/1024) sizeMB,
	(((SUM(CAST(size AS BIGINT))*8)/1024)/1024) sizeGB
FROM sys.master_files
WHERE database_id > 4
AND type_desc = 'LOG'
GROUP BY DB_NAME(database_id), type_desc, name,physical_name
ORDER BY 6 DESC