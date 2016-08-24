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
		DB_NAME(dbid) dbName,
		(CASE groupid 
			WHEN '0' THEN 'LOG FILES'
			WHEN '1' THEN 'DATABASE FILES'  
			ELSE CAST(groupid AS VARCHAR)
		END) typeFile, 
		LTRIM(RTRIM(name)) nameFileLogic,
		filename nameFilePhysical,
		CAST(MAX(databasepropertyex (DB_NAME(dbid), 'recovery')) AS VARCHAR) modelRecovery,
		((sum(size) * 8) / 1024) as sizeMB,
		CAST(((sum(size) * 8) / 1024) / 1024.0 AS DECIMAL(10,2)) as sizeG
	FROM master..sysaltfiles
	WHERE /*dbid > 4 --excluyendo las BD del sistema
	AND groupid = 0
	and */DB_NAME(dbid) = 'db_IDA2'
	GROUP BY DB_NAME(dbid), groupid,name, filename
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