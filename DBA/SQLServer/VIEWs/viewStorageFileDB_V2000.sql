-- Almacenamiento por archivos
SELECT
	DB_NAME(dbid) dbName,
	(CASE groupid 
		WHEN '0' THEN 'LOG FILES'
		WHEN '1' THEN 'DATABASE FILES'  
		ELSE CAST(groupid AS VARCHAR)
	END) typeFile, 
	LTRIM(RTRIM(name)) nameFileLogic,
	filename nameFilePhysical,
	CAST(MAX(databasepropertyex (DB_NAME(dbid), 'recovery')) AS VARCHAR) modelRecovery,
	(SUM(size) * 8) / 1024 as sizeMB,
	CAST(((SUM(size) * 8) / 1024) / 1024.0 AS DECIMAL(10,2)) as sizeG
FROM master..sysaltfiles
WHERE dbid > 4 --excluyendo las BD del sistema
AND filename LIKE '%F:%'
GROUP BY DB_NAME(dbid), groupid,name, filename
ORDER BY 6 DESC