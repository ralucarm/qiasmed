SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CountryTranslations] (
		[IdCountryTranslations]     [int] IDENTITY(1, 1) NOT NULL,
		[FkIdCountry]               [int] NULL,
		[Name]                      [varchar](255) COLLATE Latin1_General_CI_AS NULL,
		[IdLanguage]                [int] NULL,

) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CountryTranslations] SET (LOCK_ESCALATION = TABLE)
GO
