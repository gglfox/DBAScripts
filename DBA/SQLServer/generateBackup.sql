BACKUP DATABASE UltCreditos 
TO  DISK = N'\\ejgraterol\temp\UltCreditos_BODBDBPMS_20160415.bak' 
WITH NOFORMAT, NOINIT,  NAME = N'UltCreditos-Full Database Backup', 
SKIP, NOREWIND, NOUNLOAD,  STATS = 5
GO