

SELECT COUNT(*)
FROM common_dv1 LEFT JOIN ExChip_82k_dv1__T2D ON common_dv1.VAR_ID = ExChip_82k_dv1__T2D.VAR_ID
WHERE common_dv1.MOST_DEL_SCORE <4 AND ExChip_82k_dv1__T2D.P_VALUE <0.000050 AND common_dv1.GENE = 'HDAC9' LIMIT 1000;

SELECT COUNT(*)
FROM common_dv1 LEFT JOIN ExChip_82k_dv1__T2D ON common_dv1.VAR_ID = ExChip_82k_dv1__T2D.VAR_ID
WHERE common_dv1.MOST_DEL_SCORE <4 AND ExChip_82k_dv1__T2D.P_VALUE <0.1 AND common_dv1.GENE = 'HDAC9' LIMIT 1000;


SELECT COUNT(*)
FROM common_dv1 LEFT JOIN ExChip_82k_dv1__T2D ON common_dv1.VAR_ID = ExChip_82k_dv1__T2D.VAR_ID
WHERE common_dv1.GENE = 'HDAC9' LIMIT 1000;


select count(com.var_id), com.closest_gene
from common_dv1 com, gwas_sigma1_dv1 diag
where com.var_id = diag.var_id
group by com.closest_gene;


select count(com.var_id), com.closest_gene
from common_dv1 com, ExSeq_39k_dv9 diag
where com.var_id = diag.var_id
group by com.closest_gene;

