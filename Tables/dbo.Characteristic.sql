SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Characteristic] (
		[IdCharacteristic]        [int] IDENTITY(1, 1) NOT NULL,
		[Name]                    [nvarchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[FKIdUnitMeasurement]     [int] NULL,
		[FKIdType]                [int] NOT NULL,
		[DSCode]                  [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,

) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Characteristic] SET (LOCK_ESCALATION = TABLE)
GO
