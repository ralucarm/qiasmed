SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Category] (
		[IdCategory]             [int] IDENTITY(1, 1) NOT NULL,
		[FkIdParentCategory]     [int] NULL,
		[Name]                   [nvarchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		CONSTRAINT [PK_Category]
		PRIMARY KEY
		CLUSTERED
		([IdCategory])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Category] SET (LOCK_ESCALATION = TABLE)
GO
