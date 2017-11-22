SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product] (
		[IdProduct]               [int] IDENTITY(1, 1) NOT NULL,
		[FKIdSupplier]            [int] NOT NULL,
		[FKIdCategory]            [int] NOT NULL,
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
		CONSTRAINT [PK_Product]
		PRIMARY KEY
		CLUSTERED
		([IdProduct])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Product]
	ADD
	CONSTRAINT [DF_Product_IsVisible]
	DEFAULT ((1)) FOR [IsVisible]
GO
ALTER TABLE [dbo].[Product]
	WITH CHECK
	ADD CONSTRAINT [FK_Product_Category]
	FOREIGN KEY ([FKIdCategory]) REFERENCES [dbo].[Category] ([IdCategory])
ALTER TABLE [dbo].[Product]
	CHECK CONSTRAINT [FK_Product_Category]

GO
ALTER TABLE [dbo].[Product]
	WITH CHECK
	ADD CONSTRAINT [FK_Product_Currency]
	FOREIGN KEY ([FKIdCurrency]) REFERENCES [dbo].[Currency] ([IdCurrency])
ALTER TABLE [dbo].[Product]
	CHECK CONSTRAINT [FK_Product_Currency]

GO
ALTER TABLE [dbo].[Product]
	WITH CHECK
	ADD CONSTRAINT [FK_Product_Supplier]
	FOREIGN KEY ([FKIdSupplier]) REFERENCES [dbo].[Supplier] ([IdSupplier])
ALTER TABLE [dbo].[Product]
	CHECK CONSTRAINT [FK_Product_Supplier]

GO
ALTER TABLE [dbo].[Product]
	WITH CHECK
	ADD CONSTRAINT [FK_Product_TypeUnit]
	FOREIGN KEY ([FkIdUnitType]) REFERENCES [dbo].[UnitType] ([IdUnitType])
ALTER TABLE [dbo].[Product]
	CHECK CONSTRAINT [FK_Product_TypeUnit]

GO
ALTER TABLE [dbo].[Product]
	WITH CHECK
	ADD CONSTRAINT [FK_Product_UnitMeasurement]
	FOREIGN KEY ([FkIdMeasurementUnit]) REFERENCES [dbo].[UnitMeasurement] ([IdUnitMeasurement])
ALTER TABLE [dbo].[Product]
	CHECK CONSTRAINT [FK_Product_UnitMeasurement]

GO
ALTER TABLE [dbo].[Product] SET (LOCK_ESCALATION = TABLE)
GO
