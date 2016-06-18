USE master
SELECT Obj.name, Ind.rows FROM sysobjects Obj
INNER JOIN sysindexes Ind ON Obj.id = Ind.id
WHERE Obj.type = 'U' -- Tablas de usuario
AND Ind.IndId < 2
ORDER BY Ind.rows DESC