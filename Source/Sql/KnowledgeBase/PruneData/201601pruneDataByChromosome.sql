

-- find all the tables that have a VAR_ID column

-- loop through the tables and remove any rows that are not chromosome 20








-- scratch
SELECT DISTINCT TABLE_NAME, COLUMN_NAME  
FROM INFORMATION_SCHEMA.COLUMNS  
WHERE column_name = 'VAR_ID'  
AND TABLE_SCHEMA = 'tad_test'
