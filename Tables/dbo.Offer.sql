SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Offer] (
		[IdOffer]            [int] IDENTITY(1, 1) NOT NULL,
		[FKIdUser]           [int] NOT NULL,
		[FKIdCategory]       [int] NULL,
		[DateCreated]        [datetime] NOT NULL,
		[ClientFullName]     [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[ClientCompany]      [nchar](10) COLLATE Latin1_General_CI_AS NULL,
		[ClientEmail]        [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[IsOpen]             [bit] NOT NULL,
		[OfferNumber]        [uniqueidentifier] NOT NULL,

) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Offer] SET (LOCK_ESCALATION = TABLE)
GO
