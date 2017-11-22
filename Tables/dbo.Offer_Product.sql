SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Offer_Product] (
		[FKIdOffer]       [int] NOT NULL,
		[FKIdProduct]     [int] NOT NULL,

) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Offer_Product] SET (LOCK_ESCALATION = TABLE)
GO
