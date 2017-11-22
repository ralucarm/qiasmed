SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create Function [dbo].[CleanField](@Temp VarChar(1000))
Returns VarChar(1000)
AS
Begin

    set @Temp = replace(replace(replace(@Temp,' ','<>'),'><',''),'<>',' ')
    set @Temp = REPLACE(@Temp, NCHAR(0x00A0), '')
	set @Temp = rtrim(ltrim(@Temp))
    Return @Temp
End









GO
