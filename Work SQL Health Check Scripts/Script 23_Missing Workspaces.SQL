
-- Clients which do no have a client-specific workspace
select c.custom_alias as 'ClientID', c.c_descript as 'ClientName'
from mhgroup.custom1 c (nolock)
where not exists (
	select 1
	from mhgroup.docmaster a (nolock)
	inner join mhgroup.projects b (nolock)
	on ( b.docnum = a.docnum and b.version = a.version and b.type = 1 and b.subtype = 'work' )
	where a.type = 'P' and a.c1alias = c.custom_alias and a.c2alias is null
)
and c.enabled = 'Y'
order by c.custom_alias




-- Matters which do not have a matter-specific workspace
select c.custom_alias as 'ClientID', m.custom_alias as 'MatterID', c.c_descript as 'ClientName', m.c_descript as 'MatterName'
from mhgroup.custom2 m (nolock)
inner join mhgroup.custom1 c (nolock)
on ( c.custom_alias = m.cparent_alias )
where not exists (
	select 1
	from mhgroup.docmaster a (nolock)
	inner join mhgroup.projects b (nolock)
	on ( b.docnum = a.docnum and b.version = a.version and b.type = 1 and b.subtype = 'work' )
	where a.type = 'P' and a.c1alias = m.cparent_alias and a.c2alias = m.custom_alias
)
and m.enabled = 'Y'
order by c.custom_alias, m.custom_alias