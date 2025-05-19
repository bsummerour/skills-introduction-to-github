USE StockInvestDB
GO

IF (OBJECT_ID('tempdb..#temp') IS NOT NULL)
BEGIN
	DROP TABLE #Temp;
END;

EXEC sp_configure 'show advanced options', '1';
GO


--TRUNCATE TABLE dbo.StageDataLoadHist
--GO

-- declare all variables used
DECLARE
    @CR               CHAR(1), -- Carriage Return (CR)
    @LF               CHAR(1), -- Line Feed (LF)
    @CRLF             CHAR(2), -- Carriage Return / Line Feed
    @sas_parm_nm      VARCHAR(255)  = 'STOCKCHART_SOURCE_TABLE_NAMES',
    @value_chr        VARCHAR(255)  = 'C:\Finance\StageStockHistoryData\AllFiles_2023-2025\',
    @range_value1_chr VARCHAR(255)  = 'STOCKCHART',
    @parm_description VARCHAR(1000) = 'Path to stock data files',
    @filename         VARCHAR(255) = '',
    @path             VARCHAR(255) = '',
    @sql              VARCHAR(8000) = '',
	@sql2			  VARCHAR(8000) = '',
    @cmd              VARCHAR(1000) = '',
    @tRowCount        INT           = 0,
    @iSymbol          VARCHAR(8) = '',
	@ENDLEN           INT  = 0,
	@tablename        VARCHAR(1000) = '', 
	@delTables        VARCHAR(MAX)  = ' ',
	@readTables       VARCHAR(MAX)  = ' ',
    @selectStatement	  VARCHAR(MAX)  = ' ',
    @execSelectTable       VARCHAR(MAX) = ' ',
	@StageDataLoadHist  VARCHAR(100) = 'StageDataLoadHist',
	@loadfile           VARCHAR(MAX) = ' ',
	@Counter            INT = 0;

SET @CR = CHAR(10);
SET @LF = CHAR(13);
SET @CRLF = @CR + @LF;
--SET @Counter =( SELECT count(*) FROM StageDataLoadHist )

IF @Counter > 0
	PRINT + @CRLF +  'DO NOT TRUNCATE StageDataLoadHist TABLE ' 
ELSE
	TRUNCATE TABLE dbo.StageDataLoadHist;

CREATE TABLE #Temp
    (
        WhichPath VARCHAR(255),
        WhichFile VARCHAR(255)
    );

-- Get the list of files to process from a folder on the Windows file system and populate the #temp table 

SET @path = @value_chr;
SET @cmd = 'dir ' + @path + '*.csv /b';

PRINT + @CRLF +  'LOAD FILE PATH IS: ' + @cmd + @CRLF + @CRLF ;

INSERT INTO #Temp
    (
        WhichFile
    )
EXEC sys.xp_cmdshell @cmd;

UPDATE #Temp
SET WhichPath = @path
WHERE WhichPath IS NULL;

DELETE FROM #Temp WHERE WhichFile IS NULL;

SELECT * FROM #Temp ;

SET @Counter =( SELECT count(*) FROM #Temp )
PRINT 'The counter value is = ' + CONVERT(VARCHAR,@Counter)+ @CRLF 

-- Use a file cursor to load the flat files into dbo.StageDataLoadHist

DECLARE file_list_cur CURSOR FOR
    SELECT WhichPath, WhichFile
    FROM #Temp
    WHERE WhichFile LIKE '%.csv%';

OPEN file_list_cur;

FETCH NEXT FROM file_list_cur
   INTO @path, @filename;

-- WHILE ( @Counter != 0)
WHILE @@FETCH_STATUS = 0  

BEGIN
	SET @sql = 'BULK INSERT  dbo.StageDataLoadHist ' +  
		'FROM  ' + ''''+ @path + @filename + ''' ' +   + @CR +
		' WITH (  ' +  @CR +
		  		' FIELDTERMINATOR='',''  '      + ','    + @CR +
				' CODEPAGE=''65001''     '      + ','    + @CR +
				' DATAFILETYPE=''char''  '      + ','    + @CR +
				' FIELDQUOTE=''"''       '      + ','    + @CR +
				' ROWTERMINATOR=''0x0a'' '      + ','    + @CR +
				' FORMAT=''CSV''         '      + ','    + @CR +
				' FIRSTROW=2             '       +  @CR +
				' );                     '     


	PRINT @CRLF + 'THE SQL TO EXECUTE IS: ' + @sql + @CRLF

	EXEC (@sql);

	SET @Counter  = @Counter + 1;

	FETCH NEXT FROM file_list_cur
	INTO @path, @filename;
END

CLOSE file_list_cur;
DEALLOCATE file_list_cur;
 
IF (OBJECT_ID('tempdb..#temp') IS NOT NULL)
BEGIN
	DROP TABLE #Temp;
END;
GO

SELECT MAX(TradeDate), MIN(TradeDate)   FROM dbo.StageDataLoadHist;





