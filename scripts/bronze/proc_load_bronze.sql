/*
=============================================================
Create stored procedure for loading data into bronze tables
=============================================================
Script Purpose:
    This script creates a stored procedure 'bronze.load_bronze'
    that loads data to bronze tables from csv files at
    a defined source.
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @start_time_bronze DATETIME, @end_time_bronze DATETIME;
    BEGIN TRY
        PRINT '=================================================';
        PRINT 'Loading Bronze Layer from csv'
        PRINT '=================================================';

        -- 'olist_customers_dataset'
        SET @start_time_bronze = GETDATE();
        SET @start_time = GETDATE();
        PRINT '>> Truncate Table: bronze.olist_customers_dataset';
        TRUNCATE TABLE bronze.olist_customers_dataset;
        PRINT '>> Inserting Data Into Table: bronze.olist_customers_dataset';
        BULK INSERT bronze.olist_customers_dataset
        FROM 'C:\SQLData\olist_dataset\olist_customers_dataset.csv'
        WITH (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '-------------------------------------------------';

        -- 'olist_geolocation_dataset'
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.olist_geolocation_dataset';
        TRUNCATE TABLE bronze.olist_geolocation_dataset;
        PRINT '>> Inserting Data Into Table: bronze.olist_geolocation_dataset';
        BULK INSERT bronze.olist_geolocation_dataset
        FROM 'C:\SQLData\olist_dataset\olist_geolocation_dataset.csv'
        WITH (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '-------------------------------------------------';

        -- 'olist_order_items_dataset'
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.olist_order_items_dataset';
        TRUNCATE TABLE bronze.olist_order_items_dataset;
        PRINT '>> Inserting Data Into Table: bronze.olist_order_items_dataset';
        BULK INSERT bronze.olist_order_items_dataset
        FROM 'C:\SQLData\olist_dataset\olist_order_items_dataset.csv'
        WITH (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '-------------------------------------------------';

        -- 'olist_order_payments_dataset'
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.olist_order_payments_dataset';
        TRUNCATE TABLE bronze.olist_order_payments_dataset;
        PRINT '>> Inserting Data Into Table: bronze.olist_order_payments_dataset';
        BULK INSERT bronze.olist_order_payments_dataset
        FROM 'C:\SQLData\olist_dataset\olist_order_payments_dataset.csv'
        WITH (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '-------------------------------------------------';

        -- 'olist_order_reviews_dataset'
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.olist_order_reviews_dataset';
        TRUNCATE TABLE bronze.olist_order_reviews_dataset;
        PRINT '>> Inserting Data Into Table: bronze.olist_order_reviews_dataset';
        BULK INSERT bronze.olist_order_reviews_dataset
        FROM 'C:\SQLData\olist_dataset\olist_order_reviews_dataset.csv'
        WITH (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '-------------------------------------------------';

        -- 'olist_orders_dataset'
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.olist_orders_dataset';
        TRUNCATE TABLE bronze.olist_orders_dataset;
        PRINT '>> Inserting Data Into Table: bronze.olist_orders_dataset';
        BULK INSERT bronze.olist_orders_dataset
        FROM 'C:\SQLData\olist_dataset\olist_orders_dataset.csv'
        WITH (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '-------------------------------------------------';

        -- 'olist_products_dataset'
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.olist_products_dataset';
        TRUNCATE TABLE bronze.olist_products_dataset;
        PRINT '>> Inserting Data Into Table: bronze.olist_products_dataset';
        BULK INSERT bronze.olist_products_dataset
        FROM 'C:\SQLData\olist_dataset\olist_products_dataset.csv'
        WITH (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '-------------------------------------------------';

        -- 'olist_sellers_dataset'
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.olist_sellers_dataset';
        TRUNCATE TABLE bronze.olist_sellers_dataset;
        PRINT '>> Inserting Data Into Table: bronze.olist_sellers_dataset';
        BULK INSERT bronze.olist_sellers_dataset
        FROM 'C:\SQLData\olist_dataset\olist_sellers_dataset.csv'
        WITH (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '>> Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '-------------------------------------------------';

        -- 'product_category_name_translation'
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: bronze.product_category_name_translation';
        TRUNCATE TABLE bronze.product_category_name_translation;
        PRINT '>> Inserting Data Into Table: bronze.product_category_name_translation';
        BULK INSERT bronze.product_category_name_translation
        FROM 'C:\SQLData\olist_dataset\product_category_name_translation.csv'
        WITH (
            FORMAT = 'CSV',
            FIRSTROW = 2,
            ROWTERMINATOR = '0x0a',
            TABLOCK
        );
        SET @end_time = GETDATE();
        SET @end_time_bronze = GETDATE();
        PRINT '>> Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '-------------------------------------------------';
        PRINT '=================================================';
        PRINT 'Bronze Layer Load Duration: ' + CAST(DATEDIFF(
            second, @start_time_bronze, @end_time_bronze) AS NVARCHAR) + ' seconds';
        PRINT '=================================================';



    END TRY
    BEGIN CATCH
        PRINT '=================================================';
        PRINT 'Error occured during loading Bronze Layer';
        PRINT 'Error Message' + ERROR_MESSAGE();
        PRINT 'Error Number' + CAST (ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error State' + CAST (ERROR_STATE() AS NVARCHAR);
        PRINT '=================================================';
    END CATCH
END
EXEC bronze.load_bronze
