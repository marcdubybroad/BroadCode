

-- drop the temop new variant table if it exists
drop table if exists new_variants;


-- create the variant table
create table new_variant (
    id int(9) not null primary key auto_increment,
    var_id varchar(4000) not null,
    db_snp_id varchar(4000) null,
    chromosome varchar(255) not null,
    position bigint(20) not null,
    insert_date timestamp);
    
-- populate the variant table; straihght copy from common_dv1 (gets rid of the long text issue)
insert into new_variant (var_id, db_snp_id, chromosome, position) select VAR_ID, DBSNP_ID, CHROM, POS from common_dv1;

-- create new variant difference table
create table diff_variant (
    id int(9) not null primary key auto_increment,
    var_id varchar(4000) not null,
    db_snp_id varchar(4000) null,
    chromosome varchar(255) not null,
    position bigint(20) not null,
    insert_date timestamp);

-- populate the difference variant table with variants that are in the new common_dv1 copy table but not in the current portal variant lookup table
insert into diff_variant (var_id, db_snp_id, chromosome, position)
    select nvar.var_id, nvar.db_snp_id, nvar.chromosome, nvar.position from new_variant nvar
        where not exists (select var_id from variant where var_id = nvar.var_id);


-- create the new variant table with the new variant data
create table new_variants select com.VAR_ID as var_id, com.DBSNP_ID as db_snp_id, com.CHROM as chromosome, com.POS as position from common_dv1 com left outer join variant var on com.VAR_ID = var.var_id and var.id is null

-- insert the new variants into the variant table, different created_date

-- 



