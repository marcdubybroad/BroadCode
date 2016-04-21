

-- modify the samples tables
alter table SAMPLE_13k modify column ID varchar(100) primary key;
alter table SAMPLE_17k modify column ID varchar(100) primary key;
alter table SAMPLE_26k modify column ID varchar(100) primary key;
alter table SAMPLE_STROKE modify column ID varchar(100) primary key;


-- common table
-- drop table if exists
drop table if exists SAMPLES_common_dv1;

-- create table
create table SAMPLES_common_dv1 (ID varchar(100) not null primary key);

-- delete from table
delete from SAMPLES_common_dv1;

-- add in the rows from the samples tables
insert into SAMPLES_common_dv1 (select ID from SAMPLE_13k s13 where not exists (select * from SAMPLES_common_dv1 where ID = s13.ID));
insert into SAMPLES_common_dv1 (select ID from SAMPLE_17k s13 where not exists (select * from SAMPLES_common_dv1 where ID = s13.ID));
insert into SAMPLES_common_dv1 (select ID from SAMPLE_26k s13 where not exists (select * from SAMPLES_common_dv1 where ID = s13.ID));
insert into SAMPLES_common_dv1 (select ID from SAMPLE_STROKE s13 where not exists (select * from SAMPLES_common_dv1 where ID = s13.ID));



-- DATASET
-- drop table if exists
drop table if exists SAMPLES_DATASET;

-- create table
create table SAMPLES_DATASET select * from DATASET;

-- remove all old rows
delete from SAMPLES_DATASET;

-- add in the samples rows
insert into SAMPLES_DATASET (ID, EXP, VER, SG, TECH, ANCESTRY, PARENT, TBL, SORT) values('samples_common_dv1', 'NULL', 'mdv1', 'NULL', 'NULL', 'NULL', 'Root', 'SAMPLES_common_dv1', 60);
-- insert into SAMPLES_DATASET (ID, EXP, VER, PARENT, TBL, SORT) values('samples_13k_mdv2', 'ExSeq_13k', 'mdv2', 'Root', 'SAMPLE_13k', 40);
-- insert into SAMPLES_DATASET (ID, EXP, VER, PARENT, TBL, SORT) values('samples_26k_mdv3', 'ExSeq_16k', 'mdv3', 'Root', 'SAMPLE_26k', 50);
insert into SAMPLES_DATASET (ID, EXP, VER, SG, TECH, ANCESTRY, PARENT, TBL, SORT, CASES, CONTROLS, SUBJECTS) values('samples_13k_mdv1', 'ExSeq_13k', 'mdv1', '13k', 'ExSeq', 'Mixed', 'Root', 'SAMPLE_13k', 30, 6514, 6440, 12954);
insert into SAMPLES_DATASET (ID, EXP, VER, SG, TECH, ANCESTRY, PARENT, TBL, SORT, CASES, CONTROLS, SUBJECTS) values('samples_17k_mdv2', 'ExSeq_17k', 'mdv2', '17k', 'ExSeq', 'Mixed', 'Root', 'SAMPLE_17k', 40, 8379, 8478, 16857);
insert into SAMPLES_DATASET (ID, EXP, VER, SG, TECH, ANCESTRY, PARENT, TBL, SORT, CASES, CONTROLS, SUBJECTS) values('samples_26k_mdv3', 'ExSeq_26k', 'mdv3', '26k', 'ExSeq', 'Mixed', 'Root', 'SAMPLE_26k', 50, 10234, 13267, 23501);
insert into SAMPLES_DATASET (ID, EXP, VER, SG, TECH, ANCESTRY, PARENT, TBL, SORT, CASES, CONTROLS, SUBJECTS) values('samples_stroke_mdv5', 'ExSeq_stroke', 'mdv5', 'Stroke', 'ExSeq', 'Mixed', 'Root', 'SAMPLE_STROKE', 60, 841, 900, 1741);

-- add in subjects, controls etc
-- update SAMPLES_DATASET da set da.CASES = 6514, da.CONTROLS = 6440, da.SUBJECTS = 12954 where da.ID = 'samples_13k_mdv2';
-- update SAMPLES_DATASET da set da.CASES = 10234, da.CONTROLS = 13267, da.SUBJECTS = 23501 where da.ID = 'samples_26k_mdv3';


-- PROP
-- drop table if exists
drop table if exists SAMPLES_PROP;

-- create table
create table SAMPLES_PROP select * from PROP;

-- remove all old rows
delete from SAMPLES_PROP;

-- add in the samples rows
insert into SAMPLES_PROP
select column_name, 'FALSE', 'TRUE', column_name, if(column_type like '%text', 'STRING', if(column_type = 'double', 'FLOAT', 'INTEGER')), 'TRUE', 'TRUE', 60, 'NULL'
    FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dig_qa' AND TABLE_NAME = 'SAMPLE_13k';
    
insert into SAMPLES_PROP
select info.column_name, 'FALSE', 'TRUE', info.column_name, if(info.column_type like '%text', 'STRING', if(info.column_type = 'double', 'FLOAT', 'INTEGER')), 'TRUE', 'TRUE', 60, 'NULL'
    FROM INFORMATION_SCHEMA.COLUMNS info WHERE TABLE_SCHEMA = 'dig_qa' AND TABLE_NAME = 'SAMPLE_17k'
    and not exists (select PROP from SAMPLES_PROP where PROP = info.column_name);

    
insert into SAMPLES_PROP
select info.column_name, 'FALSE', 'TRUE', info.column_name, if(info.column_type like '%text', 'STRING', if(info.column_type = 'double', 'FLOAT', 'INTEGER')), 'TRUE', 'TRUE', 60, 'NULL'
    FROM INFORMATION_SCHEMA.COLUMNS info WHERE TABLE_SCHEMA = 'dig_qa' AND TABLE_NAME = 'SAMPLE_26k'
    and not exists (select PROP from SAMPLES_PROP where PROP = info.column_name);

insert into SAMPLES_PROP
select info.column_name, 'FALSE', 'TRUE', info.column_name, if(info.column_type like '%text', 'STRING', if(info.column_type = 'double', 'FLOAT', 'INTEGER')), 'TRUE', 'TRUE', 60, 'NULL'
    FROM INFORMATION_SCHEMA.COLUMNS info WHERE TABLE_SCHEMA = 'dig_qa' AND TABLE_NAME = 'SAMPLE_STROKE'
    and not exists (select PROP from SAMPLES_PROP where PROP = info.column_name);


-- PROP_ID
-- drop table if exists
drop table if exists SAMPLES_PROP_ID;

-- create table
create table SAMPLES_PROP_ID select * from PROP_ID;

-- remove all old rows
delete from SAMPLES_PROP_ID;

-- TODO: need to pull in from mysql tables
-- add in the samples rows
insert into SAMPLES_PROP_ID
    select pr.PROP, sa.ID from SAMPLES_DATASET sa, SAMPLES_PROP pr, INFORMATION_SCHEMA.COLUMNS info
    where (sa.ID != 'samples_common_dv1' and sa.TBL = info.TABLE_NAME and pr.PROP = info.COLUMN_NAME and TABLE_SCHEMA = 'dig_qa');
    
insert into SAMPLES_PROP_ID values('samples_common_dv1','ID');



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





-- add covariate/phenotype/filter meaning to properties
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, PHENOTYPE' where PROP = 'HDL';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, PHENOTYPE' where PROP = 'LDL';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, PHENOTYPE' where PROP = 'CHOL';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, PHENOTYPE' where PROP = 'BMI';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, PHENOTYPE' where PROP = 'WHR';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, PHENOTYPE' where PROP = 'HDL';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, PHENOTYPE' where PROP = 'FAST_GLU';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, PHENOTYPE' where PROP = 'FAST_INS';

update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, PHENOTYPE' where PROP = 'Lobar_ICH';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, PHENOTYPE' where PROP = 'Deep_ICH';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, PHENOTYPE' where PROP = 'ln_ICH_Volume';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, PHENOTYPE' where PROP = 'Hemorrhage_Location';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, PHENOTYPE' where PROP = 'Number_of_Previous_Hemhorrhages';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, PHENOTYPE' where PROP = 'Hours_from_Symptoms_to_CT';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, PHENOTYPE' where PROP = 'History_of_Hypertension';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, PHENOTYPE' where PROP = 'Site';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER, PHENOTYPE' where PROP = 'ICH_Status';

update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER' where PROP = 'SEX';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER' where PROP = 'ANCESTRY';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER' where PROP = 'AGE';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER' where PROP = 'Age';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER' where PROP = 'HEIGHT';
update SAMPLES_PROP set MEANING = 'COVARIATE, FILTER' where PROP = 'WEIGHT';

update SAMPLES_PROP set MEANING = 'COVARIATE' where PROP regexp '^C[0-9]';



-- scratch
SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dig_qa' AND TABLE_NAME = 'SAMPLE_13k';
SELECT COLUMN_NAME, COLUMN_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dig_qa' AND TABLE_NAME = 'SAMPLE_13k';
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_SCHEMA = 'dig_qa' AND TABLE_NAME = 'SAMPLE_13k';


select * from SAMPLES_PROP sp, SAMPLES_PROP_ID sprop where sp.PROP = sprop.PROP and sprop.ID = 'samples_26k_mdv3' and lower(sp.MEANING) like '%phenotype%';



