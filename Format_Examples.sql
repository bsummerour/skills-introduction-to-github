USE [StockInvestDB]
GO

SELECT TOP 100
	   [Symbol]
      ,[TradeDate]
      ,[StockOpen]
      ,[StockHigh]
      ,[StockLow]
      ,FORMAT (StockClose, 'N', 'en-us') AS 'Stock Close'
      ,[Volume]
	  ,FORMAT (Volume, 'N0') AS FormattedNumber
  FROM [dbo].[StageDataLoadHist]
  WHERE TradeDate = '01-21-2025' -- TradeDate = '01-21-2025' AND -- TradeDate <=  '01-21-2025' 
		AND Symbol IN  ('WFC', 
						'BAC',
						'AAPL',
						'JPM',
						'^DJI')
GO


-- The following example returns a simple date formatted for different cultures.
https://learn.microsoft.com/en-us/sql/t-sql/functions/format-transact-sql?view=sql-server-ver16

DECLARE @d AS DATE = GETDATE(); -- '08/09/2024'

SELECT FORMAT(@d, 'd', 'en-US') AS 'US English',
		FORMAT(@d, 'D', 'en-US') AS 'US English';

       --FORMAT(@d, 'd', 'en-gb') AS 'British English',
       --FORMAT(@d, 'd', 'de-de') AS 'German',
       --FORMAT(@d, 'd', 'zh-cn') AS 'Chinese Simplified (PRC)';

SELECT FORMAT(@d, 'D', 'en-US') AS 'US English',
       FORMAT(@d, 'D', 'en-gb') AS 'British English',
       FORMAT(@d, 'D', 'de-de') AS 'German',
       FORMAT(@d, 'D', 'zh-cn') AS 'Chinese Simplified (PRC)';

------------------------------------------------------------------

DECLARE 
    @numr [numeric](5, 2) ,
	@dt date = ('dd/MM/yyyy')

SET @numr =( FORMAT(123456789, '###-##-####') ),
SET DATE = GETDATE();

SELECT FORMAT(@d, 'dd/MM/yyyy', 'en-US') AS 'Date',
       FORMAT(123456789, '###-##-####') AS 'Custom Number',
	   @numr    ;

------------------------------------------------------------------

DROP FUNCTION IF EXISTS [dbo].[udfDateFormat]
GO

--- Returns date format as '5/5/2025'	or 'Monday, May 5, 2025' 

CREATE FUNCTION [dbo].[udfDateFormat](@dtype [tinyint])
RETURNS [nvarchar](25) 
AS 
BEGIN
    DECLARE @ret [nvarchar](25),
			@dt      DATE = GETDATE()

--SET @ret = ( SELECT FORMAT(@dt, 'd', 'en-US') )

    SET @ret = 
        CASE @dtype
            WHEN 1 THEN ( SELECT FORMAT(@dt, 'd', 'en-US') )
            WHEN 2 THEN ( SELECT FORMAT(@dt, 'D', 'en-US') )
            WHEN 3 THEN ( SELECT FORMAT(@dt, 'dd/MM/yyyy', 'en-US') )
            WHEN 4 THEN ( SELECT FORMAT(@dt, 'yyyy-MM-dd', 'en-US') )
            WHEN 5 THEN ( SELECT FORMAT(@dt, 'yyyy-MM', 'en-US') )
            WHEN 6 THEN ( SELECT FORMAT(@dt, 'MM-yyy', 'en-US') )
            ELSE '** Invalid **'
        END;
    
    RETURN @ret
END;
GO

DECLARE @dtype tinyint = 4

--SELECT [dbo].[udfDateFormat](@dtype) 

SELECT	[dbo].[udfDateFormat](1) as 'Date Format 1'
		,[dbo].[udfDateFormat](2) as 'Date Format 2'
		,[dbo].[udfDateFormat](3) as 'Date Format 3'
		,[dbo].[udfDateFormat](4) as 'Date Format 4'
		,[dbo].[udfDateFormat](5) as 'Date Format 5'
		,[dbo].[udfDateFormat](6) as 'Date Format 6'


------------------------------------------------------------------


DROP FUNCTION IF EXISTS [dbo].[udfDateFormat]
GO

--- Returns date format as '5/5/2025'	or 'Monday, May 5, 2025' 

CREATE FUNCTION [dbo].[udfDateFormat](@dtype [tinyint])
RETURNS [nvarchar](25) 
AS 
BEGIN
    DECLARE @ret [nvarchar](25),
			@dt      DATE = GETDATE()

--SET @ret = ( SELECT FORMAT(@dt, 'd', 'en-US') )

    SET @ret = 
        CASE @dtype
            WHEN 1 THEN ( SELECT FORMAT(@dt, 'd', 'en-US') )
            WHEN 2 THEN ( SELECT FORMAT(@dt, 'D', 'en-US') )
            WHEN 3 THEN ( SELECT FORMAT(@dt, 'dd/MM/yyyy', 'en-US') )
            WHEN 4 THEN ( SELECT FORMAT(@dt, 'yyyy-MM-dd', 'en-US') )
            WHEN 5 THEN ( SELECT FORMAT(@dt, 'yyyy-MM', 'en-US') )
            WHEN 6 THEN ( SELECT FORMAT(@dt, 'MM-yyy', 'en-US') )
            ELSE '** Invalid **'
        END;
    
    RETURN @ret
END;
GO

DECLARE @dtype tinyint = 4

--SELECT [dbo].[udfDateFormat](@dtype) 

SELECT	[dbo].[udfDateFormat](1) as 'Date Format 1'
		,[dbo].[udfDateFormat](2) as 'Date Format 2'
		,[dbo].[udfDateFormat](3) as 'Date Format 3'
		,[dbo].[udfDateFormat](4) as 'Date Format 4'
		,[dbo].[udfDateFormat](5) as 'Date Format 5'
		,[dbo].[udfDateFormat](6) as 'Date Format 6'




------------------------------------------------------------------


DROP FUNCTION IF EXISTS [dbo].[udfNbrFormatr]
GO

--- Returns date format as '5/5/2025'	or 'Monday, May 5, 2025' 

CREATE FUNCTION [dbo].[udfNbrFormatr](@ntype [tinyint])
RETURNS varchar(25) 
AS 
BEGIN
    DECLARE @ret varchar(25)

    SET @ret = 
        CASE @ntype
            WHEN 1 THEN ( FORMAT(@ntype, 'N', 'en-us') )  
            WHEN 2 THEN ( FORMAT(@ntype, 'C', 'en-us') )  
            WHEN 3 THEN ( FORMAT(@ntype, 'G', 'en-us') )  
            ELSE '** Invalid **'
        END;
    
    RETURN @ret
END;
GO

DECLARE @ntype tinyint = 4

--SELECT [dbo].[udfNbrFormatr](@ntype) 

SELECT	[dbo].[udfNbrFormatr](1) as  'Numeric Format 1'
		,[dbo].[udfNbrFormatr](2) as 'Currency Format 2'
		,[dbo].[udfNbrFormatr](3) as 'General Format 3'
		,[dbo].[udfNbrFormatr](4) as 'Date Format 4'
		,[dbo].[udfNbrFormatr](5) as 'Date Format 5'
		,[dbo].[udfNbrFormatr](6) as 'Date Format 6'


------------------------------------------------------------------


