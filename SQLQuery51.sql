USE [StockInvestDB]
GO


SELECT COUNT(*) AS 'DuplCount'
		, Symbol
		, TradeDate
FROM StageDataLoadHist
GROUP BY Symbol 
		,TradeDate
HAVING COUNT(*) > 1



SELECT 
		Symbol
		, TradeDate
		,volume
FROM StageDataLoadHist
WHERE VOLUME = 0
ORDER BY SYMBOL


DELETE FROM dbo.StageDataLoadHist
WHERE VOLUME = 0

SELECT 
		Symbol
		, TradeDate
		,volume
FROM StageDataLoadHist
WHERE VOLUME = 0
ORDER BY SYMBOL


SELECT 
		Symbol
		,TradeDate
		,Volume
FROM StageDataLoadHist
WHERE Symbol IN ( 'AAAU',
					'AAAU',
					'AAAU',
					'AACBU',
					'AACG',
					'AACG',
					'AADR',
					'AADR',
					'AAL')
AND TradeDate IN ( '2025-04-16', '2025-04-17')


GO



 

