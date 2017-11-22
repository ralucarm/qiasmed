SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Country] (
		[IdCountry]     [int] IDENTITY(1, 1) NOT NULL,
		[Name]          [nvarchar](100) COLLATE Latin1_General_CI_AS NULL,

) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Country] SET (LOCK_ESCALATION = TABLE)
GO
