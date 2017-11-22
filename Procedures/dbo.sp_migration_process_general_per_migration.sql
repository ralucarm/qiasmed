SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Raluca Marcu
-- Create date: 17.10.2017
-- Description:	Migration Process 
--				Initial Usage: Migration Process
--				
-- =============================================
CREATE PROCEDURE [dbo].[sp_migration_process_general_per_migration]
	-- Add the parameters for the stored procedure here
	  @file_path varchar(800) = 'C:\Users\win81\Desktop\qiasmed\fisiere_excel_de_import\koroglu_2017_09_V0.xlsx' 
	 ,@excel_sheet_name varchar(150) = 'Produse'
	 ,@migration_type varchar(50) = 'Excel'
	 ,@id_migration_surse int = null
	 ,@id_supplier int = 4
	 ,@id_user int = 3
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET XACT_ABORT ON;

    -- Insert statements for procedure here
	DECLARE @id_migration int
		,@current_date datetime = GETDATE()
		,@year_migration int
		,@month_migration varchar(100)
		,@supplier varchar(255)
		,@discount int
		,@is_percentage bit
		,@currency varchar(50)
		,@id_currency int
		,@id_country int
		,@error_migration_message varchar(2000) = ''


	IF (@id_migration_surse IS NOT NULL)
	BEGIN
		EXEC [sp_migration_process_general_insert_tables_data_retreat] @id_migration = @id_migration_surse

		SET @id_currency = (SELECT FkIdCurrency FROM MigrationLogs WHERE IdMigration = @id_migration)
		SET @year_migration = (SELECT YearMigration FROM MigrationLogs WHERE IdMigration = @id_migration)
		SET @month_migration = (SELECT MonthMigration FROM MigrationLogs WHERE IdMigration = @id_migration)		
		SET @is_percentage = (SELECT DiscountIsPercentage FROM MigrationLogs WHERE IdMigration = @id_migration)
		SET @discount = (SELECT Discount FROM MigrationLogs WHERE IdMigration = @id_migration)

		INSERT INTO MigrationLogs (DateMigration, FkIdParentMigration, FKIdSupplier, YearMigration, Discount, DiscountIsPercentage, FkIdCurrency
			, MonthMigration, FkIdCountrySupplier, FkIdUser) 
		SELECT @current_date AS DateMigration, @id_migration_surse AS FkIdParentMigration, @id_supplier AS FKIdSupplier
			, @year_migration AS YearMigration, @discount AS Discount, @is_percentage AS DiscountIsPercentage
			, @id_currency AS FkIdCurrency, @month_migration AS MonthMigration, null AS FkIdCountrySupplier, @id_user as FkIdUser
		SET @id_migration = SCOPE_IDENTITY()
		PRINT @id_migration
	END
	ELSE
	BEGIN
		EXEC sp_migration_process_general_insert_tables_data @file_path = @file_path, @excel_sheet_name = @excel_sheet_name
	
		SET @year_migration = (SELECT [f2] FROM tmp_import_excel WHERE RTRIM(LTRIM(f1)) = 'AN')
		SET @month_migration = (SELECT [f2] FROM tmp_import_excel WHERE RTRIM(LTRIM(f1)) = 'LUNA')
		SET @discount = (SELECT [f2] FROM tmp_import_excel WHERE RTRIM(LTRIM(f1)) = 'DISCOUNT')
		SET @is_percentage = (CASE WHEN EXISTS (SELECT * FROM tmp_import_excel WHERE RTRIM(LTRIM(f1)) = 'DISCOUNT' AND f2 like '%%%') THEN 1
							ELSE 0 END)
		SET @currency = (SELECT [f2] FROM tmp_import_excel WHERE RTRIM(LTRIM(f1)) = 'MONEDA DE SCHIMB')

		--CREATE TABLE #tmp_country_gen (IdCountry int)
		--INSERT INTO #tmp_country_gen (IdCountry)
		--EXEC sp_select_country_from_supplier @supplier = @supplier
		--SET @id_country = (SELECT IdCountry FROM #tmp_country_gen)
		--DROP TABLE #tmp_country_gen 

		IF (ISNULL(@currency, '') <> '') AND (RTRIM(LTRIM(@currency)) <> '-')
		BEGIN
			IF NOT EXISTS (SELECT * FROM Currency WHERE LabelName = [dbo].[CleanField](@currency))
			BEGIN
				INSERT INTO Currency(LabelName) VALUES ([dbo].[CleanField](@currency))				
			END
			SET @id_currency = (SELECT IdCurrency FROM Currency WHERE LabelName = [dbo].[CleanField](@currency))
		END

		INSERT INTO MigrationLogs (DateMigration, FKIdSupplier, YearMigration, Discount, DiscountIsPercentage, FkIdCurrency, MonthMigration
			, FkIdCountrySupplier, FkIdUser) 
		VALUES (@current_date, @id_supplier, @year_migration, @discount, @is_percentage, @id_currency, @month_migration, null, @id_user)
		SET @id_migration = SCOPE_IDENTITY()
		PRINT @id_migration
	END

	CREATE TABLE #tmp_migration(error_migration_message varchar(2000))
	
	BEGIN
		TRUNCATE TABLE tmp_import_excel_top					
		INSERT INTO tmp_import_excel_top (category, name, product_code, price_per_unit, unit_type,unit_per_package, packing_mode, measurement_unit, [description])		
		SELECT f1 AS category,f2 AS name,f3 AS product_code,f4 AS price_per_unit,f5 AS unit_type,f6 AS unit_per_package,f7 AS packing_mode,f8 AS measurement_unit,f9 AS [description]
		FROM tmp_import_excel
		WHERE RTRIM(LTRIM(f1)) <> 'AN' AND RTRIM(LTRIM(f1)) <> 'LUNA' AND RTRIM(LTRIM(f1)) <> 'FURNIZOR' AND RTRIM(LTRIM(f1)) <> 'DISCOUNT' 
			AND RTRIM(LTRIM(f1)) <> 'MONEDA DE SCHIMB' AND RTRIM(LTRIM(f1)) <> 'CATEGORIE'

		--INSERT INTO #tmp_migration(error_migration_message)
		EXEC [sp_migration_process_general_per_migration_batch] @migration_type = @migration_type, @id_migration = @id_migration		
		SET @error_migration_message = (SELECT Details FROM MigrationLogs WHERE IdMigration = @id_migration)
		IF (ISNULL(@error_migration_message,'') = '')
		BEGIN
			EXEC [sp_finalize_import] @id_migration = @id_migration
		END		
	END

	DROP TABLE tmp_import_excel_top
	--Produse sterse?
	--IF(@id_migration_surse IS NULL)
	--BEGIN
	--	IF ((SELECT COUNT(*) FROM MigrationLogs WHERE FkIdSupplier = @id_spider_name) = 1 AND (SELECT IdMigration FROM MigrationLogs WHERE FkIdSupplier = @id_spider_name) = @id_spider_name)
	--	BEGIN
	--		IF EXISTS(SELECT * FROM [dbo].[Product] WHERE FkIdSupplier = @id_spider_name 
	--			AND (IdProduct NOT IN (SELECT IdProduct FROM [dbo].[MigrationLogsPerProduct] WHERE [IdMigration] = @id_migration ) OR
	--									url_hash NOT IN (SELECT url_hash FROM [dbo].[MigrationProductUntreated] WHERE [IdMigration] = @id_migration)))
	--		BEGIN
	--			INSERT INTO [MigrationLogsPerProduct] ([IdMigration], [IdProduct], [Details], [MigrationStatus], [Date_Treatment])
	--			SELECT @id_migration as [IdMigration], IdProduct as [IdProduct], NULL as [Details], 'Deleted' as [MigrationStatus], @current_date as [Date_Treatment]
	--			FROM [dbo].[Product]
	--			WHERE FkIdSupplier = @id_spider_name 
	--				AND (IdProduct NOT IN (SELECT IdProduct FROM [dbo].[MigrationLogsPerProduct] WHERE [IdMigration] = @id_migration) OR
	--									url_hash NOT IN (SELECT url_hash FROM [dbo].[MigrationProductUntreated] WHERE [IdMigration] = @id_migration))

	--			UPDATE [dbo].[Product]
	--			SET FkIdStatus = 3
	--			WHERE IdProduct IN (SELECT IdProduct FROM [dbo].[MigrationLogsPerProduct] WHERE [IdMigration] = @id_migration AND [MigrationStatus] = 'Deleted')
			
	--			DECLARE @nb_products_deleted INT = (SELECT COUNT(IdProduct) FROM Product WHERE FKIdStatus = 3 AND  FkIdSupplier = @id_spider_name )
	--			UPDATE MigrationLogs
	--			SET NbProductsDeleted = @nb_products_deleted
	--			WHERE IdMigration = @id_migration			
	--		END
	--	END
	--END

	DROP TABLE tmp_import_excel

END












GO
