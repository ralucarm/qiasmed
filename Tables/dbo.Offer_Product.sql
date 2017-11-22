SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Offer_Product] (
		[FKIdOffer]       [int] NOT NULL,
		[FKIdProduct]     [int] NOT NULL,
		CONSTRAINT [PK_Offer_Product]
		PRIMARY KEY
		CLUSTERED
		([FKIdOffer], [FKIdProduct])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Offer_Product]
	WITH CHECK
	ADD CONSTRAINT [FK_Offer_Product_Offer]
	FOREIGN KEY ([FKIdOffer]) REFERENCES [dbo].[Offer] ([IdOffer])
ALTER TABLE [dbo].[Offer_Product]
	CHECK CONSTRAINT [FK_Offer_Product_Offer]

GO
ALTER TABLE [dbo].[Offer_Product] SET (LOCK_ESCALATION = TABLE)
GO
