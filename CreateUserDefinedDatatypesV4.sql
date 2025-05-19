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

DECLARE @d AS DATE = GETDATE(); -- '08/09/2024'

SELECT FORMAT(@d, 'd', 'en-US') AS 'US English',
		FORMAT(@d, 'D', 'en-US') AS 'US English';

------------------------------------------------------------------

DECLARE 
    @numr numeric(9, 2) ,
	@dt date = getdate()

--SET @numr =( FORMAT((123456789), '###-##-####') );
SET @dt = GETDATE();

SELECT FORMAT(@dt, 'dd/MM/yyyy', 'en-US') AS 'Date',
       FORMAT(123456789, '###-##-####') AS 'Custom Number',
	   @numr    ;

------------------------------------------------------------------

DROP FUNCTION IF EXISTS [dbo].[udfDateFormat]
GO

--- Returns date format as '5/5/2025'	or 'Monday, May 5, 2025' 

CREATE FUNCTION [dbo].[udfDateFormat](@dte DATE, @dtype tinyint)
RETURNS [nvarchar](25) 
AS 
BEGIN
    DECLARE @ret [nvarchar](25)

    SET @ret = 
        CASE @dtype
            WHEN 1 THEN ( SELECT FORMAT(@dte, 'd', 'en-US') )
            WHEN 2 THEN ( SELECT FORMAT(@dte, 'D', 'en-US') )
			WHEN 3 THEN ( SELECT FORMAT(@dte, 'MM/dd/yyyy', 'en-US') )
			WHEN 4 THEN ( SELECT FORMAT(@dte, 'MM-dd-yyyy', 'en-US') )
            WHEN 5 THEN ( SELECT FORMAT(@dte, 'yyyy-MM-dd', 'en-US') )
            WHEN 6 THEN ( SELECT FORMAT(@dte, 'yyyy-MM', 'en-US') )
            WHEN 7 THEN ( SELECT FORMAT(@dte, 'MM-yyy', 'en-US') )
			WHEN 8 THEN ( SELECT FORMAT(@dte, 'dd/MM/yyyy', 'en-US') )
            ELSE '** Invalid **'
        END;
    
    RETURN @ret
END;
GO

---  Test Function [udfDateFormat] ---

DECLARE @dtype tinyint = 4,
	@dte date = getdate()

SELECT [dbo].[udfDateFormat](@dte, @dtype) 

SELECT	[dbo].[udfDateFormat] (@dte, 1 ) as 'Date Format 1'
		,[dbo].[udfDateFormat](@dte, 2 ) as 'Date Format 2'
		,[dbo].[udfDateFormat](@dte, 3 ) as 'Date Format 3'
		,[dbo].[udfDateFormat](@dte, 4 ) as 'Date Format 4'
		,[dbo].[udfDateFormat](@dte, 5 ) as 'Date Format 5'
		,[dbo].[udfDateFormat](@dte, 6 ) as 'Date Format 6'
		,[dbo].[udfDateFormat](@dte, 7 ) as 'Date Format 7'
		,[dbo].[udfDateFormat](@dte, 8 ) as 'Date Format 8'


------------------------------------------------------------------
Create function [udfNbrFormat]
------------------------------------------------------------------


DROP FUNCTION IF EXISTS [dbo].[udfNbrFormat]
GO

--- Returns date format as '5/5/2025'	or 'Monday, May 5, 2025' 

CREATE FUNCTION [dbo].[udfNbrFormat]( @nbr DECIMAL(15,2), 
									  @ntype tinyint 	)
RETURNS varchar(25) 
AS 
BEGIN
    DECLARE @ret varchar(25)

    SET @ret = 
        CASE @ntype
            WHEN 1 THEN ( FORMAT(@nbr, 'N', 'en-us') )  
            WHEN 2 THEN ( FORMAT(@nbr, 'C', 'en-us') )  
            WHEN 3 THEN ( FORMAT(@nbr, 'G', 'en-us') ) 
			WHEN 4 THEN ( FORMAT(@nbr, 'N2', 'en-us') )
			WHEN 5 THEN ( FORMAT(@nbr, 'N0', 'en-us') )
			ELSE '** Invalid **'
        END;
    
    RETURN @ret
END;
GO

---  Test Function [udfNbrFormat] ---

DECLARE @ntype tinyint = 1,
		@nbr   decimal(15,2) = 1234567.89,
		@nbr2   NUMERIC(10, 0) = 1234567

SELECT [dbo].[udfNbrFormat](@nbr, @ntype) 

SELECT	[dbo].[udfNbrFormat]( @nbr, 1 ) as  'Numeric Format 1'
		,[dbo].[udfNbrFormat]( @nbr, 2 ) as 'Currency Format 2'
		,[dbo].[udfNbrFormat]( @nbr, 3 ) as 'General Format 3'
		,[dbo].[udfNbrFormat]( @nbr, 4 ) as 'Number Format 4'
		,[dbo].[udfNbrFormat]( @nbr, 5 ) as 'Number Format 5'
		,[dbo].[udfNbrFormat]( @nbr, 6 ) as 'Number Format 6'

SELECT	[dbo].[udfNbrFormat]( @nbr2, 1 ) as  'Numeric Format 1'
		,[dbo].[udfNbrFormat]( @nbr2, 2 ) as 'Currency Format 2'
		,[dbo].[udfNbrFormat]( @nbr2, 3 ) as 'General Format 3'
		,[dbo].[udfNbrFormat]( @nbr2, 4 ) as 'Number Format 4'
		,[dbo].[udfNbrFormat]( @nbr2, 5 ) as 'Number Format 5'
		,[dbo].[udfNbrFormat]( @nbr2, 6 ) as 'Number Format 6'



------------------------------------------------------------------
/*  
SELECT 
    FORMAT(12345.67, 'C', 'en-US')  AS "USD",    -- Format as currency (US)'
    FORMAT(12345.67, 'N2', 'en-US') AS "N2 US"  -- Format as number with 2 decimals (US)


    --FORMAT(12345.67, 'C', 'de-DE') AS "EUR",  -- Format as currency (Germany)
    --FORMAT(12345.67, 'N2', 'fr-FR') AS "N2 FR";   -- Format as number with 2 decimals (France)


--SELECT FORMAT(@d, 'D', 'en-US') AS 'US English',
--       FORMAT(@d, 'D', 'en-gb') AS 'British English',
--       FORMAT(@d, 'D', 'de-de') AS 'German',
--       FORMAT(@d, 'D', 'zh-cn') AS 'Chinese Simplified (PRC)';



*/

