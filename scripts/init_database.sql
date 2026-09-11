/*
-------------------------------------------
Create Database and Schemas
-------------------------------------------
Script Purpose:
	This script creates a new database 'DataWarehouse' after checking if it already exists.
	If the database exists, it is dropped and then recreated. After that, the script
	sets up three schemas within the database: 'bronze', 'silver', 'gold'.

WARNING:
	Running this script will drop the 'DataWarehouse' database if it exists.
	All data in the database will be permanently deleted. Proceed with caution and ensure
	proper backups before running this script. 
*/


-- Drop and recreate Database 'DataWarehouse'
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;
GO


USE master;
GO

-- Create and use Database 'DataWarehouse'
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- Create Schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO

