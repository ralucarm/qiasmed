SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MigrationProductUntreated] (
		[id]                   [int] IDENTITY(1, 1) NOT NULL,
		[category]             [varchar](100) COLLATE Latin1_General_CI_AS NULL,
		[producer]             [varchar](50) COLLATE Latin1_General_CI_AS NOT NULL,
		[product_name]         [varchar](100) COLLATE Latin1_General_CI_AS NOT NULL,
		[product_code]         [varchar](70) COLLATE Latin1_General_CI_AS NULL,
		[price_by_unit]        [decimal](18, 0) NULL,
		[unit_type]            [varchar](50) COLLATE Latin1_General_CI_AS NULL,
		[unit_pack]            [int] NULL,
		[measurement_unit]     [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[description]          [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
		[currency]             [nvarchar](10) COLLATE Latin1_General_CI_AS NULL,
		[FkIdMigration]        [int] NULL,
		[details_error]        [varchar](max) COLLATE Latin1_General_CI_AS NULL,
		[packaging]            [varchar](150) COLLATE Latin1_General_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[MigrationProductUntreated]
	WITH CHECK
	ADD CONSTRAINT [FK_MigrationProductUntreated_MigrationLogs]
	FOREIGN KEY ([FkIdMigration]) REFERENCES [dbo].[MigrationLogs] ([IdMigration])
ALTER TABLE [dbo].[MigrationProductUntreated]
	CHECK CONSTRAINT [FK_MigrationProductUntreated_MigrationLogs]

GO
ALTER TABLE [dbo].[MigrationProductUntreated] SET (LOCK_ESCALATION = TABLE)
GO
