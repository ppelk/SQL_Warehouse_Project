/*
=============================================================
DDL Script: Create Bronze Tables
=============================================================
Script Purpose:
	This script creates tables in the 'bronze' schema after
	first checking if they exist and dropping if they do.

*/

-- table for 'olist_customers_dataset' customer data
IF OBJECT_ID('bronze.olist_customers_dataset', 'U') IS NOT NULL
	DROP TABLE bronze.olist_customers_dataset;
CREATE TABLE bronze.olist_customers_dataset (
	customer_id VARCHAR(32),
	customer_unique_id VARCHAR(32),
	customer_zip_code_prefix VARCHAR(7),
	customer_city VARCHAR(50),
	customer_state VARCHAR(2)
);


-- table for 'olist_geolocation_dataset' geolocation data
IF OBJECT_ID('bronze.olist_geolocation_dataset', 'U') IS NOT NULL
	DROP TABLE bronze.olist_geolocation_dataset;
CREATE TABLE bronze.olist_geolocation_dataset (
	geolocation_zip_code_prefix INT,
	geolocation_lat FLOAT,
	geolocation_lng FLOAT,
	geolocation_city VARCHAR(50),
	geolocation_state VARCHAR(2)
);

-- table for 'olist_order_items_dataset' order items data
IF OBJECT_ID('bronze.olist_order_items_dataset', 'U') IS NOT NULL
	DROP TABLE bronze.olist_order_items_dataset;
CREATE TABLE bronze.olist_order_items_dataset (
	order_id VARCHAR(32),
	order_item_id INT,
	product_id VARCHAR(32),
	seller_id VARCHAR(50),
	shipping_limit_date DATE,
	price FLOAT,
	freight_value FLOAT,
);

-- table for 'olist_order_payments_dataset' order payments data
IF OBJECT_ID('bronze.olist_order_payments_dataset', 'U') IS NOT NULL
	DROP TABLE bronze.olist_order_payments_dataset;
CREATE TABLE bronze.olist_order_payments_dataset (
	order_id VARCHAR(32),
	payment_sequential INT,
	payment_type VARCHAR(20),
	payment_installments INT,
	payment_value FLOAT
);

-- table for 'olist_order_reviews_dataset' order reviews data
IF OBJECT_ID('bronze.olist_order_reviews_dataset', 'U') IS NOT NULL
	DROP TABLE bronze.olist_order_reviews_dataset;
CREATE TABLE bronze.olist_order_reviews_dataset (
	review_id VARCHAR(32),
	order_id VARCHAR(32),
	review_score INT,
	review_comment_title VARCHAR(100),
	review_comment_message VARCHAR(500),
	review_creation_date DATETIME2,
	review_answer_timestamp DATETIME2
);

-- table for 'olist_orders_dataset' order data
IF OBJECT_ID('bronze.olist_orders_dataset', 'U') IS NOT NULL
	DROP TABLE bronze.olist_orders_dataset;
CREATE TABLE bronze.olist_orders_dataset (
	order_id VARCHAR(32),
	customer_id VARCHAR(32),
	order_status VARCHAR(15),
	order_purchase_timestamp DATE,
	order_approved_at DATE,
	order_delivered_carrier_date DATE,
	order_delivered_customer_date DATE,
	order_estimated_delivery_date DATE
);

-- table for 'olist_products_dataset' products data
IF OBJECT_ID('bronze.olist_products_dataset', 'U') IS NOT NULL
	DROP TABLE bronze.olist_products_dataset;
CREATE TABLE bronze.olist_products_dataset (
	product_id VARCHAR(32),
	product_category_name VARCHAR(100),
	product_name_lenght INT,
	product_description_lenght INT,
	product_photos_qty INT,
	product_weight_g INT,
	product_length_cm INT,
	product_height_cm INT,
	product_width_cm INT
);

-- table for 'olist_sellers_dataset' seller data
IF OBJECT_ID('bronze.olist_sellers_dataset', 'U') IS NOT NULL
	DROP TABLE bronze.olist_sellers_dataset;
CREATE TABLE bronze.olist_sellers_dataset (
	seller_id VARCHAR(32),
	seller_zip_code_prefix INT,
	seller_city VARCHAR(40),
	seller_state VARCHAR(2)
);

-- table for 'product_category_name_translation' translation table data
IF OBJECT_ID('bronze.product_category_name_translation', 'U') IS NOT NULL
	DROP TABLE bronze.product_category_name_translation;
CREATE TABLE bronze.product_category_name_translation (
	product_category_name VARCHAR(50),
	product_category_name_english VARCHAR(50)
);

