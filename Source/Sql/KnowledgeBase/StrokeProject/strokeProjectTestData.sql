

-- Marc Duby
-- 02/03/2016
-- File for scripts to load test data

-- create the dummy test tables
drop table if exists ExSeq_39k_dv5;
create table ExSeq_39k_dv5 select * from ExSeq_17k_dv2;

drop table if exists ExSeq_39k_eu_dv5;
create table ExSeq_39k_eu_dv5 select * from ExSeq_17k_eu_dv2;

drop table if exists ExSeq_39k_dv5__STRK;
create table ExSeq_39k_dv5__STRK select * from ExSeq_17k_dv2__T2D;

drop table if exists ExSeq_39k_eu_dv5__STRK;
create table ExSeq_39k_eu_dv5__STRK select * from ExSeq_17k_eu_dv2__T2D;


-- add in to phenotype table
delete from PH where PH = 'STRK';
insert into PH (PH, GRP, SORT) values('STRK', 'RENAL', 30);

-- add in phenotype table link
delete from ID_PH where lower(ID) like '%39k%';
insert into ID_PH (ID, PH, TBL) values('ExSeq_39k_mdv5', 'STRK', 'ExSeq_39k_dv5__STRK');
insert into ID_PH (ID, PH, TBL) values('ExSeq_39k_eu_mdv5', 'STRK', 'ExSeq_39k_eu_dv5__STRK');

-- add dataset poperties for the stroke mdv
delete from PROP_ID where lower(ID) like '%39k%';
insert into PROP_ID (PROP, ID) select PROP, 'ExSeq_39k_mdv5' from PROP_ID where ID = 'ExSeq_17k_mdv2';
insert into PROP_ID (PROP, ID) select PROP, 'ExSeq_39k_eu_mdv5' from PROP_ID where ID = 'ExSeq_17k_eu_mdv2';

-- add in tables to dataset




