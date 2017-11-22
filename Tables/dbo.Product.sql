SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product] (
		[IdProduct]               [int] IDENTITY(1, 1) NOT NULL,
		[FKIdSupplier]            [int] NOT NULL,
		[FKIdCategory]            [int] NOT NULL,
		[FKIdProducer]            [int] NULL,
		[PricePerUnit]            [decimal](8, 2) NULL,
		[UnitsPerPackage]         [decimal](8, 2) NULL,
		[IsVisible]               [bit] NULL,
		[ProductCode]             [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[FkIdUnitType]            [int] NULL,
		[FkIdMeasurementUnit]     [int] NULL,
		[FkIdMigration]           [int] NULL,
		[ProductName]             [varchar](500) COLLATE Latin1_General_CI_AS NULL,
		[DateAdded]               [datetime] NULL,
		[DateUpdated]             [datetime] NULL,
		[DateSold]                [datetime] NULL,
		[Description]             [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[FKIdCurrency]            [int] NULL,

) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Product] SET (LOCK_ESCALATION = TABLE)
GO
