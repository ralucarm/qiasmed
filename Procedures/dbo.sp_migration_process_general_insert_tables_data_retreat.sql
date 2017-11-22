SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_migration_process_general_insert_tables_data_retreat]
		@id_migration int 
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
	select * from MigrationProductUntreated

	CREATE TABLE tmp_import_excel (f1 varchar(800), f2 varchar(800), f3 varchar(800), f4 varchar(800), f5 varchar(800), f6 varchar(800)
		, f7 varchar(800), f8 varchar(800), f9 varchar(800))
	CREATE TABLE tmp_import_excel_top (category varchar(255), name varchar(500), product_code varchar(255), price_per_unit varchar(255), unit_type varchar(255),  unit_per_package varchar(255)
	, packing_mode varchar(255), measurement_unit varchar(255), [description] varchar(2000))
	

	INSERT INTO tmp_import_excel (f1,f2,f3,f4,f5,f6,f7,f8,f9)
	SELECT [category],[product_name],[product_code],[price_by_unit],[unit_type]
		,[unit_pack],[packaging], [measurement_unit],[description]
	FROM [MigrationProductUntreated]
	WHERE FkIdMigration = @id_migration 
END










GO
