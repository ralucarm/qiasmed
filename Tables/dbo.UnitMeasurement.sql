SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UnitMeasurement] (
		[IdUnitMeasurement]     [int] IDENTITY(1, 1) NOT NULL,
		[Name]                  [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,

) ON [PRIMARY]
GO
ALTER TABLE [dbo].[UnitMeasurement] SET (LOCK_ESCALATION = TABLE)
GO
