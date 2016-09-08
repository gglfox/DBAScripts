-- Ver tablas particionadas
USE DWH
SELECT DISTINCT t.name, COUNT(*) Partitions FROM sys.partitions p
INNER JOIN sys.tables t ON p.object_id = t.object_id
WHERE p.partition_number <> 1
GROUP BY t.name
ORDER BY 1