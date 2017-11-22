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
		CONSTRAINT [PK_ImportedDocument]
		PRIMARY KEY
		CLUSTERED
		([IdDocument])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ImportedDocument]
	WITH CHECK
	ADD CONSTRAINT [FK_ImportedDocument_MigrationLogs]
	FOREIGN KEY ([FkMigrationId]) REFERENCES [dbo].[MigrationLogs] ([IdMigration])
ALTER TABLE [dbo].[ImportedDocument]
	CHECK CONSTRAINT [FK_ImportedDocument_MigrationLogs]

GO
ALTER TABLE [dbo].[ImportedDocument] SET (LOCK_ESCALATION = TABLE)
GO
