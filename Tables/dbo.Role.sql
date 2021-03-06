SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Role] (
		[IdRole]     [int] IDENTITY(1, 1) NOT NULL,
		[Name]       [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		CONSTRAINT [PK_Role]
		PRIMARY KEY
		CLUSTERED
		([IdRole])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Role] SET (LOCK_ESCALATION = TABLE)
GO
