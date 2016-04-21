


-- get sample properties by property
select * from SAMPLES_PROP_ID p where p.PROP like 'FAST%';

-- get sample properties by sample group
select * from SAMPLES_PROP_ID p where p.ID like '%Stroke%';