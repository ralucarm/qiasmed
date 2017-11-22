SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Supplier] (
		[IdSupplier]      [int] IDENTITY(1, 1) NOT NULL,
		[Name]            [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[Description]     [nvarchar](max) COLLATE Latin1_General_CI_AS NOT NULL,
		CONSTRAINT [PK_Supplier]
		PRIMARY KEY
		CLUSTERED
		([IdSupplier])
	ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Supplier] SET (LOCK_ESCALATION = TABLE)
GO
