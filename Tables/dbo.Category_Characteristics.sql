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

) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Category_Characteristics] SET (LOCK_ESCALATION = TABLE)
GO
