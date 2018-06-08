--doc size = 0

select t_alias, count(*) from mhgroup.docmaster d where d.docsize=0 and d.docnum not in (
 
select docnum from mhgroup.doccache where upload='Y') and editwhen > '2005-01-01' group by t_alias

--Count Doc Type

SELECT T_ALIAS, COUNT(*) FROM MHGROUP.DOCMASTER WITH (NOLOCK) WHERE TYPE='D' GROUP BY T_ALIAS 