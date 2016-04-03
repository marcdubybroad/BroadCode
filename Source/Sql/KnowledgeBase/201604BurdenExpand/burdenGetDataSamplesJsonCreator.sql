


select
concat('[{ "ID": { "SAMPLES_13k_mdv2": "', ifnull(ID, 'NULL'), '"}},') as id,
concat('{ "ANCESTRY": { "SAMPLES_13k_mdv2": "', ifnull(ANCESTRY, 'NULL'), '"}},') as ancestry,
concat('{ "T2D": { "SAMPLES_13k_mdv2": ', ifnull(T2D, 'NULL'), '}},') as t2d,
concat('{ "AGE": { "SAMPLES_13k_mdv2": ', ifnull(AGE, 'NULL'), '}},') as age,
concat('{ "FAST_GLU": { "SAMPLES_13k_mdv2": ', ifnull(FAST_GLU, 'NULL'), '}},') as fast_glu,
concat('{ "FAST_INS": { "SAMPLES_13k_mdv2": ', ifnull(FAST_INS, 'NULL'), '}},') as fast_ins,
concat('{ "BMI": { "SAMPLES_13k_mdv2": ', ifnull(BMI, 'NULL'), '}},') as bmi,
concat('', '{ "WEIGHT": { "SAMPLES_13k_mdv2": ', ifnull(WEIGHT, 'NULL'), '}},') as weight,
concat('', '{ "HDL": { "SAMPLES_13k_mdv2": ', ifnull(HDL, 'NULL'), '}},') as hdl,
concat('', '{ "LDL": { "SAMPLES_13k_mdv2": ', ifnull(LDL, 'NULL'), '}}],') as ldl
from SAMPLE_13k 
limit 10;




--where BMI != null and HDL != null and LDL != null
--'{ "BMI": { "SAMPLES_13k_mdv2": ' | BMI | '}},'
--{
--    "MAF": {
--        "SAMPLES_13k_mdv2": 0.127025738798856
--    }
--},
