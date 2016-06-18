DECLARE @Table TABLE(
        SPID INT,
        Status VARCHAR(MAX),
        Login VARCHAR(MAX),
        HostName VARCHAR(MAX),
        BlkBy VARCHAR(MAX),
        DBName VARCHAR(MAX),
        Command VARCHAR(MAX),
        CPUTime INT,
        DiskIO INT,
        LastBatch VARCHAR(MAX),
        ProgramName VARCHAR(MAX),
        SPID_1 INT,
        REQUESTID INT
)

INSERT INTO @Table EXEC sp_who2 'active'

SELECT  * FROM @Table
WHERE DBName = 'SMBODSA2' 
AND Command = 'DELETE'