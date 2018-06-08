-- Average Size of Docs in KB & total siz in GB 

SELECT 

cast((AVG(DOCSIZE))/1024 as decimal(10,2)) 'AVG SIZE - KB', 

cast((SUM(DOCSIZE))/1024/1024/1024 as decimal(10,2)) 'TOTAL - GB' 

FROM MHGROUP.DOCMASTER WITH (NOLOCK) 

WHERE TYPE='D'
