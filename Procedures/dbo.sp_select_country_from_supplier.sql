SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_select_country_from_supplier]
			@supplier varchar(255)
AS
BEGIN
			SET NOCOUNT ON;
	
	CREATE TABLE #tmp_country (country_name VARCHAR(255), IdCountry INT)
	DECLARE @name varchar(255), @id_country INT
	DECLARE cursor_country CURSOR FOR
	SELECT Name, IdCountry FROM Country
	OPEN cursor_country
	FETCH cursor_country INTO @name, @id_country
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @supplier like '%' + @name + '%'
		BEGIN
			INSERT INTO #tmp_country (country_name, IdCountry)
			VALUES (@name, @id_country)
		END
		FETCH cursor_country INTO @name, @id_country
	END
	CLOSE cursor_country
	DEALLOCATE cursor_country

	DECLARE cursor_country CURSOR FOR
	SELECT Name, FkIdCountry FROM CountryTranslations
	OPEN cursor_country
	FETCH cursor_country INTO @name, @id_country
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @supplier like '%' + @name + '%'
		BEGIN
			INSERT INTO #tmp_country (country_name, IdCountry)
			VALUES (@name, @id_country)
		END
		FETCH cursor_country INTO @name, @id_country
	END
	CLOSE cursor_country
	DEALLOCATE cursor_country

	SET @id_country = (SELECT IdCountry FROM #tmp_country)
	DROP TABLE #tmp_country

	select @id_country as IdCountry
END









GO
