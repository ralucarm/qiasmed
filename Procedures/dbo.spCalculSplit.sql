SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCalculSplit]
			@id_list VARCHAR(MAX)  
AS
BEGIN
			SET NOCOUNT ON;

    	DECLARE @table TABLE ( id VARCHAR(255) )
	DECLARE @x INT = 0
	DECLARE @firstcomma INT = 0
	DECLARE @nextcomma INT = 0

	SET @x = LEN(@id_list) - LEN(REPLACE(@id_list, ';', '')) + 1 

	WHILE @x > 0
		BEGIN
			SET @nextcomma = CASE WHEN CHARINDEX(';', @id_list, @firstcomma + 1) = 0
								  THEN LEN(@id_list) + 1
								  ELSE CHARINDEX(';', @id_list, @firstcomma + 1)
							 END
			INSERT  INTO @table
			VALUES  ( SUBSTRING(@id_list, @firstcomma + 1, (@nextcomma - @firstcomma) - 1) )
			SET @firstcomma = CHARINDEX(';', @id_list, @firstcomma + 1)
			SET @x = @x - 1
		END

	SELECT  *
	FROM    @table
END

GO
