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
		CONSTRAINT [PK_TransportCharacteristic]
		PRIMARY KEY
		CLUSTERED
		([IdCharacteristic])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Characteristic]
	WITH CHECK
	ADD CONSTRAINT [FK_Characteristic_CharacteristicType]
	FOREIGN KEY ([FKIdType]) REFERENCES [dbo].[CharacteristicType] ([IdCharacteristicType])
ALTER TABLE [dbo].[Characteristic]
	CHECK CONSTRAINT [FK_Characteristic_CharacteristicType]

GO
ALTER TABLE [dbo].[Characteristic]
	WITH CHECK
	ADD CONSTRAINT [FK_TransportCharacteristic_UnitMeasurement]
	FOREIGN KEY ([FKIdUnitMeasurement]) REFERENCES [dbo].[UnitMeasurement] ([IdUnitMeasurement])
ALTER TABLE [dbo].[Characteristic]
	CHECK CONSTRAINT [FK_TransportCharacteristic_UnitMeasurement]

GO
ALTER TABLE [dbo].[Characteristic] SET (LOCK_ESCALATION = TABLE)
GO
