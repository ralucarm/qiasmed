SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[User_Role] (
		[FKIdUser]     [int] NOT NULL,
		[FKIdRole]     [int] NOT NULL,
		CONSTRAINT [PK_User_Role]
		PRIMARY KEY
		CLUSTERED
		([FKIdUser], [FKIdRole])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[User_Role]
	WITH CHECK
	ADD CONSTRAINT [FK_User_Role_Role]
	FOREIGN KEY ([FKIdRole]) REFERENCES [dbo].[Role] ([IdRole])
ALTER TABLE [dbo].[User_Role]
	CHECK CONSTRAINT [FK_User_Role_Role]

GO
ALTER TABLE [dbo].[User_Role]
	WITH CHECK
	ADD CONSTRAINT [FK_User_Role_User]
	FOREIGN KEY ([FKIdUser]) REFERENCES [dbo].[User] ([IdUser])
ALTER TABLE [dbo].[User_Role]
	CHECK CONSTRAINT [FK_User_Role_User]

GO
ALTER TABLE [dbo].[User_Role] SET (LOCK_ESCALATION = TABLE)
GO
