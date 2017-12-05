SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_migration_process_general_per_migration_batch] 
	-- Add the parameters for the stored procedure here
	 @migration_type varchar(50) = 'Excel'
	,@id_migration int = 3
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE  @category varchar(255)
		,@name varchar(500)
		,@product_code varchar(255)
		,@unit_price varchar(255)
		,@unit_type varchar(255)
		,@units_per_package varchar(255)
		,@packing_mode varchar(255)
		,@measurement_unit varchar(255)
		,@description varchar(255)
		,@nb_errors int = 0
		,@nb_treated int = 0
		,@nb_inserted int = 0
		,@nb_updated int = 0
		,@details_error varchar(2000) = ''
		,@id_category int
		,@id_supplier int
		,@id_measurement_unit int
		,@id_unit_type int
		,@id_packing_mode int
		,@info_returned varchar(2000) = ''
		,@id_product int		
		,@cat_added bit = 0
		,@unit_type_added bit = 0
		,@packing_mode_added bit = 0
		,@measurement_unit_added bit = 0
		,@id_currency int
		,@current_date datetime = GETDATE()

	IF EXISTS (SELECT * FROM sys.objects WHERE [object_id] = OBJECT_ID('TmpResults'))
	BEGIN
		DROP TABLE TmpResults;
	END
	CREATE TABLE TmpResults (IdProduct int, IntegerResult int, ErrorMessage NVARCHAR(4000), Stage varchar(255))
	
	SELECT @id_supplier = FkIdSupplier, @id_currency = FkIdCurrency FROM MigrationLogs WHERE IdMigration = @id_migration
	IF EXISTS (SELECT * FROM Product WHERE FkIdSupplier = @id_supplier and ISNULL(IsVisible, 0) <> 0)
	BEGIN
		SET @nb_updated = (SELECT COUNT(*) FROM Product WHERE FkIdSupplier = @id_supplier and ISNULL(IsVisible, 0) <> 0)
		UPDATE Product 
		SET IsVisible = 0
			,[DateUpdated] = @current_date
		WHERE FkIdSupplier = @id_supplier and ISNULL(IsVisible, 0) <> 0
	END

	BEGIN TRY
	BEGIN TRANSACTION sp_migration_process;	
	BEGIN
		DECLARE cursor_util CURSOR LOCAL FOR			
		SELECT  category, name, product_code, price_per_unit, unit_type,unit_per_package, packing_mode, measurement_unit, [description]
		FROM tmp_import_excel_top
		OPEN cursor_util
		FETCH cursor_util INTO @category, @name, @product_code, @unit_price, @unit_type, @units_per_package, @packing_mode, @measurement_unit, @description
		WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @nb_treated = @nb_treated + 1
			CREATE TABLE #tmp_product_attributes (id_category int, id_unit_type int, id_measurement_unit int, nb_errors int
				, details_error varchar(2000), info_returned varchar(2000), cat_added bit, unit_type_added bit, measurement_unit_added bit)
			INSERT INTO #tmp_product_attributes
			EXEC sp_select_product_attributes @category = @category, @unit_type = @unit_type, @measurement_unit = @measurement_unit
			SELECT @id_category = id_category, @id_unit_type = id_unit_type, @id_measurement_unit = id_measurement_unit
				, @nb_errors = ISNULL(nb_errors,0), @cat_added = cat_added, @unit_type_added = unit_type_added
				, @measurement_unit_added = measurement_unit_added
			FROM #tmp_product_attributes
			SET @details_error = @details_error + ISNULL((SELECT details_error FROM #tmp_product_attributes), '')
			SET @info_returned = @info_returned + ISNULL((SELECT info_returned FROM #tmp_product_attributes), '')

			DROP TABLE #tmp_product_attributes
			IF (@id_category IS NULL OR @id_unit_type IS NULL OR @id_measurement_unit IS NULL OR @id_supplier IS NULL)
			BEGIN
				IF (@id_category IS NULL)
				BEGIN
					SET @nb_errors = @nb_errors + 1
					SET @details_error = @details_error + ' Error: Category "' + @category + '" Not Found ' + CHAR(10) + CHAR(13)
				END 
				IF (@id_unit_type IS NULL)
				BEGIN
					SET @nb_errors = @nb_errors + 1
					SET @details_error = @details_error + ' Error: Unit Type "' + @unit_type + '" Not Found ' + CHAR(10) + CHAR(13)
				END  	
				--IF (@id_packing_mode IS NULL)
				--BEGIN
				--	SET @nb_errors = @nb_errors + 1
				--	SET @details_error = @details_error + ' Error: Packing Mode "' + @packing_mode + '" Not Found ' + CHAR(10) + CHAR(13)
				--END  
				IF (@id_measurement_unit IS NULL)
				BEGIN
					SET @nb_errors = @nb_errors + 1
					SET @details_error = @details_error + ' Error: Measurement Unit"' + @measurement_unit + '" Not Found ' + CHAR(10) + CHAR(13)
				END  	
				IF (@id_supplier IS NULL)
				BEGIN
					SET @nb_errors = @nb_errors + 1
					SET @details_error = @details_error + ' Error: Supplier Not Found ' + CHAR(10) + CHAR(13)
				END  							
			END
			IF (ISNULL(@packing_mode, '') = '') OR ([dbo].[CleanField](@packing_mode) = '-')
			BEGIN
				SET @nb_errors  = @nb_errors + 1
				SET @details_error = @details_error + 'Error: Packing Mode ' + @packing_mode + ' is NULL or Empty String or not provided' + CHAR(10) + CHAR(13)
			END
			
			BEGIN	
				IF(@details_error = '' AND @nb_errors = 0)
				BEGIN
					
					INSERT INTO Product ([FKIdSupplier],[FKIdCategory],[ProductName],[PricePerUnit],[IsVisible],[UnitsPerPackage]
						, [ProductCode], [FkIdUnitType], [FkIdMeasurementUnit], [FkIdMigration], [DateAdded], [FKIdCurrency])
					SELECT @id_supplier as [FKIdSupplier], @id_category AS [FKIdCategory], @name as [ProductName]
						, @unit_price as [PricePerUnit], 1 as [IsVisible], CAST(@units_per_package AS decimal(8,2)) as [UnitsPerPackage]
						, @product_code as [ProductCode], @id_unit_type as [FkIdUnitType], @id_measurement_unit as [FkIdMeasurementUnit]
						, @id_migration as FkIdMigration, @current_date as [DateAdded], @id_currency as [FKIdCurrency]
					SET @id_product = SCOPE_IDENTITY()

					CREATE TABLE #tmp_packing_mode_product (label varchar(50))
					INSERT INTO #tmp_packing_mode_product(label)
					EXEC spCalculSplit @packing_mode

					INSERT INTO PackingMode (Label, FkIdProduct)
					SELECT [dbo].[CleanField](label) as Label, @id_product as FkIdProduct
					FROM #tmp_packing_mode_product tpm 

					DROP TABLE #tmp_packing_mode_product

					INSERT INTO MigrationLogsPerProduct(IdMigration, IdProduct, Details, StatusMigrationProduct)					
					SELECT @id_migration AS IdMigration, @id_product AS IdProduct, '' AS Details, 'Inserted' as StatusMigrationProduct
					SET @nb_inserted = @nb_inserted + 1
					IF (@cat_added = 1 OR @unit_type_added = 1 OR @packing_mode_added = 1 OR @measurement_unit_added = 1)
					BEGIN
						UPDATE MigrationLogsPerProduct
						SET IdCategoryAdded = (CASE WHEN @cat_added = 1 THEN @id_category ELSE NULL END)
							,IdTypeUnitAdded = (CASE WHEN @unit_type_added = 1 THEN @id_unit_type ELSE NULL END)
							,IdPackingModeAdded = (CASE WHEN @packing_mode_added = 1 THEN @id_packing_mode ELSE NULL END)
							,IdUnitMeasurementAdded = (CASE WHEN @measurement_unit_added = 1 THEN @id_measurement_unit ELSE NULL END)
						WHERE IdProduct = @id_product
					END
				END					
				ELSE
				BEGIN
					--SET @nb_errors = @nb_errors + 1
					INSERT INTO [MigrationProductUntreated]([category],[producer],[product_name],[product_code],[price_by_unit],[unit_type],[unit_pack],[packaging],[measurement_unit],[description],[currency],[FkIdMigration], [details_error])
					select @category as [category], @id_supplier as [producer], @name as [product_name], @product_code as [product_code], @unit_price as [price_by_unit]
							, @unit_type as [unit_type], @units_per_package as [unit_pack], @packing_mode as [packaging], @measurement_unit as [measurement_unit], @description as [description]
							, NULL as [currency], @id_migration as [FkIdMigration], @details_error as [details_error]
				END
			END;
			UPDATE MigrationLogs
			SET NBProductsTreated = @nb_treated
				,NbProductsAdded = @nb_inserted
				,NbProductsUpdated = @nb_updated
				,NbErrors =  isnull(NbErrors,0) + @nb_errors
			WHERE IdMigration = @id_migration
			SET @details_error = ''
			SET @info_returned = ''
			SET @cat_added = 0
			SET @unit_type_added = 0
			SET @packing_mode_added = 0
			SET @measurement_unit_added = 0

			FETCH cursor_util INTO  @category, @name, @product_code, @unit_price, @unit_type, @units_per_package, @packing_mode, @measurement_unit, @description
		END
		CLOSE cursor_util
		DEALLOCATE cursor_util
	PRINT 'Batch Finished with Success';
END	
	END TRY
		BEGIN CATCH
		DECLARE @message NVARCHAR(4000);
		DECLARE @error INT;
		DECLARE @xstate INT;
				
		SELECT @error = ERROR_NUMBER(),
               @message = ERROR_MESSAGE(), 
               @xstate = XACT_STATE();
		PRINT @message		
        IF @xstate = -1
            ROLLBACK TRANSACTION sp_migration_process;
        if @xstate = 1 and @@TRANCOUNT = 0
            ROLLBACK TRANSACTION sp_migration_process;	
		END CATCH;
		IF @@TRANCOUNT > 0
		COMMIT TRAN sp_migration_process;
	
	UPDATE MigrationLogs
	SET Details = @message
	WHERE IdMigration = @id_migration	
	DROP TABLE TmpResults
	--SELECT @nb_treated AS nb_treated, @nb_added_total as nb_added_total, @nb_updated_total as nb_updated_total, @nb_errors_total as nb_errors_total
	--	,@details_error as details_error,@id_spider_name as id_spider_name, @id_migration_type as id_migration_type
	 
END














GO
