/*
=============================================================
Create Gold Views and Tables
=============================================================
Script Purpose:
	This script creates tables in the 'gold' schema after
	first checking if they exist and dropping if they do.

*/
-- view 'gold.dim_customer' customer data
IF OBJECT_ID('gold.dim_customer', 'V') IS NOT NULL
	DROP VIEW gold.dim_customer;
GO
CREATE VIEW gold.dim_customer AS
WITH customer_orders AS (
	SELECT 
		c.customer_unique_id,
		COUNT(*) AS orders_customer
	FROM silver.olist_orders_dataset o
	LEFT JOIN silver.olist_customers_dataset c
		ON o.customer_id = c.customer_id
	GROUP BY c.customer_unique_id
)
SELECT 
	ROW_NUMBER() OVER (ORDER BY c.customer_id) AS customer_key,
	c.customer_id AS customer_id,
	c.customer_unique_id AS customer_unique_id,
	co.orders_customer,
	c.customer_zip_code_prefix AS customer_zip_code_prefix,
	c.customer_city AS customer_city,
	c.customer_state AS customer_state,
	CASE
		WHEN customer_state IN ('AC', 'AP', 'AM', 'PA', 'RO', 'RR', 'TO')
			THEN 'North'
		WHEN customer_state IN ('AL', 'BA', 'CE', 'MA', 'PB', 'PE', 'PI', 'RN', 'SE')
			THEN 'Northeast'
		WHEN customer_state IN ('DF', 'GO', 'MS', 'MT')
			THEN 'Central-West'
		WHEN customer_state IN ('ES', 'MG', 'RJ', 'SP')
			THEN 'Southeast'
		WHEN customer_state IN ('PR', 'RS', 'SC')
			THEN 'South'
		ELSE 'Unknown'
	END AS customer_region
FROM silver.olist_customers_dataset c
LEFT JOIN customer_orders co
	ON c.customer_unique_id = co.customer_unique_id;
GO

-- view 'gold.dim_product' product data
IF OBJECT_ID('gold.dim_product', 'V') IS NOT NULL
	DROP VIEW gold.dim_product;
GO
CREATE VIEW gold.dim_product AS
SELECT 
	ROW_NUMBER() OVER (ORDER BY product_id) AS product_key,
	p.product_id,
	CASE 
		WHEN t.product_category_name_english IS NULL AND t.product_category_name IS NOT NULL
			THEN p.product_category_name
		WHEN t.product_category_name_english IS NULL AND t.product_category_name IS NULL
			THEN 'unknown'
		ELSE t.product_category_name_english
	END AS category_name,
	p.product_name_length,
    p.product_description_length,
    p.product_photos_qty,
    p.product_weight_kg,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm
FROM silver.olist_products_dataset p
LEFT JOIN silver.product_category_name_translation t
	ON p.product_category_name = t.product_category_name;
GO
-- view 'gold.fact_order' order data
IF OBJECT_ID('gold.fact_order', 'V') IS NOT NULL
	DROP VIEW gold.fact_order;
GO
CREATE VIEW gold.fact_order AS
WITH order_value AS (
	SELECT 
		oi.order_id,
		SUM(oi.price) + SUM(oi.freight_value) AS order_value
	FROM silver.olist_order_items_dataset oi
	GROUP BY oi.order_id
)
SELECT 
	ROW_NUMBER() OVER (ORDER BY o.order_id) AS order_key,
	o.order_id AS order_id,
	o.customer_id AS customer_id,
	c.customer_key AS customer_key,
	o.order_status AS order_status,
	ov.order_value AS order_value,
	o.order_approved_at AS order_approved_at,
	o.order_delivered_carrier_date AS delivered_carrier,
	o.order_delivered_customer_date AS delivered_customer,
	o.order_estimated_delivery_date AS estimated_delivery,
	DATEDIFF(DAY, order_purchase_timestamp, order_delivered_customer_date) AS delivery_days,
	DATEDIFF(DAY, order_estimated_delivery_date, order_delivered_customer_date) AS delivery_delay_days
FROM silver.olist_orders_dataset o
LEFT JOIN gold.dim_customer c
	ON o.customer_id = c.customer_id
LEFT JOIN order_value ov
	ON o.order_id = ov.order_id;
GO

-- view 'gold.fact_order_item' order data
IF OBJECT_ID('gold.fact_order_item', 'V') IS NOT NULL
	DROP VIEW gold.fact_order_item;
GO
CREATE VIEW gold.fact_order_item AS
SELECT 
	--ROW_NUMBER() OVER (ORDER BY order_id) AS order_key,
	o.order_item_id AS item_id,
	fo.order_key AS order_key,
	o.product_id AS product_id,
	o.seller_id AS seller_id,
	o.shipping_limit_date AS shipping_limit_date,
	o.price AS price,
	o.freight_value AS freight_value,
	p.product_weight_kg AS product_weight_kg,
	p.category_name AS category_name
FROM silver.olist_order_items_dataset o
LEFT JOIN silver.olist_orders_dataset od
	ON o.order_id = od.order_id
LEFT JOIN gold.fact_order fo
    ON o.order_id = fo.order_id
LEFT JOIN gold.dim_product p
	ON o.product_id = p.product_id;
GO

-- view 'gold.dim_seller' order data
IF OBJECT_ID('gold.dim_seller', 'V') IS NOT NULL
	DROP VIEW gold.dim_seller;
GO
CREATE VIEW gold.dim_seller AS
SELECT 
	ROW_NUMBER() OVER (ORDER BY seller_id) AS seller_key,
	s.seller_id AS seller_id,
	s.seller_zip_code_prefix AS zip_code,
	s.seller_city AS seller_city,
	s.seller_state AS seller_state
FROM silver.olist_sellers_dataset s;
GO

-- table 'gold.dim_date' date data
IF OBJECT_ID('gold.dim_date', 'U') IS NOT NULL
    DROP TABLE gold.dim_date;
GO
CREATE TABLE gold.dim_date (
	date_key INT PRIMARY KEY,
	full_date DATE,
	year INT,
	quarter INT,
	month INT,
	month_name VARCHAR(20),
	week INT,
	day INT,
	day_of_week INT,
	day_name VARCHAR(20),
	is_weekend INT
);
-- Declare date range
DECLARE @min_date DATE;
DECLARE @max_date DATE;
SELECT
	@min_date = CAST(MIN(order_purchase_timestamp) AS DATE),
	@max_date = CAST(
		DATEADD(MONTH, 4, MAX(order_purchase_timestamp))
		AS DATE
	)
FROM silver.olist_orders_dataset;
-- Insert into table
WITH date_range AS (
	SELECT @min_date AS date_value	
	UNION ALL
	SELECT DATEADD(DAY, 1, date_value)
	FROM date_range
	WHERE date_value < @max_date
)
INSERT INTO gold.dim_date (
	date_key,
    full_date,
    year,
    quarter,
    month,
    month_name,
    week,
    day,
    day_of_week,
    day_name,
    is_weekend
)
SELECT
    YEAR(date_value) * 10000
        + MONTH(date_value) * 100
        + DAY(date_value) AS date_key,
    date_value AS full_date,
    YEAR(date_value) AS year,
    DATEPART(QUARTER, date_value) AS quarter,
    MONTH(date_value) AS month,
    DATENAME(MONTH, date_value) AS month_name,
    DATEPART(WEEK, date_value) AS week,
    DAY(date_value) AS day,
    DATEPART(WEEKDAY, date_value) AS day_of_week,
    DATENAME(WEEKDAY, date_value) AS day_name,
    CASE
        WHEN DATEPART(WEEKDAY, date_value) IN (1, 7)
            THEN 1
        ELSE 0
    END AS is_weekend
FROM date_range
OPTION (MAXRECURSION 0);
GO
