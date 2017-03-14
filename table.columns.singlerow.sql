
CREATE TABLE #TBL( ID INT IDENTITY(1,1), tbl_name VARCHAR(100) );

INSERT INTO #TBL( tbl_name )VALUES( 'TableName' );

SELECT tbl_name, LTRIM(RTRIM(STUFF((
	SELECT ', ' + QUOTENAME(c.name) [text()]
     FROM sys.tables t  
     INNER JOIN sys.columns c ON t.object_id = c.object_id 
     WHERE t.name = tbl_name
     ORDER BY c.column_id
     FOR XML PATH(''), TYPE
).value('.','NVARCHAR(MAX)'),1,2,' '))) tbl_columns
FROM #TBL a
GROUP BY tbl_name
ORDER BY tbl_columns
 
DROP TABLE #TBL;
