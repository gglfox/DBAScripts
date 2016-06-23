SET NOCOUNT OFF
--DBCC UPDATEUSAGE(0)

-- Creacion de tabla temporal
DECLARE @Results TABLE (
	name NVARCHAR(128),
	rows CHAR(11),
	reserved VARCHAR(18),
	data VARCHAR(18),
	index_size VARCHAR(18),
	unused VARCHAR(18)
)

--
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
	rows AS Rows,
	reserved AS [Tamaño en Disco (KB)],
	data AS [Datos (KB)],
	index_size AS [Indices (KB)],
	unused AS [No usado (KB)]
FROM @Results
ORDER BY  CONVERT(BIGINT,reserved) DESC