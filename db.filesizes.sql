
;WITH db_file_cte AS (
    SELECT name, type_desc, physical_name, CONVERT(DECIMAL(11, 2), size * 8.0 / 1024) size_mb, 
    CONVERT(DECIMAL(11, 2), FILEPROPERTY(name, 'spaceused') * 8.0 / 1024) space_used_mb
    FROM sys.database_files
)
SELECT name, type_desc, physical_name, size_mb, space_used_mb, 
NULLIF(CONVERT(DECIMAL(5, 2), space_used_mb / size_mb * 100), 0) space_used_percent
FROM db_file_cte;
