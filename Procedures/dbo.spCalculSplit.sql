SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Raluca Marcu
-- Create date: 24.09.2017
-- Description:	Split a string using a ';' delimitator
-- =============================================
CREATE PROCEDURE [dbo].[spCalculSplit]
	-- Add the parameters for the stored procedure here
	-- Test Run : spCalculSplit 'ac87b7b6f23e83f811dbe35a918b901592dadf2b.jpg;046e1c8c25ffa3717d4708640ec545133e6b1061.jpg;ae5073add71140ae8063dc559e2de2c9a50fcf8b.jpg;de96cb4322e8f5a5ceca0b3671c0b11a45a3c674.jpg;24ed27bf07376433a8e8b553a2c6b8145c795f23.jpg;3482d0f04d9054e936590f710dfb8a966bb9651f.jpg;192ae5ae57a92c1cf6b2dd6cf967b5e9c259c113.jpg;9be0bb8f194acd96b829b249bf388b81600b465d.jpg'
	@id_list VARCHAR(MAX)  
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @table TABLE ( id VARCHAR(255) )
	DECLARE @x INT = 0
	DECLARE @firstcomma INT = 0
	DECLARE @nextcomma INT = 0

	SET @x = LEN(@id_list) - LEN(REPLACE(@id_list, ';', '')) + 1 -- number of ids in id_list

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
