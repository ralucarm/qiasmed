SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Category_Supplier] (
		[FKIdCategory]     [int] NOT NULL,
		[FKIdProducer]     [int] NOT NULL,
		CONSTRAINT [PK_Category_Brand]
		PRIMARY KEY
		CLUSTERED
		([FKIdCategory], [FKIdProducer])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Category_Supplier]
	WITH CHECK
	ADD CONSTRAINT [FK_Category_Supplier_Category]
	FOREIGN KEY ([FKIdCategory]) REFERENCES [dbo].[Category] ([IdCategory])
ALTER TABLE [dbo].[Category_Supplier]
	CHECK CONSTRAINT [FK_Category_Supplier_Category]

GO
ALTER TABLE [dbo].[Category_Supplier] SET (LOCK_ESCALATION = TABLE)
GO
