SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TranslationsDetails] (
		[IdTranslationDetails]     [int] IDENTITY(1, 1) NOT NULL,
		[FKIdProduct]              [int] NOT NULL,
		[FKIdLanguage]             [int] NOT NULL,
		[Translation]              [nvarchar](max) COLLATE Latin1_General_CI_AS NOT NULL,
		CONSTRAINT [PK_TranslationsDetails]
		PRIMARY KEY
		CLUSTERED
		([IdTranslationDetails])
	ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[TranslationsDetails]
	WITH CHECK
	ADD CONSTRAINT [FK_TranslationsDetails_Language]
	FOREIGN KEY ([FKIdLanguage]) REFERENCES [dbo].[Language] ([IdLanguage])
ALTER TABLE [dbo].[TranslationsDetails]
	CHECK CONSTRAINT [FK_TranslationsDetails_Language]

GO
ALTER TABLE [dbo].[TranslationsDetails]
	WITH CHECK
	ADD CONSTRAINT [FK_TranslationsDetails_Product]
	FOREIGN KEY ([FKIdProduct]) REFERENCES [dbo].[Product] ([IdProduct])
ALTER TABLE [dbo].[TranslationsDetails]
	CHECK CONSTRAINT [FK_TranslationsDetails_Product]

GO
ALTER TABLE [dbo].[TranslationsDetails] SET (LOCK_ESCALATION = TABLE)
GO
