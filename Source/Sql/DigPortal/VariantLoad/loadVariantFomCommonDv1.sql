




-- create new table for new variants
select com.VAR_ID, com.DBSNP_ID, var.id from common_dv1 com left outer join variant var on com.VAR_ID = var.id

drop table if exists new_vartiants;

create table new_variants select com.VAR_ID as var_id, com.DBSNP_ID as db_snp_id, com.CHROM as chromosome, com.POS as position from common_dv1 com left outer join variant var on com.VAR_ID = var.var_id and var.id is null



