SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Category_Producer] (
		[FKIdCategory]     [int] NOT NULL,
		[FKIdProducer]     [int] NOT NULL,

) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Category_Producer] SET (LOCK_ESCALATION = TABLE)
GO
