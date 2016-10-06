-- 1. Creacion de tabla dentro de groupfile
USE [DWH]
GO
CREATE TABLE [dbo].[FACClientes_TEMP07](
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
) ON FGFACClientes201607
WITH 
(
DATA_COMPRESSION = PAGE
)

-- 2. Creacion de indices
USE [DWH]
GO
CREATE CLUSTERED INDEX [FACClientesIdFechaCorte] ON [dbo].[FACClientes_TEMP07]
(
	[IdFechaCorte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

-- 3. Deshabilitar indices NO CLUSTERED
USE [DWH]
GO
ALTER INDEX [FACClientesCodCliente] ON [dbo].[FACClientes] DISABLE
ALTER INDEX [FACClientesIdCliente] ON [dbo].[FACClientes] DISABLE

-- 4. Pasar datos a tabla temporal
USE [DWH]
GO
ALTER TABLE dbo.FACClientes SWITCH PARTITION 2 TO [FACClientes_TEMP07]

-- 5. Unir funcion de particion con historico
USE [DWH]
GO
ALTER PARTITION FUNCTION pf_FACClientes() MERGE RANGE (20160630)

-- 6. Creacion de Grupo de archivo (Filegroup)
ALTER DATABASE [DWH] ADD FILEGROUP FGFACClientes201610

-- 7. Creacion de archivo de dato (Datafile)
ALTER DATABASE [DWH] ADD FILE ( 
NAME = N'FACClientes201610', FILENAME = N'F:\DATA_DWH\FACClientes201610.ndf',
SIZE = 100, FILEGROWTH = 256) TO FILEGROUP FGFACClientes201610

-- 8. Incluir filegroup y rango dentro del esquema y funcion de particion
USE [DWH]
GO
ALTER PARTITION SCHEME [ps_FACClientes] NEXT USED FGFACClientes201610
ALTER PARTITION FUNCTION pf_FACClientes() SPLIT RANGE (20161031)

-- 9. Inserta datos ultima corte del mes
USE [DWH]
GO
INSERT INTO [dbo].[FACClientes]
SELECT * FROM [DWH].[dbo].[FACClientes_TEMP07]
WHERE idfechacorte = 20160729

-- 10. Reconstruccion de indices deshabilitado NO CLUSTERED 
USE [DWH]
GO
ALTER INDEX [FACClientesCodCliente] ON [dbo].[FACClientes] REBUILD PARTITION = ALL WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE)
ALTER INDEX [FACClientesIdCliente] ON [dbo].[FACClientes] REBUILD PARTITION = ALL WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, DATA_COMPRESSION = PAGE)

-- 11. Borrar tabla temporal
USE [DWH]
GO
DROP TABLE [FACClientes_TEMP07]

-- 12. Eliminar datafile y filegroup anterior
ALTER DATABASE [DWH] REMOVE FILE FACClientes201606
ALTER DATABASE [DWH] REMOVE FILEGROUP FGFACClientes201606