--sql query to show me all the workspaces in the dms that DONT have any documents in them?--



select b.prj_name as 'WorkSpace Name', a.c1alias as 'Client', a.c2alias as 'Matter'
from mhgroup.docmaster a (nolock)
inner join mhgroup.projects b (nolock)
on ( b.docnum = a.docnum and b.version = a.version )
where a.type = 'P'
and not exists (select 1
			from mhgroup.projects c (nolock), mhgroup.project_items d (nolock)
			where c.tree_id = b.prj_id
			and   d.prj_id = c.prj_id)
