USE [master]
GO

/****** Object:  UserDefinedDataType [dbo].[AccountNumber]    Script Date: 5/4/2025 3:56:35 PM ******/
DROP TYPE [dbo].[AccountNumber]
GO

/****** Object:  UserDefinedDataType [dbo].[AccountNumber]    Script Date: 5/4/2025 3:56:35 PM ******/
CREATE TYPE [dbo].[AccountNumber] FROM [nvarchar](15) NULL
GO


USE [master]
GO

/****** Object:  UserDefinedDataType [dbo].[Flag]    Script Date: 5/4/2025 3:57:03 PM ******/
CREATE TYPE [dbo].[Flag] FROM [bit] NOT NULL
GO

USE [master]
GO

/****** Object:  UserDefinedDataType [dbo].[Name]    Script Date: 5/4/2025 3:57:35 PM ******/
DROP TYPE [dbo].[Name]
GO

USE [master]
GO

/****** Object:  UserDefinedDataType [dbo].[NameStyle]    Script Date: 5/4/2025 3:57:58 PM ******/
CREATE TYPE [dbo].[NameStyle] FROM [bit] NOT NULL
GO

USE [master]
GO

/****** Object:  UserDefinedDataType [dbo].[OrderNumber]    Script Date: 5/4/2025 3:58:18 PM ******/
CREATE TYPE [dbo].[OrderNumber] FROM [nvarchar](25) NULL
GO

USE [master]
GO

/****** Object:  UserDefinedDataType [dbo].[Phone]    Script Date: 5/4/2025 3:58:47 PM ******/
CREATE TYPE [dbo].[Phone] FROM [nvarchar](25) NULL
GO

USE [master]
GO

/****** Object:  UserDefinedDataType [dbo].[symbol]    Script Date: 5/4/2025 3:59:10 PM ******/
CREATE TYPE [dbo].[symbol] FROM [varchar](10) NOT NULL
GO

USE [master]
GO

/****** Object:  UserDefinedDataType [dbo].[TRADE_DATE]    Script Date: 5/4/2025 3:59:32 PM ******/
CREATE TYPE [dbo].[TRADE_DATE] FROM [datetime] NOT NULL
GO























