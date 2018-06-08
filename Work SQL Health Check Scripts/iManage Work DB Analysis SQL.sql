/****************************************/
/*  DOCUMENTS                           */
/****************************************/

-- TOTAL # LIBRARIES
select count(*) 'TOTAL LIBRARIES' 
  from MHGROUP.LIBRARIES (NOLOCK)

-- WORKSITE DOCUMENT COUNTS
select count(*) 'TOTAL DOCUMENTS' 
  from MHGROUP.DOCMASTER (NOLOCK)
 where TYPE = 'D'
   and C_ALIAS <> 'WEBDOC'

-- TOTAL # PROFILES
SELECT COUNT(*) 'TOTAL PROFILES' 
  FROM MHGROUP.MHPROFILES (NOLOCK)

-- TOTAL # WORKSPACES
SELECT COUNT(*) 'TOTAL WORKSPACES'
  FROM MHGROUP.DOCMASTER (NOLOCK)
 WHERE C_ALIAS = 'WEBDOC'

-- TOTAL # OF FOLDERS
select count(distinct p.PRJ_NAME) 'TOTAL PROJECT FOLDERS'
  from MHGROUP.PROJECTS p (NOLOCK), MHGROUP.DOCMASTER d (NOLOCK), MHGROUP.PROJECT_ITEMS pit (NOLOCK) 
 where pit.ITEM_ID = d.DOCNUM and pit.PRJ_ID = p.PRJ_ID

-- DOCUMENTS FILED TO FOLDERS
SELECT COUNT(*) 'DOCS IN FOLDERS'
  FROM MHGROUP.DOCMASTER D, MHGROUP.PROJECT_ITEMS PI (NOLOCK)
 WHERE D.DOCNUM = PI.ITEM_ID
   AND D.TYPE = 'D'
   AND D.C_ALIAS <> 'WEBDOC'

-- WORKSITE DOCUMENT SIZE
select sum(docsize)/1024 'TOTAL DOCUMENT SIZE (KB)' 
  from mhgroup.DOCMASTER D (NOLOCK)
 where TYPE = 'D'
   AND D.C_ALIAS <> 'WEBDOC'

/****************************************/
/*  USERS & GROUPS MEMBERSHIP           */
/****************************************/

-- TOTAL USERS BY GROUP MEMBERSHIP
select g.FULLNAME 'GROUP ID', COUNT(gm.USERNUM) 'TOTAL USERS'
  from MHGROUP.GROUPS g (NOLOCK), MHGROUP.GROUPMEMS gm (NOLOCK)
 where g.GROUPNUM = gm.GROUPNUM
 group by g.FULLNAME
 order by COUNT(gm.USERNUM)DESC

/****************************************/
/*  DOCUMENTS BY APPLICATION TYPE       */
/****************************************/

-- DOCUMENTS BY APPLICATION
SELECT T_ALIAS 'DOC TYPE', COUNT(*) 'DOC COUNT'
FROM MHGROUP.DOCMASTER (NOLOCK)
WHERE TYPE = 'D'
  AND C_ALIAS <> 'WEBDOC'
GROUP BY T_ALIAS
ORDER BY COUNT(*) DESC

/****************************************/
/*  DOCUMENTS BY DOCUMENT TYPE          */
/****************************************/

-- DOCUMENTS BY DOCUMENT CLASS
SELECT d.C_ALIAS 'CLASS', isnull(dc.CLASSDESCRIPT, ' ') 'DESCRIPTION', COUNT(*) 'DOC COUNT'
FROM MHGROUP.DOCMASTER d (NOLOCK)
     LEFT OUTER JOIN MHGROUP.DOCCLASSES dc (NOLOCK)
                  on d.C_ALIAS = dc.C_ALIAS
WHERE d.C_ALIAS <> 'WEBDOC'
  AND d.TYPE = 'D'
GROUP BY d.C_ALIAS, dc.CLASSDESCRIPT
ORDER BY COUNT(*) DESC

-- DOCUMENTS BY DOCUMENT SUBCLASS
-- If no SUBCLASSES are found, the summed result will return for SUBCLASS = NULL
SELECT d.SUBCLASS_ALIAS 'SUBCLASS', isnull(dsc.CLASSDESCRIPT, ' ') 'DESCRIPTION', COUNT(*) 'DOC COUNT'
FROM MHGROUP.DOCMASTER d (NOLOCK)
     LEFT OUTER JOIN MHGROUP.DOCSUBCLASSES dsc (NOLOCK)
                  on d.C_ALIAS = dsc.C_ALIAS
                 and d.SUBCLASS_ALIAS = dsc.SUBCLASS_ALIAS
WHERE d.C_ALIAS <> 'WEBDOC'
  AND d.TYPE = 'D'
GROUP BY d.SUBCLASS_ALIAS, dsc.CLASSDESCRIPT
ORDER BY COUNT(*) DESC



/****************************************/
/*  DOCUMENT CREATION                   */
/****************************************/

-- Document Creation Date Breakdown (2000+)
select DATEPART(YYYY, ENTRYWHEN) 'YEAR', COUNT(*) 'DOC COUNT'
  from MHGROUP.DOCMASTER (NOLOCK)
 where TYPE = 'D'
   and C_ALIAS <> 'WEBDOC'
   and DATEPART(YYYY, ENTRYWHEN) >= 2000
 group by DATEPART(YYYY, ENTRYWHEN)
 order by  DATEPART(YYYY, ENTRYWHEN) DESC
 

-- Document Creation Date Breakdown (Pre 2000)
 select COUNT(*) 'DOC COUNT'
  from MHGROUP.DOCMASTER (NOLOCK)
 where TYPE = 'D'
   and C_ALIAS <> 'WEBDOC'
   and DATEPART(YYYY, ENTRYWHEN) < 2000

/****************************************/
/*  DOCUMENT MODIFICATION               */
/****************************************/

-- Document Last Edit Date Breakdown (2000+)
select DATEPART(YYYY, EDITWHEN) 'YEAR', COUNT(*) 'DOC COUNT'
  from MHGROUP.DOCMASTER (NOLOCK)
 where TYPE = 'D'
   and C_ALIAS <> 'WEBDOC'
   and DATEPART(YYYY, EDITWHEN) >= 2000
 group by DATEPART(YYYY, EDITWHEN)
 order by  DATEPART(YYYY, EDITWHEN) DESC
 

-- Document Last Edit Date Breakdown (Pre 2000)
 select COUNT(*) 'DOC COUNT'
  from MHGROUP.DOCMASTER (NOLOCK)
 where TYPE = 'D'
   and C_ALIAS <> 'WEBDOC'
   and DATEPART(YYYY, EDITWHEN) < 2000
