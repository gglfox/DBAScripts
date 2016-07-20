/****** Script for SelectTopNRows command from SSMS  ******/
SELECT	j.[job_id],
		j.[name],
		j.[enabled],
		SUSER_SNAME(j.[owner_sid]) [owner_sid],
		j.[date_created],
		j.[date_modified],
		MAX(CAST(STUFF(STUFF(CAST(js.[last_run_date] AS VARCHAR),7,0,'-'),5,0,'-') + 
			' ' +
			STUFF(STUFF(REPLACE(STR(js.[last_run_time],6,0),' ','0'),5,0,':'),3,0,':') AS DATETIME)) last_run
FROM [msdb].[dbo].[sysjobs] j
INNER JOIN [msdb].[dbo].[sysjobsteps] js ON j.[job_id] = js.[job_id]
WHERE j.[enabled] = 1
GROUP BY j.[job_id], j.[name], j.[enabled], j.[description], SUSER_SNAME(j.[owner_sid]), j.[date_created], j.[date_modified]
ORDER BY 7 DESC