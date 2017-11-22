SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Category_Characteristics] (
		[FKIdCharacteristic]     [int] NOT NULL,
		[FKIdCategory]           [int] NOT NULL,
		[MinValue]               [decimal](8, 2) NOT NULL,
		[MaxValue]               [decimal](8, 2) NOT NULL,
		[Incremental]            [decimal](8, 2) NOT NULL,
		CONSTRAINT [PK_Category_Characteristics]
		PRIMARY KEY
		CLUSTERED
		([FKIdCharacteristic], [FKIdCategory])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Category_Characteristics]
	ADD
	CONSTRAINT [DF_Category_Characteristics_MaxValue]
	DEFAULT ((0)) FOR [MaxValue]
GO
ALTER TABLE [dbo].[Category_Characteristics]
	ADD
	CONSTRAINT [DF_Category_Characteristics_MinValue]
	DEFAULT ((0)) FOR [MinValue]
GO
ALTER TABLE [dbo].[Category_Characteristics]
	WITH CHECK
	ADD CONSTRAINT [FK_Category_Characteristics_Category]
	FOREIGN KEY ([FKIdCategory]) REFERENCES [dbo].[Category] ([IdCategory])
ALTER TABLE [dbo].[Category_Characteristics]
	CHECK CONSTRAINT [FK_Category_Characteristics_Category]

GO
ALTER TABLE [dbo].[Category_Characteristics]
	WITH CHECK
	ADD CONSTRAINT [FK_Category_Characteristics_Characteristics]
	FOREIGN KEY ([FKIdCharacteristic]) REFERENCES [dbo].[Characteristic] ([IdCharacteristic])
ALTER TABLE [dbo].[Category_Characteristics]
	CHECK CONSTRAINT [FK_Category_Characteristics_Characteristics]

GO
ALTER TABLE [dbo].[Category_Characteristics] SET (LOCK_ESCALATION = TABLE)
GO
