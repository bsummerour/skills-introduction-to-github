USE [StockInvestDB]
GO

--SELECT [Symbol]
--      ,[TradeDate]
--      ,[StockOpen]
--      ,[StockHigh]
--      ,[StockLow]
--      ,[StockClose]
--      ,[Volume]
--  FROM [dbo].[StageDataLoadHist]

--GO

DECLARE @ntype tinyint = 1,
		@nbr   decimal(15,2) = 1234567.89,
		@dte date	= getdate()
		
SELECT count(*) as 'Table Count(*)',
		[dbo].[udfNbrFormat]( count(*), 5 ) as 'Number Format',
		[dbo].[udfDateFormat]( MAX(TradeDate), 4 ) as 'Maximum Trade',
		[dbo].[udfDateFormat]( MIN(TradeDate), 4 ) as 'Minimum Trade'
FROM [dbo].[StageDataLoadHist];

