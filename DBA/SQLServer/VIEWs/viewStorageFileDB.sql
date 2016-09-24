-- Almacenamiento por archivos
SELECT
	database_id,
	DB_NAME(database_id) dbName, 
	(CASE type_desc 
		WHEN 'LOG' THEN 'LOG FILES'
		WHEN 'ROWS' THEN 'DATABASE FILES'
		ELSE CAST(type_desc AS VARCHAR)
	END) typeFile, 
	name fileName,
	physical_name fileNamePhysical,
	MAX(databasepropertyex (DB_NAME(database_id), 'recovery')) modelRecovery,
	((SUM(CAST(size AS BIGINT)) * 8) / 1024) sizeMB,
	(((SUM(CAST(size AS BIGINT)) * 8) / 1024) / 1024) sizeGB
FROM sys.master_files
WHERE-- DB_NAME(database_id) = 'DWH'
--AND 
type_desc = 'LOG'
--AND name LIKE '%CCliente%'
GROUP BY database_id,DB_NAME(database_id), type_desc, name,physical_name
ORDER BY 7 DESC