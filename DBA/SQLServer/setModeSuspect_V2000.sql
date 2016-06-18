-- Activar el modo emergencia
USE master
GO
EXEC SP_CONFIGURE 'Allow updates', 1
GO
RECONFIGURE WITH OVERRIDE
GO

--Actualizar status
UPDATE sysdatabases
--SET status = status | -32768 --emergencia
SET status = 24 --normal
WHERE name='db_IDA2'
GO

--Reversar la configuracion
EXEC SP_CONFIGURE 'Allow updates', 0
GO
RECONFIGURE WITH OVERRIDE
GO

-- Reconstruir archivo de log (colocamos un nombre diferente al .ldf existente)
DBCC REBUILD_LOG (db_IDA2,'F:\db_IDA\Datos\db_IDA2_Log_3.ldf')

-- Abrir la BD
ALTER DATABASE db_IDA2 SET MULTI_USER

USE db_IDA2
GO
DBCC CHECKDB (db_IDA2, NOINDEX)
GO
