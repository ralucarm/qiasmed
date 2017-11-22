SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ImportedDocument] (
		[IdDocument]              [int] IDENTITY(1, 1) NOT NULL,
		[DocumentInitialName]     [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[DateAdded]               [datetime] NULL,
		[Version]                 [int] NULL,
		[FkMigrationId]           [int] NULL,
		[DocumentSavedName]       [nchar](100) COLLATE Latin1_General_CI_AS NULL,

) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ImportedDocument] SET (LOCK_ESCALATION = TABLE)
GO
