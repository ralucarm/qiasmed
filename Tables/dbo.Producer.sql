SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Producer] (
		[IdProducer]      [int] IDENTITY(1, 1) NOT NULL,
		[Name]            [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,
		[Description]     [nvarchar](1024) COLLATE Latin1_General_CI_AS NULL,

) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Producer] SET (LOCK_ESCALATION = TABLE)
GO
