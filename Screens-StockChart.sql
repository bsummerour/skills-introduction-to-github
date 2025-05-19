-- Screening ideas from Stock Chart

/*
A robust scan has three main parts:

Defining the universe. Which group of stocks or ETFs are you 
willing to invest in? This comprises your “universe” of securities.

Refining the universe with technical conditions. What technical
indicator setup would interest you in watching a particular stock?

Watching for a signal. What change in indicator values would make
you want to buy that stock today?
*/


Strong Volume Gainers (All Exchanges)
	[type = stock]
	and [Daily SMA(20,Daily Volume) > 40000]
	and [Daily Volume > Yesterdays Daily SMA(20,Daily Volume) * 4]
	and [Daily Close > Yesterdays Daily Close]
	
	SQL Version
	


New 52-week Highs (All Exchanges)
	[type = stock]
	and [Daily SMA(20,Daily Volume) > 40000]
	and [Daily High > Yesterdays Daily MAX(253,Daily High)]

Gap Ups (All Exchanges)
	[type = stock]
	and [Daily SMA(20,Daily Volume) > 40000]
	and [Daily Low > Yesterdays Daily High * 1.026]

-----------------------------------------------------------

--  BULLISH TECHNICAL INDICATORS

-----------------------------------------------------------

Runaway Gap Ups (All Exchanges)
	[type = stock]
	and [Daily SMA(20,Daily Volume) > 40000]
	and [Yesterdays Daily Close > Yesterdays Daily EMA(10,Daily Close)]
	and [Daily Low > Yesterdays Daily High * 1.025]
	and [Daily Low != Daily High]

-----------------------------------------------------------

-- BEARISH TECHNICAL INDICATORS

-----------------------------------------------------------

New 52-week Lows (All Exchanges)
	[type = stock]
	and [Daily SMA(20,Daily Volume) > 40000]
	and [Daily Low < Yesterdays Daily MIN(253,Daily Low)]

Strong Volume Decliners (All Exchanges)
	[type = stock]
	and [Daily SMA(20,Daily Volume) > 40000]
	and [Daily Volume > Yesterdays Daily SMA(20,Daily Volume) * 4]
	and [Daily Close > Yesterdays Daily Close]

Bearish 50/200-day MA Crossovers (All Exchanges)
	[type = stock]
	and [Daily SMA(20,Daily Volume) > 40000]
	and [Daily SMA(50,Daily Close) < Daily SMA(200,Daily Close)]
	and [Yesterdays Daily SMA(50,Daily Close) >= Yesterdays Daily SMA(200,Daily Close)]

Gap Downs (All Exchanges)
	[type = stock]
	and [Daily SMA(20,Daily Volume) > 40000]
	and [Daily High < Yesterdays Daily Low * 0.974]

Runaway Gap Downs (All Exchanges)
	[type = stock]
	and [Daily SMA(20,Daily Volume) > 40000]
	and [Yesterdays Daily Close < Yesterdays Daily EMA(10,Daily Close)]
	and [Daily High < Yesterdays Daily Low * 0.975]
	and [Daily Low != Daily High]






















