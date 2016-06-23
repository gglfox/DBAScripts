DECLARE @PhysicalRID VARCHAR(15)
DECLARE @var INT SET @var = 0

DECLARE cur_Auditorias CURSOR FOR
SELECT TOP 100000 %%physloc%%
FROM [fisdb].[dbo].[Auditorias_Taquilla] WITH (NOLOCK)
WHERE DATEDIFF(MONTH, [Fecha_Hora], GETDATE()) > 12

OPEN cur_Auditorias
FETCH NEXT FROM cur_Auditorias INTO @PhysicalRID
WHILE @@FETCH_STATUS = 0
BEGIN
	DELETE TOP (1) FROM [fisdb].[dbo].[Auditorias_Taquilla]
	WHERE %%physloc%% = @PhysicalRID
	--SET @var = @var - 1
	FETCH NEXT FROM cur_Auditorias INTO @PhysicalRID
END
CLOSE cur_Auditorias
DEALLOCATE cur_Auditorias