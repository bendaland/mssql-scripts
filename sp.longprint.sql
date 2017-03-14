
CREATE PROCEDURE [dbo].[LongPrint]
	@string NVARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON;
	
	SET @string = RTRIM( @string );

	DECLARE 
		@cr CHAR(1), 
		@lf CHAR(1),
		@len INT, 
		@cr_index INT, 
		@lf_index INT, 
		@crlf_index INT, 
		@has_cr_and_lf BIT, 
		@left NVARCHAR(4000), 
		@reverse NVARCHAR(4000)
		
	SET @cr = CHAR(13);
	SET @lf = CHAR(10); 
	SET @len = 4000;

	WHILE ( LEN( @string ) > @len )
		BEGIN
		   SET @left = LEFT( @string, @len );
		   SET @reverse = REVERSE( @left );
		   SET @cr_index = @len - CHARINDEX( @cr, @reverse ) + 1;
		   SET @lf_index = @len - CHARINDEX( @lf, @reverse ) + 1;
		   SET @crlf_index = CASE WHEN @cr_index < @lf_index THEN @cr_index ELSE @lf_index END;
		   SET @has_cr_and_lf = CASE WHEN @cr_index < @len and @lf_index < @len THEN 1 ELSE 0 END;
		   
		   PRINT( LEFT( @string, @crlf_index - 1 ) );
		   
		   SET @string = RIGHT( @string, LEN( @string ) - @crlf_index - @has_cr_and_lf );
		END

	PRINT( @string );
END
