-- Ver tablas dentro de data spaces
USE DWH
SELECT
	--o.object_id,
	o.name objectName,
	o.type_desc,
	i.name indexName, 
	--i.index_id,
	i.type_desc,
	ds.name dataSpaceName,
	ds.type_desc
FROM sys.indexes i 
INNER JOIN sys.data_spaces ds ON i.data_space_id = ds.data_space_id
INNER JOIN sys.all_objects o ON i.object_id = o.object_id
WHERE o.type = 'U'
AND i.index_id = 1
AND o.name LIKE '%FACClientesResumen%'
--AND ds.name LIKE '%FGFACTResTransacAgenciasD%'
ORDER BY 5 DESC