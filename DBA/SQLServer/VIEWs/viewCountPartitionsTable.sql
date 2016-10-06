-- Ver tablas particionadas
USE DWH
SELECT DISTINCT t.name, COUNT(*) Partitions FROM sys.partitions p (NOLOCK)
INNER JOIN sys.tables t (NOLOCK) ON p.object_id = t.object_id
WHERE p.partition_number <> 1
GROUP BY t.name
ORDER BY 1