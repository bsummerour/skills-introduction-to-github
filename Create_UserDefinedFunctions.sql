USE StockInvestDB
GO

----- Create  UserDefinedFunction [dbo].[add] ---------
DROP FUNCTION IF EXISTS [dbo].[add]
GO

CREATE FUNCTION [dbo].[add] (
    @a INT,
    @b INT
)
RETURNS INT
AS
BEGIN
    RETURN @a + @b;
END;

SELECT [dbo].[add] (5, 10) AS 'Run UDF';   -- Returns 15

DROP FUNCTION IF EXISTS [dbo].[udfDateFormat]
GO

CREATE FUNCTION [dbo].[udfDateFormat](@Status [tinyint])
RETURNS [nvarchar](15) 
AS 
-- Returns the sales order status text representation for the status value.
BEGIN
    DECLARE @ret [nvarchar](15);

    SET @ret = 
        CASE @Status
            WHEN 1 THEN 'In process'
            WHEN 2 THEN 'Approved'
            WHEN 3 THEN 'Backordered'
            WHEN 4 THEN 'Rejected'
            WHEN 5 THEN 'Shipped'
            WHEN 6 THEN 'Cancelled'
            ELSE '** Invalid **'
        END;
    
    RETURN @ret
END;
GO

