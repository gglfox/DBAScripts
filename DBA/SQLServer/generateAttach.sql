DECLARE @dbid int
DECLARE @name varchar(50)
DECLARE @file varchar(150)
DECLARE @idfile INT
DECLARE @cmd VARCHAR(4000)
SET @cmd = ''
SET @idfile = 1

DECLARE cAttach CURSOR
READ_ONLY
FOR 
SELECT dbid, name FROM
sysdatabases 
WHERE name  in ('fisdb') -- Name DB

OPEN cAttach
FETCH NEXT FROM cAttach INTO @dbid, @name
WHILE (@@fetch_status <> -1)
BEGIN
	IF (@@fetch_status <> -2)
	BEGIN
	-- seach file
	DECLARE archivos CURSOR
	READ_ONLY FOR
		SELECT [filename] 
		FROM sysaltfiles 
		WHERE dbid = @dbid
		
		OPEN archivos
		FETCH NEXT FROM archivos INTO @file
		WHILE (@@fetch_status <> -1)
		BEGIN
			BEGIN
				SET @cmd =	@cmd +  
							',@FILENAME' +CONVERT(varchar(10),@IDFILE) + 
							'=' + 
							'''' + rtrim(@file) + '''' + CHAR(13)
				SET @idfile = @idfile + 1
			END
			FETCH NEXT FROM archivos INTO @file
		END
		CLOSE archivos
		DEALLOCATE archivos
	--PRINT '';
	PRINT 'EXEC sp_attach_db @dbname = ''' + (@name) + '''' ;
	PRINT @cmd + ';'
	
	SET @cmd = ''
	SET @idfile = 1
	END
	FETCH NEXT FROM cAttach INTO @dbid, @name
END
CLOSE cAttach
DEALLOCATE cAttach
GO