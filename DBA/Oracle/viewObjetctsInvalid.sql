SELECT
  owner,
  object_type,
  COUNT(*)
FROM dba_objects 
WHERE status ='INVALID' 
GROUP BY owner, object_type;