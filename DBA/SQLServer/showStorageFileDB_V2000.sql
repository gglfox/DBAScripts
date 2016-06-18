-- Almacenamiento por archivos
SELECT TOP 100 DB_name(dbid) database_Name,
(CASE groupid 
	WHEN '0' THEN 'LOG FILES'
	WHEN '1' THEN 'DATABASE FILES'  
	ELSE CAST(groupid AS VARCHAR)
END) tipo, 
name,
filename,
(sum(size) * 8) / 1024 as Size_MB,
CAST(((sum(size) * 8) / 1024) / 1024.0 AS DECIMAL(10,2)) as Size_GB
FROM sysaltfiles
WHERE dbid > 4 --excluyendo las BD del sistema
GROUP BY DB_name(dbid), groupid,name, filename
ORDER BY 5 DESC