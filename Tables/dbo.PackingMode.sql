SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PackingMode] (
		[IdPackingMode]     [int] IDENTITY(1, 1) NOT NULL,
		[Label]             [varchar](150) COLLATE Latin1_General_CI_AS NULL,
		[Description]       [varchar](500) COLLATE Latin1_General_CI_AS NULL,
		[FkIdProduct]       [int] NULL,
		CONSTRAINT [PK__PackingM__35678B617D8215E3]
		PRIMARY KEY
		CLUSTERED
		([IdPackingMode])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PackingMode]
	WITH CHECK
	ADD CONSTRAINT [FK_PackingMode_Product]
	FOREIGN KEY ([FkIdProduct]) REFERENCES [dbo].[Product] ([IdProduct])
ALTER TABLE [dbo].[PackingMode]
	CHECK CONSTRAINT [FK_PackingMode_Product]

GO
ALTER TABLE [dbo].[PackingMode] SET (LOCK_ESCALATION = TABLE)
GO
