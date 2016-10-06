SELECT	[restore_history_id],
		[restore_date],
		[destination_database_name],
		[user_name],
		[backup_set_id],
		[restore_type],
		[replace],
		[recovery],
		[restart],
		[stop_at],
		[device_count],
		[stop_at_mark_name],
		[stop_before]
FROM [msdb].[dbo].[restorehistory] 
ORDER BY [restore_date] DESC