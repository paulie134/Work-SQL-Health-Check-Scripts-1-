--check for 3rd party customizations - per DB

select * from sysobjects where xtype='TR'
select * from sysobjects where xtype='P'