DECLARE @dbName VARCHAR(150)
DECLARE @typeFile VARCHAR(150)
DECLARE @nameFileLogic VARCHAR(150)
DECLARE @modelRecovery VARCHAR(100)
DECLARE @nameFilePhysical VARCHAR(150)
DECLARE @sizeMB DECIMAL
DECLARE @sizeGB DECIMAL

DECLARE @Ind INT SET @Ind = 0

DECLARE cFiles CURSOR READ_ONLY FOR
	SELECT
		DB_NAME(database_id) dbName,
		(CASE type_desc 
			WHEN 'LOG' THEN 'LOG FILES'
			WHEN 'ROWS' THEN 'DATABASE FILES'
		ELSE CAST(type_desc AS VARCHAR) END) typeFile,
		name nameFileLogic,
		CAST(databasepropertyex (DB_NAME(database_id), 'recovery') AS VARCHAR) modelRecovery,
		physical_name nameFilePhysical,
		(SUM(size) * 8) / 1024 AS sizeMB,
		CAST(((sum(size) * 8) / 1024) / 1024.0 AS DECIMAL(10,2)) sizeGB
	FROM sys.master_files
	WHERE database_id > -1 --excluyendo las BD del sistema
	--AND type_desc = 'ROWS'
	AND DB_NAME(database_id) = 'tempdb'
	GROUP BY DB_NAME(database_id), type_desc, physical_name,name
	ORDER BY 6 DESC
OPEN cFiles
FETCH NEXT FROM cFiles INTO @dbName, @typeFile, @nameFileLogic, @modelRecovery, @nameFilePhysical, @sizeMB, @sizeGB

WHILE (@@fetch_status <> -1)
	BEGIN
		IF (@modelRecovery = 'FULL') 
		BEGIN
			SET @Ind = 1
			EXEC ('ALTER DATABASE ['+ @dbName +'] SET RECOVERY SIMPLE');
		END

		EXEC ('USE [' + @dbName + '] DBCC SHRINKFILE (N''' + @nameFileLogic +''',1)');

		IF (@Ind = 1)
		BEGIN
			EXEC ('ALTER DATABASE ['+ @dbName +'] SET RECOVERY FULL');
			SET @Ind = 0
		END		
		FETCH NEXT FROM cFiles INTO @dbName, @typeFile, @nameFileLogic, @modelRecovery, @nameFilePhysical, @sizeMB, @sizeGB
	END
CLOSE cFiles
DEALLOCATE cFiles
GO