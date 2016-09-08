USE db_IDA2_bk
DECLARE @schema VARCHAR(100);
DECLARE @table VARCHAR(100);

DECLARE cObjetos CURSOR READ_ONLY FOR
SELECT DISTINCT TABLE_SCHEMA,TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'InteligenciaComercial'
ORDER BY 1

PRINT 'USE db_IDA2';
OPEN cObjetos
FETCH NEXT FROM cObjetos INTO @schema,@table
WHILE @@FETCH_STATUS = 0   
BEGIN
	PRINT 'EXEC dbo.sp_changeobjectowner @objname = ''dbo.'+@table+''', @newowner ='''+@schema+''';';
	FETCH NEXT FROM cObjetos INTO @schema,@table
END
CLOSE cObjetos
DEALLOCATE cObjetos