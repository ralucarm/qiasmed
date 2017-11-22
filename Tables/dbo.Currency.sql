SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Currency] (
		[IdCurrency]     [int] IDENTITY(1, 1) NOT NULL,
		[Label]          [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[LabelName]      [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		CONSTRAINT [PK__Currency__9C93E0C9E2F99DCC]
		PRIMARY KEY
		CLUSTERED
		([IdCurrency])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Currency] SET (LOCK_ESCALATION = TABLE)
GO
