SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_migration_process_general_insert_tables_data]
	-- Add the parameters for the stored procedure here
	 @file_path varchar(800) = 'C:\Users\win81\Desktop\qiasmed\fisiere_excel_de_import\EOLABS_2018_09_V0.xlsx' 
	,@excel_sheet_name varchar(150) = 'Produse'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF EXISTS (SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID('tmp_import_excel'))
	BEGIN
		DROP TABLE tmp_import_excel;
	END
	IF EXISTS (SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID('tmp_import_excel_top'))
	BEGIN
		DROP TABLE tmp_import_excel_top;
	END
	CREATE TABLE tmp_import_excel (f1 varchar(800), f2 varchar(800), f3 varchar(800), f4 varchar(800), f5 varchar(800), f6 varchar(800)
		, f7 varchar(800), f8 varchar(800), f9 varchar(800))
	CREATE TABLE tmp_import_excel_top (category varchar(255), name varchar(500), product_code varchar(255), price_per_unit varchar(255), unit_type varchar(255),  unit_per_package varchar(255)
	, packing_mode varchar(255), measurement_unit varchar(255), [description] varchar(2000))


	DECLARE @TSQL varchar(8000), @TSQL2 varchar(8000)

	SELECT  @TSQL = 'SELECT * INTO #mytemptable FROM OPENROWSET(''Microsoft.ACE.OLEDB.12.0'',
               ''EXCEL 12.0;DataBase=' + @file_path + 
				';Extended Properties="EXCEL 12.0 Xml;HDR=NO'', [' + @excel_sheet_name + '$])' + CHAR(10) + CHAR(13)
	SET @TSQL = @TSQL + 'SELECT F1, F2, F3, F4, F5, F6, F7, F8, F9 FROM #mytemptable'
	
	INSERT INTO tmp_import_excel
	EXEC(@TSQL)
	DELETE FROM tmp_import_excel WHERE f1 is null and f2 is null and f3 is null and f4 is null and f5 is null and f6 is null and f7 is null
				and f8 is null and f9 is null

	--ALTER TABLE tmp_import_excel ADD treated BIT
	--UPDATE tmp_import_excel
	--SET treated = 0
END










GO
