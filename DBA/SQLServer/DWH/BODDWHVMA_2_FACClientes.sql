-- 1. Creacion de Grupo de archivos (Filegroup)
ALTER DATABASE [DWH] ADD FILEGROUP [FGFACClientes201606]
ALTER DATABASE [DWH] ADD FILEGROUP [FGFACClientes201607]
ALTER DATABASE [DWH] ADD FILEGROUP [FGFACClientes201608]
ALTER DATABASE [DWH] ADD FILEGROUP [FGFACClientes201609]
ALTER DATABASE [DWH] ADD FILEGROUP [FGFACClientesNuevo]

-- 2. Creacion de archivos de datos (Datafile)
ALTER DATABASE [DWH] ADD FILE ( 
NAME = N'FACClientes201606', FILENAME = N'F:\DATA_DWH\FACClientes201606.ndf',
SIZE = 100, FILEGROWTH = 256) TO FILEGROUP FGFACClientes201606

ALTER DATABASE [DWH] ADD FILE (
NAME = N'FACClientes201607', FILENAME = N'F:\DATA_DWH\FACClientes201607.ndf',
SIZE = 100, FILEGROWTH = 256) TO FILEGROUP FGFACClientes201607

ALTER DATABASE [DWH] ADD FILE (
NAME = N'FACClientes201608', FILENAME = N'F:\DATA_DWH\FACClientes201608.ndf',
SIZE = 100, FILEGROWTH = 256) TO FILEGROUP FGFACClientes201608

ALTER DATABASE [DWH] ADD FILE (
NAME = N'FACClientes201609', FILENAME = N'F:\DATA_DWH\FACClientes201609.ndf',
SIZE = 100, FILEGROWTH = 256) TO FILEGROUP FGFACClientes201609

ALTER DATABASE [DWH] ADD FILE (
NAME = N'FACClientesNuevo', FILENAME = N'F:\DATA_DWH\FACClientesNuevo.ndf',
SIZE = 100, FILEGROWTH = 256) TO FILEGROUP FGFACClientesNuevo

-- 3. Creacion de funcion de particion
CREATE PARTITION FUNCTION [pf_FACClientes](int)
AS RANGE LEFT FOR VALUES (20160630, 20160731, 20160831, 20160930)

-- 4. Creacion de esquema de particion
CREATE PARTITION SCHEME [ps_FACClientes] AS PARTITION [pf_FACClientes]
TO ([FGFACClientes201606], [FGFACClientes201607], [FGFACClientes201608], [FGFACClientes201609], [FGFACClientesNuevo])

-- 5. Creacion de tabla
USE [DWH]
GO
CREATE TABLE [dbo].[FACClientes_NEW](
	[IdCliente] [int] NULL,
	[IdFechaCorte] [int] NULL,
	[IdFechaApertura] [int] NULL,
	[IdPaqueteCuenta] [int] NULL,
	[IdProducto] [int] NULL,
	[IdSegmento] [int] NOT NULL,
	[IdBanco] [int] NULL,
	[IdBanca] [int] NULL,
	[IdRegion] [int] NULL,
	[IdZona] [int] NULL,
	[IdGestor] [int] NULL,
	[IdOficina] [int] NULL,
	[IdEjecutivo] [int] NULL,
	[IdMoneda] [int] NULL,
	[IdEstadoCredito] [int] NULL,
	[IdEstatusCuenta] [int] NULL,
	[CodCliente] [varchar](15) NULL,
	[NomCliente] [varchar](100) NULL,
	[CodSegmento] [varchar](4) NULL,
	[FecCambioSegmento] [datetime] NULL,
	[CodBanco] [varchar](2) NULL,
	[CodBanca] [varchar](4) NULL,
	[CodRegion] [varchar](4) NULL,
	[CodZona] [varchar](4) NULL,
	[CodGestor] [varchar](4) NULL,
	[CodOficina] [varchar](4) NULL,
	[CodEjecutivo] [varchar](4) NULL,
	[CodContrato] [varchar](16) NULL,
	[CodEstatusCuenta] [varchar](4) NULL,
	[CodTipoProducto] [varchar](5) NULL,
	[CodProducto] [varchar](6) NULL,
	[CodPaquete] [varchar](6) NULL,
	[CodCuenta] [varchar](16) NULL,
	[CodMoneda] [varchar](3) NULL,
	[CodEstadoCredito] [varchar](4) NULL,
	[CodCentroCosto] [varchar](4) NULL,
	[FecReestructuracion] [datetime] NULL,
	[SldVencidosActivos] [decimal](20, 4) NULL,
	[SldProvisionGenerica] [decimal](20, 4) NULL,
	[TasPool] [decimal](20, 4) NULL,
	[MtoPoolDiario] [decimal](20, 4) NULL,
	[MargenFinancieroBruto] [decimal](20, 4) NULL,
	[MtoAmortizado] [decimal](20, 4) NULL,
	[NumSobregiros] [decimal](20, 4) NULL,
	[StatusTDC] [decimal](20, 4) NULL,
	[StatusVigenteTDC] [decimal](20, 4) NULL,
	[SldFacturadoTDC] [decimal](20, 4) NULL,
	[SlPromedioVigenteTDC] [decimal](20, 4) NULL,
	[LimiteTDC] [decimal](20, 4) NULL,
	[PromedioConsumo] [decimal](20, 4) NULL,
	[NumPagosVencidosTDC] [decimal](20, 4) NULL,
	[MarcaTDC] [decimal](20, 4) NULL,
	[TipoTDC] [decimal](20, 4) NULL,
	[NumDia] [int] NULL,
	[SldActual] [decimal](20, 4) NULL,
	[TasNominal] [decimal](20, 4) NULL,
	[SldAcumulado] [decimal](20, 4) NULL,
	[SldPromedio] [decimal](20, 4) NULL,
	[MtoDevengoInteres] [decimal](20, 4) NULL,
	[MtoInteresAcumulado] [decimal](20, 4) NULL,
	[TasNominalPonderada] [decimal](20, 4) NULL,
	[MtoPoolAcumulado] [decimal](20, 4) NULL,
	[FecCambioTasNominal] [datetime] NULL,
	[IndicadorNegocio] [bit] NULL,
	[SldBolivar] [decimal](24, 4) NOT NULL DEFAULT ((0))
) ON [ps_FACClientes]([IdFechaCorte])
WITH
(
DATA_COMPRESSION = PAGE
)
GO

-- 6. Creacion de indices Clustered
USE [DWH]
GO
CREATE CLUSTERED INDEX [FACClientesIdFechaCorte] ON [dbo].[FACClientes_NEW]
(
	[IdFechaCorte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

CREATE NONCLUSTERED INDEX [FACClientesIdCliente] ON [dbo].[FACClientes_NEW]
(
	[IdCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DWHClientesInd]
GO

CREATE NONCLUSTERED INDEX [FACClientesCodCliente] ON [dbo].[FACClientes_NEW]
(
	[CodCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [DWHClientesInd]
GO

-- 7. Insertar datos
USE [DWH]
GO
INSERT INTO [dbo].[FACClientes_NEW]
	([IdCliente],[IdFechaCorte],[IdFechaApertura],[IdPaqueteCuenta],[IdProducto],[IdSegmento],[IdBanco]
	,[IdBanca],[IdRegion],[IdZona],[IdGestor],[IdOficina],[IdEjecutivo],[IdMoneda],[IdEstadoCredito]
	,[IdEstatusCuenta],[CodCliente],[NomCliente],[CodSegmento],[FecCambioSegmento],[CodBanco],[CodBanca]
	,[CodRegion],[CodZona],[CodGestor],[CodOficina],[CodEjecutivo],[CodContrato],[CodEstatusCuenta]
	,[CodTipoProducto],[CodProducto],[CodPaquete],[CodCuenta],[CodMoneda],[CodEstadoCredito],[CodCentroCosto]
	,[FecReestructuracion],[SldVencidosActivos],[SldProvisionGenerica],[TasPool],[MtoPoolDiario]
	,[MargenFinancieroBruto],[MtoAmortizado],[NumSobregiros],[StatusTDC],[StatusVigenteTDC],[SldFacturadoTDC]
	,[SlPromedioVigenteTDC],[LimiteTDC],[PromedioConsumo],[NumPagosVencidosTDC],[MarcaTDC],[TipoTDC],[NumDia]
	,[SldActual],[TasNominal],[SldAcumulado],[SldPromedio],[MtoDevengoInteres],[MtoInteresAcumulado]
	,[TasNominalPonderada],[MtoPoolAcumulado],[FecCambioTasNominal],[IndicadorNegocio],[SldBolivar])
SELECT [IdCliente],[IdFechaCorte],[IdFechaApertura],[IdPaqueteCuenta],[IdProducto],[IdSegmento],[IdBanco]
	,[IdBanca],[IdRegion],[IdZona],[IdGestor],[IdOficina],[IdEjecutivo],[IdMoneda],[IdEstadoCredito]
	,[IdEstatusCuenta],[CodCliente],[NomCliente],[CodSegmento],[FecCambioSegmento],[CodBanco],[CodBanca]
	,[CodRegion],[CodZona],[CodGestor],[CodOficina],[CodEjecutivo],[CodContrato],[CodEstatusCuenta]
	,[CodTipoProducto],[CodProducto],[CodPaquete],[CodCuenta],[CodMoneda],[CodEstadoCredito],[CodCentroCosto]
	,[FecReestructuracion],[SldVencidosActivos],[SldProvisionGenerica],[TasPool],[MtoPoolDiario]
	,[MargenFinancieroBruto],[MtoAmortizado],[NumSobregiros],[StatusTDC],[StatusVigenteTDC],[SldFacturadoTDC]
	,[SlPromedioVigenteTDC],[LimiteTDC],[PromedioConsumo],[NumPagosVencidosTDC],[MarcaTDC],[TipoTDC],[NumDia]
	,[SldActual],[TasNominal],[SldAcumulado],[SldPromedio],[MtoDevengoInteres],[MtoInteresAcumulado]
	,[TasNominalPonderada],[MtoPoolAcumulado],[FecCambioTasNominal],[IndicadorNegocio],[SldBolivar]
FROM [dbo].[FACClientes] (NOLOCK)
WHERE IdFechaCorte IN 
('20110831','20110930','20111028','20111130','20111230','20120131','20120229','20120330','20120430','20120531','20120629',
'20120731','20120831','20120928','20121031','20121130','20121228','20130131','20130228','20130327','20130430','20130531',
'20130628','20130731','20130830','20130930','20131031','20131129','20131230','20140131','20140226','20140331','20140430',
'20140530','20140630','20140731','20140829','20140930','20141031','20141128','20141230','20150130','20150227','20150331',
'20150430','20150529','20150630','20150731','20150831','20150930','20151030','20151130','20151230','20160129','20160229',
'20160331','20160429','20160531','20160630','20160701','20160706','20160707','20160708','20160711','20160712','20160713',
'20160714','20160715','20160718','20160719','20160720','20160721','20160722','20160725','20160726','20160727','20160728',
'20160729','20160801','20160802','20160803','20160804','20160805','20160808','20160809','20160810','20160811','20160812',
'20160816','20160817','20160818','20160819','20160822','20160823','20160824','20160825','20160826','20160829','20160830',
'20160831','20160901','20160902','20160905','20160906','20160907','20160908','20160909','20160912','20160913','20160914',
'20160915','20160916','20160919','20160920','20160921')

-- 8. Cambio de nombre en tablas
USE [DWH]
GO
EXEC sp_rename 'FACClientes', 'FACClientes_OLD';
GO
EXEC sp_rename 'FACClientes_NEW', 'FACClientes';
GO

-- 9. Borrar estructura anterior
USE [DWH]
GO
DROP TABLE [FACClientes_OLD]