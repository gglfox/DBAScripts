-- 1. Creacion de Grupo de archivos (Filegroup)
ALTER DATABASE [DWH] ADD FILEGROUP [FGFACClientesResumen201606]
ALTER DATABASE [DWH] ADD FILEGROUP [FGFACClientesResumen201607]
ALTER DATABASE [DWH] ADD FILEGROUP [FGFACClientesResumen201608]
ALTER DATABASE [DWH] ADD FILEGROUP [FGFACClientesResumen201609]
ALTER DATABASE [DWH] ADD FILEGROUP [FGFACClientesResumenNuevo]

-- 2. Creacion de archivos de datos (Datafile)
ALTER DATABASE [DWH] ADD FILE ( 
NAME = N'FACClientesResumen201606', FILENAME = N'J:\DATADWH\FACClientesResumen201606.ndf',
SIZE = 100, FILEGROWTH = 256) TO FILEGROUP FGFACClientesResumen201606

ALTER DATABASE [DWH] ADD FILE (
NAME = N'FACClientesResumen201607', FILENAME = N'J:\DATADWH\FACClientesResumen201607.ndf',
SIZE = 100, FILEGROWTH = 256) TO FILEGROUP FGFACClientesResumen201607

ALTER DATABASE [DWH] ADD FILE (
NAME = N'FACClientesResumen201608', FILENAME = N'J:\DATADWH\FACClientesResumen201608.ndf',
SIZE = 100, FILEGROWTH = 256) TO FILEGROUP FGFACClientesResumen201608

ALTER DATABASE [DWH] ADD FILE (
NAME = N'FACClientesResumen201609', FILENAME = N'J:\DATADWH\FACClientesResumen201609.ndf',
SIZE = 100, FILEGROWTH = 256) TO FILEGROUP FGFACClientesResumen201609

ALTER DATABASE [DWH] ADD FILE (
NAME = N'FACClientesResumenNuevo', FILENAME = N'J:\DATADWH\FACClientesResumenNuevo.ndf',
SIZE = 100, FILEGROWTH = 256) TO FILEGROUP FGFACClientesResumenNuevo

-- 3. Creacion de funcion de particion
CREATE PARTITION FUNCTION [pf_FACClientesResumen](int)
AS RANGE LEFT FOR VALUES (20160630, 20160731, 20160831, 20160930)

-- 4. Creacion de esquema de particion
CREATE PARTITION SCHEME [ps_FACClientesResumen] AS PARTITION [pf_FACClientesResumen] 
TO ([FGFACClientesResumen201606], [FGFACClientesResumen201607],
[FGFACClientesResumen201608], [FGFACClientesResumen201609], [FGFACClientesResumenNuevo])

-- 5. Creacion de tabla
USE [DWH]
GO
CREATE TABLE [dbo].[FACClientesResumen_NEW](
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
) ON [ps_FACClientesResumen]([IdFechaCorte])
WITH
(
DATA_COMPRESSION = PAGE
)
GO

-- 6. Creacion de indices Clustered
USE [DWH]
GO
CREATE CLUSTERED INDEX [FACClientesResumenIdFechaCorte] ON [dbo].[FACClientesResumen_NEW]
(
	[IdFechaCorte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

-- 7. Insertar datos
USE [DWH]
GO
INSERT INTO [dbo].[FACClientesResumen_NEW]
	([IdCliente],[IdFechaCorte],[IdSegmento],[IdBanco],[IdBanca],[IdRegion],[IdZona]
	,[IdGestor],[CodCliente],[CodSegmento],[CodBanco],[CodBanca],[CodRegion],[CodZona]
	,[CodGestor],[MixFondos],[NivelIntermediacion],[MtoFondeo],[MtoLiquidez],[MtoCostosFondos]
	,[MtoRendimiento],[MtoMorosidad],[MtoCrossSelling],[MtoSpreed],[MtoMargenFinanciero]
	,[MtoPrimaRiesgo],[NumContratoActivo],[NumContratoPasivo],[NumContratoTDC],[NumProductoActivo]
	,[NumProductoPasivo],[NumProductoTDC],[FechaCreacionCliente],[ClientesNuevo],[ClienteNuevoAcumulado]
	,[ContratoNuevoActivo],[ContratoNuevoPasivo],[ContratoNuevoTDC],[ContratoNuevoActivoAcumulado]
	,[ContratoNuevoPasivoAcumulado],[ContratoNuevoTDCAcumulado])
SELECT [IdCliente],[IdFechaCorte],[IdSegmento],[IdBanco],[IdBanca],[IdRegion],[IdZona]
      ,[IdGestor],[CodCliente],[CodSegmento],[CodBanco],[CodBanca],[CodRegion],[CodZona]
	  ,[CodGestor],[MixFondos],[NivelIntermediacion],[MtoFondeo],[MtoLiquidez],[MtoCostosFondos]
	  ,[MtoRendimiento],[MtoMorosidad],[MtoCrossSelling],[MtoSpreed],[MtoMargenFinanciero]
      ,[MtoPrimaRiesgo],[NumContratoActivo],[NumContratoPasivo],[NumContratoTDC],[NumProductoActivo]
	  ,[NumProductoPasivo],[NumProductoTDC],[FechaCreacionCliente],[ClientesNuevo],[ClienteNuevoAcumulado]
      ,[ContratoNuevoActivo],[ContratoNuevoPasivo],[ContratoNuevoTDC],[ContratoNuevoActivoAcumulado]
      ,[ContratoNuevoPasivoAcumulado],[ContratoNuevoTDCAcumulado]
  FROM [DWH].[dbo].[FACClientesResumen]	(NOLOCK)
WHERE IdFechaCorte IN 
('20110531','20110630','20110729','20110831','20110930','20111028','20111130','20111230','20120131','20120229',
'20120330','20120430','20120531','20120629','20120731','20120831','20120928','20121031','20121130','20121228',
'20130131','20130228','20130327','20130430','20130531','20130628','20130731','20130830','20130930','20131031',
'20131129','20131230','20140131','20140226','20140331','20140430','20140530','20140630','20140731','20140829',
'20140930','20141031','20141128','20141230','20150130','20150227','20150331','20150430','20150529','20150630',
'20150731','20150831','20150930','20151030','20151130','20151230','20160129','20160229','20160331','20160429',
'20160531','20160630','20160701','20160706','20160707','20160708','20160711','20160712','20160713','20160714',
'20160715','20160718','20160719','20160720','20160721','20160722','20160725','20160726','20160727','20160728',
'20160729','20160801','20160802','20160803','20160804','20160805','20160808','20160809','20160810','20160811',
'20160812','20160816','20160817','20160818','20160819','20160822','20160823','20160824','20160825','20160826',
'20160829','20160830','20160831','20160901','20160902','20160905','20160906')

-- 8. Cambio de nombre en tablas
USE [DWH]
GO
EXEC sp_rename 'FACClientesResumen', 'FACClientesResumen_OLD';
GO
EXEC sp_rename 'FACClientesResumen_NEW', 'FACClientesResumen';
GO

-- 9. Borrar estructura anterior
USE [DWH]
GO
DROP TABLE [FACClientesResumen_OLD]