--run these once per sql server

-- SQL Server Version		

SELECT  SERVERPROPERTY('productversion'), SERVERPROPERTY ('productlevel'), SERVERPROPERTY ('edition')

--Schedules Tasks / Maintenance Plan

USE MSDB
Select * from dbo.sysjobs

Select * from dbo.sysjobhistory

Select * from dbo.sysjobschedules