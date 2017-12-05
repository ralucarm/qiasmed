SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MigrationProductUntreated] (
		[id]                   [int] IDENTITY(1, 1) NOT NULL,
		[category]             [varchar](800) COLLATE Latin1_General_CI_AS NULL,
		[producer]             [varchar](500) COLLATE Latin1_General_CI_AS NOT NULL,
		[product_name]         [varchar](800) COLLATE Latin1_General_CI_AS NOT NULL,
		[product_code]         [varchar](270) COLLATE Latin1_General_CI_AS NULL,
		[price_by_unit]        [decimal](18, 0) NULL,
		[unit_type]            [varchar](250) COLLATE Latin1_General_CI_AS NULL,
		[unit_pack]            [int] NULL,
		[measurement_unit]     [nvarchar](250) COLLATE Latin1_General_CI_AS NULL,
		[description]          [nvarchar](max) COLLATE Latin1_General_CI_AS NULL,
		[currency]             [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[FkIdMigration]        [int] NULL,
		[details_error]        [varchar](max) COLLATE Latin1_General_CI_AS NULL,
		[packaging]            [varchar](250) COLLATE Latin1_General_CI_AS NULL
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
