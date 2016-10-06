-- Ver espacios de filegroups
USE DWH
SELECT 
	fg.groupid,
    fg.groupname filegroup,
	--f.fileid,
    f.name datafileName,
	f.size pages,
	--f.filename,
	CONVERT (DEC(15,2),ROUND((f.size/128.000),2)) sizeMB,
	CONVERT (DEC(15,2),ROUND((f.size/128.000),2)/1024) sizeGB,	
	CONVERT (DEC(15,2),ROUND((FILEPROPERTY(f.name,'SpaceUsed')/128.000),2)) sizeUsedMB,
	CONVERT (DEC(15,2),ROUND((FILEPROPERTY(f.name,'SpaceUsed')/128.000),2)/1024) sizeUsedGB,
	CONVERT (DEC(15,2),ROUND(((f.size-FILEPROPERTY(f.name,'SpaceUsed'))/128.000),2)) sizeAvailableMB,
	CONVERT (DEC(15,2),ROUND(((f.size-FILEPROPERTY(f.name,'SpaceUsed'))/128.000),2)/2014) sizeAvailableGB,
    CONVERT (DEC(15,2),ROUND(FILEPROPERTY(f.name,'SpaceUsed')/128.000,2)/ROUND(f.size/128.000,2)*100) usagePercentage	
FROM sys.sysfiles f (NOLOCK) JOIN sys.sysfilegroups fg (NOLOCK) ON f.groupid = fg.groupid
WHERE fg.groupname LIKE '%DWH%'
/*WHERE fg.groupname in (
'DWHCaptacionesVista201605',
'DWHCaptacionesVista201606',
'DWHCaptacionesVista201608',
'DWHCaptacionesVista201607',
'DWHCaptacionesVistaMesNuevo',
'FGFACClientesResumenNuevo',
'FGFACClientesResumen201607',
'DWHMantenimiento'
)*/
ORDER BY 6 DESC