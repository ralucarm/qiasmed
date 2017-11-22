SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MigrationLogsPerProduct] (
		[IdMigration]                   [int] NOT NULL,
		[IdProduct]                     [int] NOT NULL,
		[Details]                       [varchar](2000) COLLATE Latin1_General_CI_AS NULL,
		[IdCategoryAdded]               [int] NULL,
		[IdTypeUnitAdded]               [int] NULL,
		[IdPackingModeAdded]            [int] NULL,
		[IdUnitMeasurementAdded]        [int] NULL,
		[StatusMigrationProduct]        [varchar](255) COLLATE Latin1_General_CI_AS NULL,
		[IdMigrationLogsPerProduct]     [int] IDENTITY(1, 1) NOT NULL,

) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MigrationLogsPerProduct] SET (LOCK_ESCALATION = TABLE)
GO
