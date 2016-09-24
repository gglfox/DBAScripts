-- 1. Creacion de Grupo de archivos (Filegroup)
ALTER DATABASE [DWH] ADD FILEGROUP [FGFACCaptacionesVista201606]
ALTER DATABASE [DWH] ADD FILEGROUP [FGFACCaptacionesVista201607]
ALTER DATABASE [DWH] ADD FILEGROUP [FGFACCaptacionesVista201608]
ALTER DATABASE [DWH] ADD FILEGROUP [FGFACCaptacionesVista201609]
ALTER DATABASE [DWH] ADD FILEGROUP [FGFACCaptacionesVistaNuevo]

-- 2. Creacion de archivos de datos (Datafile)
ALTER DATABASE [DWH] ADD FILE ( 
NAME = N'FACCaptacionesVista201606', FILENAME = N'F:\DATA_DWH\FACCaptacionesVista201606.ndf',
SIZE = 100, FILEGROWTH = 256) TO FILEGROUP FGFACCaptacionesVista201606

ALTER DATABASE [DWH] ADD FILE (
NAME = N'FACCaptacionesVista201607', FILENAME = N'F:\DATA_DWH\FACCaptacionesVista201607.ndf',
SIZE = 100, FILEGROWTH = 256) TO FILEGROUP FGFACCaptacionesVista201607

ALTER DATABASE [DWH] ADD FILE (
NAME = N'FACCaptacionesVista201608', FILENAME = N'F:\DATA_DWH\FACCaptacionesVista201608.ndf',
SIZE = 100, FILEGROWTH = 256) TO FILEGROUP FGFACCaptacionesVista201608

ALTER DATABASE [DWH] ADD FILE (
NAME = N'FACCaptacionesVista201609', FILENAME = N'F:\DATA_DWH\FACCaptacionesVista201609.ndf',
SIZE = 100, FILEGROWTH = 256) TO FILEGROUP FGFACCaptacionesVista201609

ALTER DATABASE [DWH] ADD FILE (
NAME = N'FACCaptacionesVistaNuevo', FILENAME = N'F:\DATA_DWH\FACCaptacionesVistaNuevo.ndf',
SIZE = 100, FILEGROWTH = 256) TO FILEGROUP FGFACCaptacionesVistaNuevo

-- 3. Creacion de funcion de particion
CREATE PARTITION FUNCTION [pf_FACCaptacionesVista](int)
AS RANGE LEFT FOR VALUES (20160630, 20160731, 20160831, 20160930)

-- 4. Creacion de esquema de particion
CREATE PARTITION SCHEME [ps_FACCaptacionesVista] AS PARTITION [pf_FACCaptacionesVista]
TO ([FGFACCaptacionesVista201606], [FGFACCaptacionesVista201607], [FGFACCaptacionesVista201608], [FGFACCaptacionesVista201609], [FGFACCaptacionesVistaNuevo])

-- 5. Creacion de tabla
USE [DWH]
GO
CREATE TABLE [dbo].[FACCaptacionesVista_NEW](
	[IdCliente] [int] NULL,
	[IdFechaCorte] [int] NULL,
	[IdFechaApertura] [int] NULL,
	[IdBancoContrato] [int] NOT NULL,
	[IdOficinaContrato] [int] NULL,
	[IdEjecutivoContrato] [int] NULL,
	[IdBanco] [int] NULL,
	[IdBanca] [int] NULL,
	[IdRegion] [int] NULL,
	[IdZona] [int] NULL,
	[IdOficina] [int] NULL,
	[IdEjecutivo] [int] NULL,
	[IdGestor] [int] NULL,
	[IdPaqueteCuenta] [int] NULL,
	[IdProducto] [int] NULL,
	[IdEstatusCuenta] [int] NULL,
	[IdMoneda] [int] NULL,
	[IdCuenta] [int] NULL,
	[IdSegmento] [int] NULL,
	[IdFechaCierre] [int] NULL,
	[IdOrigenFondo] [int] NULL,
	[IdMotivoCancelacion] [int] NULL,
	[IdRangoMonto] [int] NULL,
	[IdRangoTasa] [int] NULL,
	[CodCliente] [varchar](15) NULL
) ON [ps_FACCaptacionesVista]([IdFechaCorte])
WITH
(
DATA_COMPRESSION = PAGE
)
GO
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [CodBancoContrato] [varchar](2) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [CodOficinaContrato] [varchar](4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [CodEjecutivoContrato] [varchar](4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [CodContrato] [varchar](16) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [CodBanco] [varchar](2) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [CodBanca] [varchar](4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [CodRegion] [varchar](4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [CodZona] [varchar](4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [CodOficina] [varchar](4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [CodEjecutivo] [varchar](4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [CodGestor] [varchar](4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [CodPaquete] [varchar](6) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [CodProducto] [varchar](4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [CodEstatusCuenta] [varchar](2) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [CodMoneda] [varchar](3) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [CodCuenta] [varchar](16) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [CodSegmento] [varchar](4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [CodOrigenFondo] [varchar](4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [CodMotivoCancelacion] [varchar](4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [CodRangoMonto] [varchar](4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [CodRangoTasa] [varchar](4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [SldContable] [decimal](20, 4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [SldDolares] [decimal](20, 4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [SldBolivares] [decimal](20, 4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [MtoDiferido] [decimal](20, 4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [MtoBloqueado] [decimal](20, 4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [SldDisponible] [decimal](20, 4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [IntCausado] [decimal](20, 4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [TasEfectiva] [decimal](20, 4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [TasNominal] [decimal](20, 4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [FecCambioTasaNominal] [datetime] NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [MtoPromedioIBS] [decimal](20, 4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [CanCuentas] [int] NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [MtoInteresTasaEfectiva] [decimal](20, 4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [MtoInteresTasaNominal] [decimal](20, 4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [TasPool] [decimal](20, 4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [FecCambioTasaPool] [datetime] NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [NumDia] [int] NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [SldContableAcumulado] [decimal](20, 4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [SldPromedio] [decimal](20, 4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [MtoDevengoInteres] [decimal](20, 4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [MtoInteresAcumulado] [decimal](20, 4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [TasNominalPonderada] [decimal](20, 4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [SldMinimo] [decimal](20, 4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [MtoPoolDiario] [decimal](20, 4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [MtoPoolAcumulado] [decimal](20, 4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [IntDiaAprovisionado] [decimal](20, 4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [TasaEfectivaAcum] [decimal](20, 4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [TasaEfectivaDia] [decimal](20, 4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [TasaEfectivaAnio] [decimal](20, 4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [CostoFondo] [decimal](20, 4) NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [IndicadorNegocio] [bit] NULL
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [SldBolivar] [decimal](24, 4) NOT NULL DEFAULT ((0))
ALTER TABLE [dbo].[FACCaptacionesVista_NEW] ADD [OtrosCostos] [decimal](20, 4) NULL

-- 6. Creacion de indices Clustered
CREATE CLUSTERED INDEX [FACCaptacionesVistaIdFechaCorte] ON [dbo].[FACCaptacionesVista_NEW]
(
	[IdFechaCorte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

-- 7. Insertar datos
USE [DWH]
GO
INSERT INTO [dbo].[FACCaptacionesVista_NEW]
	([IdCliente],[IdFechaCorte],[IdFechaApertura],[IdBancoContrato],[IdOficinaContrato],[IdEjecutivoContrato],[IdBanco]
	,[IdBanca],[IdRegion],[IdZona],[IdOficina],[IdEjecutivo],[IdGestor],[IdPaqueteCuenta],[IdProducto],[IdEstatusCuenta]
	,[IdMoneda],[IdCuenta],[IdSegmento],[IdFechaCierre],[IdOrigenFondo],[IdMotivoCancelacion],[IdRangoMonto],[IdRangoTasa]
	,[CodCliente],[CodBancoContrato],[CodOficinaContrato],[CodEjecutivoContrato],[CodContrato],[CodBanco],[CodBanca],[CodRegion]
	,[CodZona],[CodOficina],[CodEjecutivo],[CodGestor],[CodPaquete],[CodProducto],[CodEstatusCuenta],[CodMoneda],[CodCuenta]
	,[CodSegmento],[CodOrigenFondo],[CodMotivoCancelacion],[CodRangoMonto],[CodRangoTasa],[SldContable],[SldDolares],[SldBolivares]
	,[MtoDiferido],[MtoBloqueado],[SldDisponible],[IntCausado],[TasEfectiva],[TasNominal],[FecCambioTasaNominal],[MtoPromedioIBS]
	,[CanCuentas],[MtoInteresTasaEfectiva],[MtoInteresTasaNominal],[TasPool],[FecCambioTasaPool],[NumDia],[SldContableAcumulado]
	,[SldPromedio],[MtoDevengoInteres],[MtoInteresAcumulado],[TasNominalPonderada],[SldMinimo],[MtoPoolDiario],[MtoPoolAcumulado]
	,[IntDiaAprovisionado],[TasaEfectivaAcum],[TasaEfectivaDia],[TasaEfectivaAnio],[CostoFondo],[IndicadorNegocio],[SldBolivar],[OtrosCostos])
SELECT [IdCliente],[IdFechaCorte],[IdFechaApertura],[IdBancoContrato],[IdOficinaContrato],[IdEjecutivoContrato],[IdBanco]
	,[IdBanca],[IdRegion],[IdZona],[IdOficina],[IdEjecutivo],[IdGestor],[IdPaqueteCuenta],[IdProducto],[IdEstatusCuenta]
	,[IdMoneda],[IdCuenta],[IdSegmento],[IdFechaCierre],[IdOrigenFondo],[IdMotivoCancelacion],[IdRangoMonto],[IdRangoTasa]
	,[CodCliente],[CodBancoContrato],[CodOficinaContrato],[CodEjecutivoContrato],[CodContrato],[CodBanco],[CodBanca],[CodRegion]
	,[CodZona],[CodOficina],[CodEjecutivo],[CodGestor],[CodPaquete],[CodProducto],[CodEstatusCuenta],[CodMoneda],[CodCuenta]
	,[CodSegmento],[CodOrigenFondo],[CodMotivoCancelacion],[CodRangoMonto],[CodRangoTasa],[SldContable],[SldDolares],[SldBolivares]
	,[MtoDiferido],[MtoBloqueado],[SldDisponible],[IntCausado],[TasEfectiva],[TasNominal],[FecCambioTasaNominal],[MtoPromedioIBS]
	,[CanCuentas],[MtoInteresTasaEfectiva],[MtoInteresTasaNominal],[TasPool],[FecCambioTasaPool],[NumDia],[SldContableAcumulado]
	,[SldPromedio],[MtoDevengoInteres],[MtoInteresAcumulado],[TasNominalPonderada],[SldMinimo],[MtoPoolDiario],[MtoPoolAcumulado]
	,[IntDiaAprovisionado],[TasaEfectivaAcum],[TasaEfectivaDia],[TasaEfectivaAnio],[CostoFondo],[IndicadorNegocio],[SldBolivar],[OtrosCostos]
FROM [DWH].[dbo].[FACCaptacionesVista] (NOLOCK)
WHERE IdFechaCorte IN 
('20110930','20111028','20111130','20111230','20120131','20120229','20120330','20120430','20120531','20120629','20120731','20120831',
'20120928','20121031','20121130','20121228','20130131','20130228','20130327','20130430','20130531','20130628','20130731','20130830',
'20130930','20131031','20131129','20131230','20140131','20140226','20140331','20140430','20140530','20140630','20140731','20140829',
'20140930','20141031','20141128','20141230','20150130','20150227','20150331','20150430','20150529','20150630','20150731','20150831',
'20150930','20151030','20151130','20151230','20160129','20160229','20160331','20160429','20160531','20160630','20160701','20160706',
'20160707','20160708','20160711','20160712','20160713','20160714','20160715','20160718','20160719','20160720','20160721','20160722',
'20160725','20160726','20160727','20160728','20160729','20160801','20160802','20160803','20160804','20160805','20160808','20160809',
'20160810','20160811','20160812','20160816','20160817','20160818','20160819','20160822','20160823','20160824','20160825','20160826',
'20160829','20160830','20160831','20160901','20160902','20160905','20160906','20160907','20160908','20160909','20160912','20160913',
'20160914','20160915','20160916','20160919','20160920','20160921','20160922')

-- 8. Cambio de nombre en tablas
USE [DWH]
GO
EXEC sp_rename 'FACCaptacionesVista', 'FACCaptacionesVista_OLD';
GO
EXEC sp_rename 'FACCaptacionesVista_NEW', 'FACCaptacionesVista';
GO

-- 9. Borrar estructura anterior
USE [DWH]
GO
DROP TABLE [FACCaptacionesVista_OLD]