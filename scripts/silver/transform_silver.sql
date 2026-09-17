/*
=================================================================
Silver table Transformations
=================================================================
Script Purpose:
    This script creates a stored procedure 'silver.transform_silver'
    that loads data from silver tables to silver tables and does
    necessary data cleansing.
*/

CREATE OR ALTER PROCEDURE silver.transform_silver AS
BEGIN
	DECLARE @start_time DATETIME2, @end_time DATETIME2, @start_time_silver DATETIME2, @end_time_silver DATETIME2;
	BEGIN TRY
		SET @start_time_silver = GETDATE()
		-- 'olist_products_dataset'
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: silver.olist_products_dataset';
        TRUNCATE TABLE silver.olist_products_dataset;
        PRINT '>> Inserting Data Into Table: silver.olist_products_dataset';
		INSERT INTO silver.olist_products_dataset (
			product_id, 
			product_category_name, 
			product_name_length, 
			product_description_length,
			product_photos_qty, 
			product_weight_g,
			product_weight_kg,
			product_length_cm, 
			product_height_cm, 
			product_width_cm
			)
		SELECT 
			product_id, 
			product_category_name, 
			product_name_length, 
			product_description_length,
			product_photos_qty, 
			product_weight_g,
			CAST(product_weight_g / 1000.0 AS DECIMAL(10,3)) AS product_weight_kg,
			product_length_cm, 
			product_height_cm, 
			product_width_cm
		FROM bronze.olist_products_dataset;
		SET @end_time = GETDATE();
        PRINT '>> Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '-------------------------------------------------';
		-- 'olist_customers_dataset'
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: silver.olist_customers_dataset';
        TRUNCATE TABLE silver.olist_customers_dataset;
        PRINT '>> Inserting Data Into Table: silver.olist_customers_dataset';
		INSERT INTO silver.olist_customers_dataset (
			customer_id,
			customer_unique_id,
			customer_zip_code_prefix,
			customer_city,
			customer_state
		)
		SELECT *
		FROM bronze.olist_customers_dataset;
		SET @end_time = GETDATE();
        PRINT '>> Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '-------------------------------------------------';
		-- 'olist_geolocation_dataset'
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: silver.olist_geolocation_dataset';
        TRUNCATE TABLE silver.olist_geolocation_dataset;
        PRINT '>> Inserting Data Into Table: silver.olist_geolocation_dataset';
		INSERT INTO silver.olist_geolocation_dataset (
			geolocation_zip_code_prefix,
			geolocation_lat,
			geolocation_lng,
			geolocation_city,
			geolocation_state
		)
		SELECT * 
		FROM bronze.olist_geolocation_dataset;
		SET @end_time = GETDATE();
        PRINT '>> Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '-------------------------------------------------';
		-- 'olist_order_items_dataset'
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: silver.olist_order_items_dataset';
        TRUNCATE TABLE silver.olist_order_items_dataset;
        PRINT '>> Inserting Data Into Table: silver.olist_order_items_dataset';
		INSERT INTO silver.olist_order_items_dataset (
			order_id,
			order_item_id,
			product_id,
			seller_id,
			shipping_limit_date,
			price,
			freight_price
		)
		SELECT *
		FROM bronze.olist_order_items_dataset;
		SET @end_time = GETDATE();
        PRINT '>> Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------------------------------------';
		-- 'olist_order_payments_dataset'
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: silver.olist_order_payments_dataset';
        TRUNCATE TABLE silver.olist_order_payments_dataset;
        PRINT '>> Inserting Data Into Table: silver.olist_order_payments_dataset';
		INSERT INTO silver.olist_order_payments_dataset (
			order_id,
			payment_sequential,
			payment_type,
			payment_installments,
			payment_value
		)
		SELECT *
		FROM bronze.olist_order_payments_dataset;
		SET @end_time = GETDATE();
        PRINT '>> Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '-------------------------------------------------';
		-- 'product_category_name_translation'
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: silver.product_category_name_translation';
        TRUNCATE TABLE silver.product_category_name_translation;
        PRINT '>> Inserting Data Into Table: silver.product_category_name_translation';
		INSERT INTO silver.product_category_name_translation (
			product_category_name,
			product_category_name_english
		)
		SELECT *
		FROM bronze.product_category_name_translation;
		SET @end_time = GETDATE();
        PRINT '>> Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '-------------------------------------------------';
		-- 'olist_order_payments_dataset'
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: silver.olist_order_payments_dataset';
        TRUNCATE TABLE silver.olist_order_payments_dataset;
        PRINT '>> Inserting Data Into Table: silver.olist_order_payments_dataset';
		INSERT INTO silver.olist_order_payments_dataset (
			order_id,
			payment_sequential,
			payment_type,
			payment_installments,
			payment_value
		)
		SELECT *
		FROM bronze.olist_order_payments_dataset;
		SET @end_time = GETDATE();
        PRINT '>> Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '-------------------------------------------------';
			-- 'olist_orders_dataset'
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: silver.olist_orders_dataset';
        TRUNCATE TABLE silver.olist_orders_dataset;
        PRINT '>> Inserting Data Into Table: silver.olist_orders_dataset';
		INSERT INTO silver.olist_orders_dataset (
			order_id,
			customer_id,
			order_status,
			order_purchase_timestamp,
			order_approved_at,
			order_delivered_carrier_date,
			order_delivered_customer_date,
			order_estimated_delivery_date
		)
		SELECT *
		FROM bronze.olist_orders_dataset;
		SET @end_time = GETDATE();
        PRINT '>> Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '-------------------------------------------------';
			-- 'olist_sellers_dataset'
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: silver.olist_sellers_dataset';
        TRUNCATE TABLE silver.olist_sellers_dataset;
        PRINT '>> Inserting Data Into Table: silver.olist_sellers_dataset';
		INSERT INTO silver.olist_sellers_dataset (
			seller_id,
			seller_zip_code_prefix,
			seller_city,
			seller_state
		)
		SELECT *
		FROM bronze.olist_sellers_dataset;
		SET @end_time = GETDATE();
        PRINT '>> Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '-------------------------------------------------';
		-- 'olist_order_reviews_dataset'
        SET @start_time = GETDATE();
        PRINT '>> Truncating Table: silver.olist_order_reviews_dataset';
        TRUNCATE TABLE silver.olist_order_reviews_dataset;
        PRINT '>> Inserting Data Into Table: silver.olist_order_reviews_dataset';
		INSERT INTO silver.olist_order_reviews_dataset (
			review_id,
			order_id,
			review_score,
			review_comment_title,
			review_comment_message,
			review_creation_date,
			review_answer_timestamp
		)
		SELECT *
		FROM bronze.olist_order_reviews_dataset;
		SET @end_time = GETDATE();
		SET @end_time_silver = GETDATE();
        PRINT '>> Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '-------------------------------------------------';
		PRINT '=================================================';
		PRINT 'Silver Layer Transformation Duration: ' + CAST(DATEDIFF(
			second, @start_time_silver, @end_time_silver) AS NVARCHAR) + ' seconds';
		PRINT '=================================================';
	END TRY
	BEGIN CATCH
		PRINT '=================================================';
		PRINT 'Error occured during loading Silver Layer';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Number' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error State' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=================================================';
	END CATCH
END
EXEC silver.transform_silver
