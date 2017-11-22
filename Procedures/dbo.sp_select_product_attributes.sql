SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_select_product_attributes] 
			 @category varchar(255)
	,@unit_type varchar(255)
		,@measurement_unit varchar(255)
AS
BEGIN
			SET NOCOUNT ON;

    	DECLARE @id_category int	
		,@id_unit_type int
				,@id_measurement_unit int
		,@nb_errors int
		,@details_error varchar(2000) = ''
		,@info_returned varchar(2000) = ''
		,@cat_added bit = 0
		,@unit_type_added bit = 0
				,@measurement_unit_added bit = 0
	BEGIN
		IF (ISNULL(@category, '') = '') OR ([dbo].[CleanField](@category) = '-')
		BEGIN
			SET @nb_errors  = @nb_errors + 1
			SET @details_error = @details_error + 'Error: Category ' + @category + ' is NULL or Empty String or not provided' + CHAR(10) + CHAR(13)
		END
		ELSE
		BEGIN
			IF NOT EXISTS (SELECT * FROM Category WHERE Name = [dbo].[CleanField](@category) )
			BEGIN
				INSERT INTO Category(Name) VALUES ([dbo].[CleanField](@category))
				SET @info_returned = @info_returned + 'New Category Added to the table [dbo].[Category]: ' + @category + ' One actions required:' +  + CHAR(10) + CHAR(13)
				SET @info_returned = @info_returned + ' 1.Validate the new Category added' + CHAR(10) + CHAR(13)
				SET @info_returned = @info_returned + ' --------------------------------------------------------------------------------' + CHAR(10) + CHAR(13)
				SET @cat_added = 1
			END
			SET @id_category = (SELECT IdCategory FROM Category WHERE Name = [dbo].[CleanField](@category))
		END

		IF (ISNULL(@unit_type, '') = '') OR ([dbo].[CleanField](@unit_type) = '-')
		BEGIN
			SET @nb_errors  = @nb_errors + 1
			SET @details_error = @details_error + 'Error: Unit Type ' + @unit_type + ' is NULL or Empty String or not provided' + CHAR(10) + CHAR(13)
		END
		ELSE
		BEGIN
			IF NOT EXISTS (SELECT * FROM UnitType WHERE Name = [dbo].[CleanField](@unit_type) )
			BEGIN
				INSERT INTO UnitType(Name) VALUES ([dbo].[CleanField](@unit_type))
				SET @info_returned = @info_returned + 'New UnitType Added to the table [dbo].[UnitType]: ' + @unit_type + ' One actions required:' +  + CHAR(10) + CHAR(13)
				SET @info_returned = @info_returned + ' 1.Validate the new UnitType added' + CHAR(10) + CHAR(13)
				SET @info_returned = @info_returned + ' --------------------------------------------------------------------------------' + CHAR(10) + CHAR(13)
				SET @unit_type_added = 1
			END
			SET @id_unit_type = (SELECT IdUnitType FROM UnitType WHERE Name = [dbo].[CleanField](@unit_type))
		END

		IF (ISNULL(@measurement_unit, '') = '') OR ([dbo].[CleanField](@measurement_unit) = '-')
		BEGIN
			SET @nb_errors  = @nb_errors + 1
			SET @details_error = @details_error + 'Error: Unit Measurement ' + @measurement_unit + ' is NULL or Empty String or not provided' + CHAR(10) + CHAR(13)
		END
		ELSE
		BEGIN
			IF NOT EXISTS (SELECT * FROM UnitMeasurement WHERE Name = [dbo].[CleanField](@measurement_unit) )
			BEGIN
				INSERT INTO UnitMeasurement(Name) VALUES ([dbo].[CleanField](@measurement_unit))
				SET @info_returned = @info_returned + 'New UnitMeasurement Added to the table [dbo].[UnitMeasurement]: ' + @measurement_unit + ' One actions required:' +  + CHAR(10) + CHAR(13)
				SET @info_returned = @info_returned + ' 1.Validate the new UnitMeasurement added' + CHAR(10) + CHAR(13)
				SET @info_returned = @info_returned + ' --------------------------------------------------------------------------------' + CHAR(10) + CHAR(13)
				SET @measurement_unit_added = 1
			END
			SET @id_measurement_unit = (SELECT IdUnitMeasurement FROM UnitMeasurement WHERE Name = [dbo].[CleanField](@measurement_unit))
		END

		SELECT @id_category AS id_category, @id_unit_type AS id_unit_type, @id_measurement_unit as id_measurement_unit
			, @nb_errors as nb_errors, @details_error as details_error, @info_returned as info_returned
			, @cat_added AS cat_added, @unit_type_added AS unit_type_added
			, @measurement_unit_added AS measurement_unit_added
	END
								
END





GO
