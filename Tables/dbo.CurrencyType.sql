SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CurrencyType] (
		[IdCurrency]     [int] NOT NULL,
		[Name]           [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[ISOCode]        [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,

) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CurrencyType] SET (LOCK_ESCALATION = TABLE)
GO
