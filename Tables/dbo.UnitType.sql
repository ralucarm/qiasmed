SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UnitType] (
		[IdUnitType]     [int] IDENTITY(1, 1) NOT NULL,
		[Name]           [varchar](150) COLLATE Latin1_General_CI_AS NULL,

) ON [PRIMARY]
GO
ALTER TABLE [dbo].[UnitType] SET (LOCK_ESCALATION = TABLE)
GO
