SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TranslationsDetails] (
		[IdTranslationDetails]     [int] IDENTITY(1, 1) NOT NULL,
		[FKIdProduct]              [int] NOT NULL,
		[FKIdLanguage]             [int] NOT NULL,
		[Translation]              [nvarchar](max) COLLATE Latin1_General_CI_AS NOT NULL,

) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[TranslationsDetails] SET (LOCK_ESCALATION = TABLE)
GO
