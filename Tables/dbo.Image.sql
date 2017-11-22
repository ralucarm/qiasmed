SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Image] (
		[IdImage]         [int] IDENTITY(1, 1) NOT NULL,
		[FKIdProduct]     [int] NULL,
		[Path]            [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[ImageName]       [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		CONSTRAINT [PK_Image]
		PRIMARY KEY
		CLUSTERED
		([IdImage])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Image] SET (LOCK_ESCALATION = TABLE)
GO
