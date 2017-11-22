SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_migration_process_general_insert_tables_data]
		 @file_path varchar(800) = 'C:\Users\win81\Desktop\qiasmed\Template Import Produse.xlsx'
	,@excel_sheet_name varchar(150) = 'Sheet1'
AS
BEGIN
			SET NOCOUNT ON;

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


	DECLARE @TSQL varchar(8000)

	SELECT  @TSQL = 'SELECT * FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0',
               'EXCEL 12.0;DataBase=' + @file_path + 
				';Extended Properties="EXCEL 12.0 Xml;HDR=NO', [' + @excel_sheet_name + '$])'
	INSERT INTO tmp_import_excel
	EXEC(@TSQL)
	DELETE FROM tmp_import_excel WHERE f1 is null and f2 is null and f3 is null and f4 is null and f5 is null and f6 is null and f7 is null
				and f8 is null and f9 is null

			END










GO
