SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PackingMode] (
		[IdPackingMode]     [int] IDENTITY(1, 1) NOT NULL,
		[Label]             [varchar](150) COLLATE Latin1_General_CI_AS NULL,
		[Description]       [varchar](500) COLLATE Latin1_General_CI_AS NULL,
		[FkIdProduct]       [int] NULL,

) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PackingMode] SET (LOCK_ESCALATION = TABLE)
GO
