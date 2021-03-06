SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User] (
		[IdUser]          [int] IDENTITY(1, 1) NOT NULL,
		[Username]        [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[Password]        [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[Firstname]       [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[Lastname]        [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[PhoneNumber]     [nvarchar](50) COLLATE Latin1_General_CI_AS NULL,
		[IsDeleted]       [bit] NULL,
		CONSTRAINT [PK_User]
		PRIMARY KEY
		CLUSTERED
		([IdUser])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[User]
	ADD
	CONSTRAINT [DF_User_IsDeleted]
	DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[User] SET (LOCK_ESCALATION = TABLE)
GO
