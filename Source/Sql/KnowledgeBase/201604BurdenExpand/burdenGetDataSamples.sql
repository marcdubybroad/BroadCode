
-- DATASET
-- drop table if exists
drop table if exists SAMPLES_DATASET;

-- create table
create table SAMPLES_DATASET select * from DATASET;

-- remove all old rows
delete from SAMPLES_DATASET;

-- add in the samples rows
insert into SAMPLES_DATASET (ID, VER, PARENT, TBL, SORT) values('SAMPLES_13k_mdv2', 'mdv2', 'Root', 'SAMPLE_13k', 60);
insert into SAMPLES_DATASET (ID, VER, PARENT, TBL, SORT) values('SAMPLES_26k_mdv2', 'mdv2', 'Root', 'SAMPLE_26k', 60);


-- PROP
-- drop table if exists
drop table if exists SAMPLES_PROP;

-- create table
create table SAMPLES_PROP select * from PROP;

-- remove all old rows
delete from SAMPLES_PROP;

-- add in the samples rows
insert into SAMPLES_PROP
select column_name, 'FALSE', 'NULL', column_name, if(column_type = 'text', 'STRING', if(column_type = 'double', 'FLOAT', 'INTEGER')), 'TRUE', 'TRUE', 60, 'NULL'
    FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dig_qa' AND TABLE_NAME = 'SAMPLE_13k';



-- PROP_ID
-- drop table if exists
drop table if exists SAMPLES_PROP_ID;

-- create table
create table SAMPLES_PROP_ID select * from PROP_ID;

-- remove all old rows
delete from SAMPLES_PROP_ID;

-- add in the samples rows
insert into SAMPLES_PROP_ID select pr.PROP, sa.ID from SAMPLES_DATASET sa, SAMPLES_PROP pr;








-- scratch
SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dig_qa' AND TABLE_NAME = 'SAMPLE_13k';
SELECT COLUMN_NAME, COLUMN_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dig_qa' AND TABLE_NAME = 'SAMPLE_13k';
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dig_qa' AND TABLE_NAME = 'SAMPLE_13k';



