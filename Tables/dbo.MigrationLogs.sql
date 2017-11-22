SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MigrationLogs] (
		[IdMigration]              [int] IDENTITY(1, 1) NOT NULL,
		[DateMigration]            [datetime] NULL,
		[NBProductsTreated]        [int] NULL,
		[NbProductsAdded]          [int] NULL,
		[NbProductsUpdated]        [int] NULL,
		[NbErrors]                 [int] NULL,
		[Details]                  [varchar](2000) COLLATE Latin1_General_CI_AS NULL,
		[FKIdSupplier]             [int] NULL,
		[DateRetreated]            [datetime] NULL,
		[FkIdParentMigration]      [int] NULL,
		[YearMigration]            [int] NULL,
		[Discount]                 [int] NULL,
		[DiscountIsPercentage]     [bit] NULL,
		[FkIdCurrency]             [int] NULL,
		[MonthMigration]           [varchar](100) COLLATE Latin1_General_CI_AS NULL,
		[FkIdCountrySupplier]      [int] NULL,
		[FkIdUser]                 [int] NULL,

) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MigrationLogs] SET (LOCK_ESCALATION = TABLE)
GO
