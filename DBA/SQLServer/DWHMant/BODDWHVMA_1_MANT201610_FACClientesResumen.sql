-- 1. Creacion de tabla dentro de groupfile
USE [DWH]
GO
CREATE TABLE [dbo].[FACClientesResumen_TEMP07](
	[IdCliente] [int] NULL,
	[IdFechaCorte] [int] NULL,
	[IdSegmento] [int] NULL,
	[IdBanco] [int] NULL,
	[IdBanca] [int] NULL,
	[IdRegion] [int] NULL,
	[IdZona] [int] NULL,
	[IdGestor] [int] NULL,
	[CodCliente] [varchar](15) NULL,
	[CodSegmento] [varchar](4) NULL,
	[CodBanco] [varchar](2) NULL,
	[CodBanca] [varchar](4) NULL,
	[CodRegion] [varchar](4) NULL,
	[CodZona] [varchar](4) NULL,
	[CodGestor] [varchar](4) NULL,
	[MixFondos] [decimal](20, 4) NULL,
	[NivelIntermediacion] [decimal](20, 4) NULL,
	[MtoFondeo] [decimal](20, 4) NULL,
	[MtoLiquidez] [decimal](20, 4) NULL,
	[MtoCostosFondos] [decimal](20, 4) NULL,
	[MtoRendimiento] [decimal](20, 4) NULL,
	[MtoMorosidad] [decimal](20, 4) NULL,
	[MtoCrossSelling] [decimal](20, 4) NULL,
	[MtoSpreed] [decimal](20, 4) NULL,
	[MtoMargenFinanciero] [decimal](20, 4) NULL,
	[MtoPrimaRiesgo] [decimal](20, 4) NULL,
	[NumContratoActivo] [int] NULL,
	[NumContratoPasivo] [int] NULL,
	[NumContratoTDC] [int] NULL,
	[NumProductoActivo] [int] NULL,
	[NumProductoPasivo] [int] NULL,
	[NumProductoTDC] [int] NULL,
	[FechaCreacionCliente] [datetime] NULL,
	[ClientesNuevo] [int] NULL,
	[ClienteNuevoAcumulado] [int] NULL,
	[ContratoNuevoActivo] [int] NULL,
	[ContratoNuevoPasivo] [int] NULL,
	[ContratoNuevoTDC] [int] NULL,
	[ContratoNuevoActivoAcumulado] [int] NULL,
	[ContratoNuevoPasivoAcumulado] [int] NULL,
	[ContratoNuevoTDCAcumulado] [int] NULL
) ON FGFACClientesResumen201607
WITH 
(
DATA_COMPRESSION = PAGE
)

-- 2. Creacion de indices
USE [DWH]
GO
CREATE CLUSTERED INDEX [FACClientesResumenIdFechaCorte] ON [dbo].[FACClientesResumen_TEMP07]
(
	[IdFechaCorte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

-- 3. Pasar datos a tabla temporal
USE [DWH]
GO
ALTER TABLE dbo.FACClientesResumen SWITCH PARTITION 2 TO [FACClientesResumen_TEMP07]

-- 4. Unir funcion de particion con historico
USE [DWH]
GO
ALTER PARTITION FUNCTION pf_FACClientesResumen() MERGE RANGE (20160630)

-- 5. Creacion de Grupo de archivo (Filegroup)
ALTER DATABASE [DWH] ADD FILEGROUP [FGFACClientesResumen201610]

-- 6. Creacion de archivo de dato (Datafile)
ALTER DATABASE [DWH] ADD FILE ( 
NAME = N'FACClientesResumen201610', FILENAME = N'J:\DATADWH\FACClientesResumen201610.ndf',
SIZE = 100, FILEGROWTH = 256) TO FILEGROUP FGFACClientesResumen201610

-- 7. Incluir filegroup y rango dentro del esquema y funcion de particion
USE [DWH]
GO
ALTER PARTITION SCHEME [ps_FACClientesResumen] NEXT USED FGFACClientesResumen201610
ALTER PARTITION FUNCTION pf_FACClientesResumen() SPLIT RANGE (20161031)

-- 8. Inserta datos ultima corte del mes
USE [DWH]
GO
INSERT INTO [dbo].[FACClientesResumen]
SELECT * FROM [DWH].[dbo].[FACClientesResumen_TEMP07]
WHERE idfechacorte = 20160729

-- 9. Borrar tabla temporal
USE [DWH]
GO
DROP TABLE [FACClientesResumen_TEMP07]

-- 10. Eliminar datafile y filegroup anterior
ALTER DATABASE [DWH] REMOVE FILE FACClientesResumen201606
ALTER DATABASE [DWH] REMOVE FILEGROUP FGFACClientesResumen201606