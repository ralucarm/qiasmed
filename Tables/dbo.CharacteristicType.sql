SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CharacteristicType] (
		[IdCharacteristicType]     [int] IDENTITY(1, 1) NOT NULL,
		[Name]                     [nvarchar](250) COLLATE Latin1_General_CI_AS NOT NULL,
		CONSTRAINT [PK_CharacteristicType]
		PRIMARY KEY
		CLUSTERED
		([IdCharacteristicType])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CharacteristicType] SET (LOCK_ESCALATION = TABLE)
GO
