--documents not in a workspace

SELECT count (*) FROM mhgroup.docmaster WHERE docnum NOT IN (SELECT item_id FROM mhgroup.project_items where itemtype='d')

SELECT docnum,docname FROM mhgroup.docmaster WHERE docnum NOT IN (SELECT item_id FROM mhgroup.project_items where itemtype='d')