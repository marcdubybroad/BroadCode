
-- common table
-- drop table if exists
drop table if exists SAMPLES_common_dv1;
create table SAMPLES_common_dv1 (ID text null);

-- add in the rows from the samples tables
insert into SAMPLES_common_dv1 (select ID from SAMPLE_13k s13 where not exists (select * from SAMPLES_common_dv1 where ID = s13.ID));
insert into SAMPLES_common_dv1 (select ID from SAMPLE_26k s13 where not exists (select * from SAMPLES_common_dv1 where ID = s13.ID));

-- DATASET
-- drop table if exists
drop table if exists SAMPLES_DATASET;

-- create table
create table SAMPLES_DATASET select * from DATASET;

-- remove all old rows
delete from SAMPLES_DATASET;x

-- add in the samples rows
insert into SAMPLES_DATASET (ID, EXP, SG, VER, PARENT, TBL, SORT) values('samples_common_dv1', 'null', 'NULL', 'mdv1', 'Root', 'SAMPLES_common_dv1', 60);
insert into SAMPLES_DATASET (ID, EXP, VER, PARENT, TBL, SORT) values('samples_13k_mdv2', 'ExSeq_13k', 'mdv2', 'Root', 'SAMPLE_13k', 40);
insert into SAMPLES_DATASET (ID, EXP, VER, PARENT, TBL, SORT) values('samples_26k_mdv3', 'ExSeq_16k', 'mdv3', 'Root', 'SAMPLE_26k', 50);

-- add in subjcts, controls etc
update SAMPLES_DATASET da set da.CASES = 6514, da.CONTROLS = 6440, da.SUBJECTS = 12954 where da.ID = 'samples_13k_mdv2';
update SAMPLES_DATASET da set da.CASES = 10234, da.CONTROLS = 13267, da.SUBJECTS = 23501 where da.ID = 'samples_26k_mdv3';


-- PROP
-- drop table if exists
drop table if exists SAMPLES_PROP;

-- create table
create table SAMPLES_PROP select * from PROP;

-- remove all old rows
delete from SAMPLES_PROP;

-- add in the samples rows
insert into SAMPLES_PROP
select column_name, 'FALSE', 'TRUE', column_name, if(column_type = 'text', 'STRING', if(column_type = 'double', 'FLOAT', 'INTEGER')), 'TRUE', 'TRUE', 60, 'NULL'
    FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dig_qa' AND TABLE_NAME = 'SAMPLE_13k' and column_name != 'ID';



-- PROP_ID
-- drop table if exists
drop table if exists SAMPLES_PROP_ID;

-- create table
create table SAMPLES_PROP_ID select * from PROP_ID;

-- remove all old rows
delete from SAMPLES_PROP_ID;

-- add in the samples rows
insert into SAMPLES_PROP_ID select pr.PROP, sa.ID from SAMPLES_DATASET sa, SAMPLES_PROP pr;


-- ID_PH
-- drop table if exists
drop table if exists SAMPLES_ID_PH;

-- create table
create table SAMPLES_ID_PH select * from ID_PH;

-- remove all old rows
delete from SAMPLES_ID_PH;



-- PROP_ID_PH
-- drop table if exists
drop table if exists SAMPLES_PROP_ID_PH;

-- create table
create table SAMPLES_PROP_ID_PH select * from PROP_ID_PH;

-- remove all old rows
delete from SAMPLES_PROP_ID_PH;






-- scratch
SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dig_qa' AND TABLE_NAME = 'SAMPLE_13k';
SELECT COLUMN_NAME, COLUMN_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dig_qa' AND TABLE_NAME = 'SAMPLE_13k';
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dig_qa' AND TABLE_NAME = 'SAMPLE_13k';



