SET NOCOUNT OFF
DBCC UPDATEUSAGE(0)

-- Creacion de tabla temporal
DECLARE @Results TABLE (
	name NVARCHAR(128),
	rows CHAR(11),
	reserved VARCHAR(18),
	data VARCHAR(18),
	index_size VARCHAR(18),
	unused VARCHAR(18)
)
INSERT @Results EXEC sp_msForEachTable 'EXEC sp_spaceused ''?''' 

-- Actualizacion de valores "KB" en los campos
UPDATE @Results
SET reserved = LEFT(reserved,LEN(reserved)-3),
	data = LEFT(data, LEN(data)-3),
	index_size = LEFT(index_size,LEN(index_size)-3),
	unused = LEFT(Unused,LEN(Unused)-3)

-- Informacion de Espacios
SELECT
	name,
	rows,
	--
	reserved reservedKB,
	(reserved/1024) reservedMB,
	((reserved/1024)/1024) reservedGB,
	--
	data dataKB,
	(data/1024) dataMB,
	((data/1024)/1024) dataGB,
	--
	index_size indexKB,
	(index_size/1024) indexMB,
	((index_size/1024)/1024) indexGB,
	--
	unused unusedKB,
	(unused/1024) unusedMB,
	((unused/1024)/1024) unusedGB
FROM @Results
ORDER BY  CONVERT(BIGINT,reserved) DESC