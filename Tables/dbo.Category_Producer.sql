SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Category_Producer] (
		[FKIdCategory]     [int] NOT NULL,
		[FKIdProducer]     [int] NOT NULL,
		CONSTRAINT [PK_Category_Brand]
		PRIMARY KEY
		CLUSTERED
		([FKIdCategory], [FKIdProducer])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Category_Producer]
	WITH CHECK
	ADD CONSTRAINT [FK_Category_Producer_Category]
	FOREIGN KEY ([FKIdCategory]) REFERENCES [dbo].[Category] ([IdCategory])
ALTER TABLE [dbo].[Category_Producer]
	CHECK CONSTRAINT [FK_Category_Producer_Category]

GO
ALTER TABLE [dbo].[Category_Producer]
	WITH CHECK
	ADD CONSTRAINT [FK_Category_Producer_Producer]
	FOREIGN KEY ([FKIdProducer]) REFERENCES [dbo].[Producer] ([IdProducer])
ALTER TABLE [dbo].[Category_Producer]
	CHECK CONSTRAINT [FK_Category_Producer_Producer]

GO
ALTER TABLE [dbo].[Category_Producer] SET (LOCK_ESCALATION = TABLE)
GO
