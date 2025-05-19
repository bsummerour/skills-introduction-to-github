USE [StockInvestDB]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DJI_Avge_HistData]') AND type in (N'U'))
DROP TABLE [dbo].[DJI_Avge_HistData]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DJI_Avge_HistData](
	[TradeDate]		[dbo].[tradedate]		 NOT NULL,
	[DJIPrice]		VARCHAR(15) NOT NULL,
	[DJIopen]		VARCHAR(15)  NOT NULL,
	[DJIHigh]		VARCHAR(15)  NOT NULL,
	[DJILow]		VARCHAR(15)  NOT NULL,
	[DJIVolume]		VARCHAR(15) 			 NOT NULL,
	[DJIChgPct]		VARCHAR(15)  NOT NULL,
INDEX IX_TradeDate NONCLUSTERED (TradeDate)
) ON [PRIMARY]
GO

/*
Date        5/2/2025
Price		41,317.43
Open		40,960.42
High		41,386.19
Low			40,960.42
Vol.		589.87M
Change %	1.39%
*/

