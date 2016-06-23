SET NOCOUNT OFF

-- Cursor con tablas de sistema, tablas de usuario y vistas
DECLARE curObjects CURSOR FOR
SELECT name
FROM sysobjects
WHERE xtype IN ('S','U','V')

-- Creacion de tabla temporal
CREATE TABLE #Results (
	name SYSNAME,
	rows CHAR(11),
	reserved VARCHAR(18), 
	data VARCHAR(18),
	index_size VARCHAR(18),
	unused VARCHAR(18)
)
DECLARE @objName AS SYSNAME

-- Lectura de cursor y generacion de informacion
OPEN curObjects
FETCH NEXT FROM curObjects INTO @objName
WHILE @@FETCH_STATUS = 0
BEGIN
	INSERT INTO #Results
	EXEC sp_spaceused @objName
	
	FETCH NEXT FROM curObjects INTO @objName;    
END
DEALLOCATE curObjects
CLOSE curObjects

-- Actualizacion de valores "KB" en los campos
UPDATE #Results
SET reserved = LEFT(reserved,LEN(reserved)-3),
	data = LEFT(data,LEN(data)-3),
	index_size = LEFT(index_size,LEN(index_size)-3),
	unused = LEFT(Unused,LEN(Unused)-3)

-- Informacion de Espacios
SELECT
	name,
	reserved AS [Tamaño en Disco (KB)],
	data AS [Datos (KB)],
	index_size AS [Indices (KB)],
	unused AS [No usado (KB)],
	rows AS Rows 
FROM #results
ORDER BY  CONVERT(BIGINT,reserved) DESC

-- Borrado de tabla temporal
DROP TABLE #Results