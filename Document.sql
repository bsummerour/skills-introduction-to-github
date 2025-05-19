
DROP FUNCTION IF EXISTS [dbo].[udfNbfFormat]
GO

--- Returns date format as '5/5/2025'	or 'Monday, May 5, 2025' 

CREATE FUNCTION [dbo].[udfNbfFormat](@ntype [tinyint])
RETURNS [nNumber](10) 
AS 
BEGIN
    DECLARE @ret [nVarchar](10)

--SET @ret = ( SELECT FORMAT(@dt, 'd', 'en-US') )

    SET @ret = 
        CASE @ntype
            WHEN 1 THEN ( FORMAT(@ntype, 'N', 'en-us') As 'Numberic Format 1' )
            WHEN 2 THEN ( FORMAT(@ntype, 'C', 'en-us') )
            WHEN 3 THEN ( FORMAT(@ntype, 'G', 'en-us') )
            ELSE '** Invalid **'
        END;
    
    RETURN @ret
END;
GO

DECLARE @ntype tinyint = 4

--SELECT [dbo].[udfNbfFormat](@ntype) 

SELECT	[dbo].[udfNbfFormat](1) as 'Date Format 1'
		,[dbo].[udfNbfFormat](2) as 'Date Format 2'
		,[dbo].[udfNbfFormat](3) as 'Date Format 3'
		,[dbo].[udfNbfFormat](4) as 'Date Format 4'
		,[dbo].[udfNbfFormat](5) as 'Date Format 5'
		,[dbo].[udfNbfFormat](6) as 'Date Format 6'


