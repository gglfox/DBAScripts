-- Almacenamiento por archivos
SELECT
	DB_name(dbid) dbName,
	(CASE groupid 
		WHEN '0' THEN 'LOG FILES'
		WHEN '1' THEN 'DATABASE FILES'  
		ELSE CAST(groupid AS VARCHAR)
	END) typeFile, 
	name nameFileLogic,
	filename nameFilePhysical,
	MAX(databasepropertyex (DB_name(dbid), 'recovery')) modelRecovery,
	(sum(size) * 8) / 1024 as sizeMB,
	CAST(((sum(size) * 8) / 1024) / 1024.0 AS DECIMAL(10,2)) as sizeGB
FROM master..sysaltfiles
WHERE dbid > 4 --excluyendo las BD del sistema
AND groupid = 0
GROUP BY DB_name(dbid), groupid,name, filename
ORDER BY 6 DESC