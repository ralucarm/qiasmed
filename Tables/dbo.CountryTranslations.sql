SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CountryTranslations] (
		[IdCountryTranslations]     [int] IDENTITY(1, 1) NOT NULL,
		[FkIdCountry]               [int] NULL,
		[Name]                      [varchar](255) COLLATE Latin1_General_CI_AS NULL,
		[IdLanguage]                [int] NULL,
		CONSTRAINT [PK__CountryT__B249D512617F36B6]
		PRIMARY KEY
		CLUSTERED
		([IdCountryTranslations])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CountryTranslations]
	WITH CHECK
	ADD CONSTRAINT [FK_CountryTranslations_Country]
	FOREIGN KEY ([FkIdCountry]) REFERENCES [dbo].[Country] ([IdCountry])
ALTER TABLE [dbo].[CountryTranslations]
	CHECK CONSTRAINT [FK_CountryTranslations_Country]

GO
ALTER TABLE [dbo].[CountryTranslations]
	WITH CHECK
	ADD CONSTRAINT [FK_CountryTranslations_Language]
	FOREIGN KEY ([IdLanguage]) REFERENCES [dbo].[Language] ([IdLanguage])
ALTER TABLE [dbo].[CountryTranslations]
	CHECK CONSTRAINT [FK_CountryTranslations_Language]

GO
ALTER TABLE [dbo].[CountryTranslations] SET (LOCK_ESCALATION = TABLE)
GO
