/*
=============================================================
DDL Script: Create Silver Tables
=============================================================
Script Purpose:
	This script creates tables in the 'silver' schema after
	first checking if they exist and dropping if they do.

*/

-- table for 'olist_customers_dataset' customer data
IF OBJECT_ID('silver.olist_customers_dataset', 'U') IS NOT NULL
	DROP TABLE silver.olist_customers_dataset;
CREATE TABLE silver.olist_customers_dataset (
	customer_id VARCHAR(32),
	customer_unique_id VARCHAR(32),
	customer_zip_code_prefix VARCHAR(7),
	customer_city VARCHAR(50),
	customer_state VARCHAR(2),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);


-- table for 'olist_geolocation_dataset' geolocation data
IF OBJECT_ID('silver.olist_geolocation_dataset', 'U') IS NOT NULL
	DROP TABLE silver.olist_geolocation_dataset;
CREATE TABLE silver.olist_geolocation_dataset (
	geolocation_zip_code_prefix INT,
	geolocation_lat FLOAT,
	geolocation_lng FLOAT,
	geolocation_city VARCHAR(50),
	geolocation_state VARCHAR(2),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

-- table for 'olist_order_items_dataset' order items data
IF OBJECT_ID('silver.olist_order_items_dataset', 'U') IS NOT NULL
	DROP TABLE silver.olist_order_items_dataset;
CREATE TABLE silver.olist_order_items_dataset (
	order_id VARCHAR(32),
	order_item_id INT,
	product_id VARCHAR(32),
	seller_id VARCHAR(50),
	shipping_limit_date DATETIME2,
	price DECIMAL(10,2),
	freight_price DECIMAL(10,2),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

-- table for 'olist_order_payments_dataset' order payments data
IF OBJECT_ID('silver.olist_order_payments_dataset', 'U') IS NOT NULL
	DROP TABLE silver.olist_order_payments_dataset;
CREATE TABLE silver.olist_order_payments_dataset (
	order_id VARCHAR(32),
	payment_sequential INT,
	payment_type VARCHAR(20),
	payment_installments INT,
	payment_value DECIMAL(10,2),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

-- table for 'olist_order_reviews_dataset' order reviews data
IF OBJECT_ID('silver.olist_order_reviews_dataset', 'U') IS NOT NULL
	DROP TABLE silver.olist_order_reviews_dataset;
CREATE TABLE silver.olist_order_reviews_dataset (
	review_id VARCHAR(32),
	order_id VARCHAR(32),
	review_score INT,
	review_comment_title VARCHAR(100),
	review_comment_message VARCHAR(500),
	review_creation_date DATETIME2,
	review_answer_timestamp DATETIME2,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

-- table for 'olist_orders_dataset' order data
IF OBJECT_ID('silver.olist_orders_dataset', 'U') IS NOT NULL
	DROP TABLE silver.olist_orders_dataset;
CREATE TABLE silver.olist_orders_dataset (
	order_id VARCHAR(32),
	customer_id VARCHAR(32),
	order_status VARCHAR(15),
	order_purchase_timestamp DATETIME2,
	order_approved_at DATETIME2,
	order_delivered_carrier_date DATETIME2,
	order_delivered_customer_date DATETIME2,
	order_estimated_delivery_date DATETIME2,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

-- table for 'olist_products_dataset' products data
IF OBJECT_ID('silver.olist_products_dataset', 'U') IS NOT NULL
	DROP TABLE silver.olist_products_dataset;
CREATE TABLE silver.olist_products_dataset (
	product_id VARCHAR(32),
	product_category_name VARCHAR(100),
	product_name_length INT,
	product_description_length INT,
	product_photos_qty INT,
	product_weight_g INT,
	product_weight_kg DECIMAL(10,3),
	product_length_cm INT,
	product_height_cm INT,
	product_width_cm INT,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);


-- table for 'olist_sellers_dataset' seller data
IF OBJECT_ID('silver.olist_sellers_dataset', 'U') IS NOT NULL
	DROP TABLE silver.olist_sellers_dataset;
CREATE TABLE silver.olist_sellers_dataset (
	seller_id VARCHAR(32),
	seller_zip_code_prefix INT,
	seller_city VARCHAR(40),
	seller_state VARCHAR(2),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);

-- table for 'product_category_name_translation' translation table data
IF OBJECT_ID('silver.product_category_name_translation', 'U') IS NOT NULL
	DROP TABLE silver.product_category_name_translation;
CREATE TABLE silver.product_category_name_translation (
	product_category_name VARCHAR(50),
	product_category_name_english VARCHAR(50),
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);
