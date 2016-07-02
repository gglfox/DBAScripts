SELECT
	percent_complete,
	start_time,
	status,
	command,
	DB_NAME(database_id) db,
	blocking_session_id,
	wait_type,	
	estimated_completion_time,
	cpu_time,
	total_elapsed_time
FROM sys.dm_exec_requests
WHERE command = 'DbccFilesCompact'