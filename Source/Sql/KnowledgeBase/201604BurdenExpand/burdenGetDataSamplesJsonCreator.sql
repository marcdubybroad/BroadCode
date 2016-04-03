


select
concat('[{ "ID": { "SAMPLES_13k_mdv2": "', ifnull(ID, 'NULL'), '"}},') as id,
concat('{ "BMI": { "SAMPLES_13k_mdv2": ', ifnull(BMI, 'NULL'), '}},') as bmi,
concat('', '{ "WEIGHT": { "SAMPLES_13k_mdv2": ', ifnull(WEIGHT, 'NULL'), '}},') as weight,
concat('', '{ "HDL": { "SAMPLES_13k_mdv2": ', ifnull(HDL, 'NULL'), '}},') as hdl,
concat('', '{ "LDL": { "SAMPLES_13k_mdv2": ', ifnull(LDL, 'NULL'), '}}],') as ldl
from SAMPLE_13k 
limit 10;

where BMI != null and HDL != null and LDL != null

'{ "BMI": { "SAMPLES_13k_mdv2": ' | BMI | '}},'



{
    "MAF": {
        "SAMPLES_13k_mdv2": 0.127025738798856
    }
},
