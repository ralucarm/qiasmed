SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_finalize_import]
	-- Add the parameters for the stored procedure here
	@id_migration int = 2
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @details_error varchar(max) = ''
		,@nb_categories int = 0
		,@categories varchar(2000) = ''
		,@nb_type_units int = 0
		,@type_units varchar(2000) = ''
		,@nb_packing_mode int = 0
		,@packing_mode varchar(2000) = ''
		,@nb_measurements_units int = 0
		,@measurement_units varchar(2000) = ''
		,@nb_errors int = 0
		,@errors varchar(2000) = ''
		,@nb_products_treated int = 0
		,@nb_products_added int = 0
		,@nb_products_updated int = 0
		,@nb_products_deleted int = 0

	CREATE TABLE #tmp_categories (IdCategory int, Name varchar(500))
	CREATE TABLE #tmp_type_units (IdUnitType int, Name varchar(500))
	CREATE TABLE #tmp_packing_mode (IdPackingMode int, Name varchar(500))
	CREATE TABLE #tmp_measurement_units (IdMeasurementUnit int, Name varchar(500))

	SELECT @nb_products_treated = NBProductsTreated, @nb_products_added = NbProductsAdded, @nb_products_updated = NbProductsUpdated, @nb_errors = NbErrors
	FROM MigrationLogs
	WHERE IdMigration = @id_migration

	IF (SELECT COUNT(*) FROM MigrationLogsPerProduct WHERE IdMigration = @id_migration) = 0 
		AND (SELECT COUNT(*) FROM MigrationProductUntreated WHERE FkIdMigration = @id_migration) = 0
		AND (SELECT COUNT(*) FROM MigrationLogs WHERE IdMigration = 8 and FkIdParentMigration IS NOT NULL) = 0
	BEGIN
		SET @details_error = @details_error + 'Error Migration -> No product Inserted; Details on the error could not be provided' + CHAR(10) + CHAR(13)
	END
	IF (SELECT COUNT(*) FROM MigrationLogsPerProduct WHERE IdMigration = @id_migration) = 0 
		AND (SELECT COUNT(*) FROM MigrationProductUntreated WHERE FkIdMigration = @id_migration) = 0
		AND (SELECT COUNT(*) FROM MigrationLogs WHERE IdMigration = 8 and FkIdParentMigration IS NOT NULL) > 0
	BEGIN
		SET @details_error = @details_error + 'No products with error to be treated in the Retreatment Process' + CHAR(10) + CHAR(13)
	END
	ELSE
	BEGIN
		INSERT INTO #tmp_categories (IdCategory, Name)
		SELECT d.IdCategory, d.Name
		FROM MigrationLogsPerProduct m
		INNER JOIN Category d ON m.IdCategoryAdded = d.IdCategory
		WHERE m.IdMigration = @id_migration
		GROUP BY d.IdCategory, d.Name
		SET @nb_categories = (SELECT COUNT(IdCategory) FROM #tmp_categories)
		SELECT @categories = COALESCE(@categories + ', ', '') + Name FROM #tmp_categories
		SET @categories = (CASE WHEN @categories LIKE ',%' THEN RIGHT(@categories,LEN(@categories)-1) ELSE @categories END)
		
		INSERT INTO #tmp_type_units (IdUnitType, Name)
		SELECT b.IdUnitType, b.Name
		FROM MigrationLogsPerProduct m
		INNER JOIN UnitType b ON m.IdTypeUnitAdded = b.IdUnitType
		WHERE m.IdMigration = @id_migration
		GROUP BY b.IdUnitType, b.Name
		SET @nb_type_units = (SELECT COUNT(IdUnitType) FROM #tmp_type_units)
		SELECT @type_units = COALESCE(@type_units + ', ', '') + Name FROM #tmp_type_units
		SET @type_units = (CASE WHEN @type_units LIKE ',%' THEN RIGHT(@type_units,LEN(@type_units)-1) ELSE @type_units END)

		INSERT INTO #tmp_packing_mode (IdPackingMode, Name)
		SELECT d.IdPackingMode, d.Label
		FROM MigrationLogsPerProduct m
		INNER JOIN PackingMode d ON m.IdPackingModeAdded = d.IdPackingMode
		WHERE m.IdMigration = @id_migration
		GROUP BY d.IdPackingMode, d.Label
		SET @nb_packing_mode = (SELECT COUNT(IdPackingMode) FROM #tmp_packing_mode)
		SELECT @packing_mode = COALESCE(@packing_mode + ', ', '') + Name FROM #tmp_packing_mode
		SET @packing_mode = (CASE WHEN @packing_mode LIKE ',%' THEN RIGHT(@packing_mode,LEN(@packing_mode)-1) ELSE @packing_mode END)
		
		INSERT INTO #tmp_measurement_units (IdMeasurementUnit, Name)
		SELECT b.IdUnitMeasurement, b.Name
		FROM MigrationLogsPerProduct m
		INNER JOIN UnitMeasurement b ON m.IdUnitMeasurementAdded = b.IdUnitMeasurement
		WHERE m.IdMigration = @id_migration
		GROUP BY b.IdUnitMeasurement, b.Name
		SET @nb_measurements_units = (SELECT COUNT(IdMeasurementUnit) FROM #tmp_measurement_units)
		SELECT @measurement_units = COALESCE(@measurement_units + ', ', '') + Name FROM #tmp_measurement_units
		SET @measurement_units = (CASE WHEN @measurement_units LIKE ',%' THEN RIGHT(@measurement_units,LEN(@measurement_units)-1) ELSE @measurement_units END)

		SELECT @errors = COALESCE(@errors + CHAR(10) + CHAR(13), '') + details_error 
		FROM MigrationProductUntreated where FkIdMigration = @id_migration AND ISNULL(details_error,'') <> '' 
		GROUP BY details_error
		
		IF (ISNULL(@nb_products_treated, 0) <> 0)
		BEGIN
			SET @details_error = @details_error + 'Number of Products treated: ' + CAST(@nb_products_treated AS varchar(30)) + CHAR(10) + CHAR(13)
		END
		IF (ISNULL(@nb_products_added, 0) <> 0)
		BEGIN
			SET @details_error = @details_error + 'Number of Products added: ' + CAST(@nb_products_added AS varchar(30)) + CHAR(10) + CHAR(13)
		END
		IF (ISNULL(@nb_products_updated, 0) <> 0)
		BEGIN
			SET @details_error = @details_error + 'Number of Products updated: ' + CAST(@nb_products_updated AS varchar(30)) + CHAR(10) + CHAR(13)		
		END
		IF (ISNULL(@nb_products_deleted, 0) <> 0)
		BEGIN
			SET @details_error = @details_error + 'Number of Products deleted: ' + CAST(@nb_products_deleted AS varchar(30)) 
					+ ' -> the products are still stored in the tables, only their status is updated with "Deleted"' + CHAR(10) + CHAR(13)
		END
		IF (ISNULL(@nb_categories, 0) <> 0)
		BEGIN
			SET @details_error = @details_error + 'Number of Categories added: ' + CAST(@nb_categories AS varchar(30)) + CHAR(10) + CHAR(13)
			SET @details_error = @details_error + 'The following Categories have been added: ' + @categories + CHAR(10) + CHAR(13)
		END
		ELSE
		BEGIN
			SET @details_error = @details_error + 'No Categories added ' + CHAR(10) + CHAR(13)
		END
		IF (ISNULL(@nb_type_units, 0) <> 0)
		BEGIN
			SET @details_error = @details_error + 'Number of Type Units added: ' + CAST(@nb_type_units AS varchar(30)) + CHAR(10) + CHAR(13)
			SET @details_error = @details_error + 'The following Type Units have been added: ' + @type_units + CHAR(10) + CHAR(13)
		END
		ELSE
		BEGIN
			SET @details_error = @details_error + 'No Type Units added ' + CHAR(10) + CHAR(13)
		END

		IF (ISNULL(@nb_packing_mode, 0) <> 0)
		BEGIN
			SET @details_error = @details_error + 'Number of Packing Modes added: ' + CAST(@nb_packing_mode AS varchar(30)) + CHAR(10) + CHAR(13)
			SET @details_error = @details_error + 'The following Packing Modes have been added: ' + @packing_mode + CHAR(10) + CHAR(13)
		END
		ELSE
		BEGIN
			SET @details_error = @details_error + 'No Packing Modes added ' + CHAR(10) + CHAR(13)
		END
		IF (ISNULL(@nb_measurements_units, 0) <> 0)
		BEGIN
			SET @details_error = @details_error + 'Number of Measurement Units added: ' + CAST(@nb_measurements_units AS varchar(30)) + CHAR(10) + CHAR(13)
			SET @details_error = @details_error + 'The following Measurement Units have been added: ' + @measurement_units + CHAR(10) + CHAR(13)
		END
		ELSE
		BEGIN
			SET @details_error = @details_error + 'No Measurement Units added ' + CHAR(10) + CHAR(13)
		END
		IF (ISNULL(@nb_errors, 0) <> 0)
		BEGIN
			SET @details_error = @details_error + 'Number of Errors in the treatment: ' + CAST(@nb_errors AS varchar(30)) + CHAR(10) + CHAR(13)		
			SET @details_error = @details_error + 'The following Errors occured: ' + @errors + CHAR(10) + CHAR(13)
		END
		ELSE
		BEGIN
			SET @details_error = @details_error + 'No Errors in the Migration ' + CHAR(10) + CHAR(13)
		END
	END

	--select len(@details_error), DATALENGTH(@details_error), @details_error

	UPDATE MigrationLogs
	SET Details = @details_error
	WHERE IdMigration = @id_migration
END








GO
