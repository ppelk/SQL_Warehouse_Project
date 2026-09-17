/*
=================================================================
Data Quality Checks
=================================================================
Script Purpose:
    This script checks data quality from the following perspectives:
	- Completeness and Uniqueness
	- Business Logic
	- Referential Integrity
*/

-- =================================================================
-- COMPLETENESS AND UNIQUENESS
-- =================================================================
-- Check table 'bronze.olist_customers_dataset'
--   Check for Nulls, Duplicates and Invalid values in Primary key 'customer_id'
--   Expecatation: No Results
SELECT 
	customer_id,
	COUNT(*) count
FROM bronze.olist_customers_dataset
GROUP BY customer_id
HAVING COUNT(*) > 1 OR customer_id IS NULL OR LEN(customer_id) <> 32;

--   Check for Nulls and Invalid values in Primary key 'customer_unique_id'
--   Expecatation: No Results
SELECT 
	customer_unique_id
FROM bronze.olist_customers_dataset
WHERE customer_unique_id IS NULL OR LEN(customer_unique_id) <> 32;

-- -----------------------------------------------------------------
-- Check table 'bronze.olist_sellers_dataset'
--   Check for Nulls, Duplicates and Invalid values in Primary key 'seller_id'
--   Expectation: No Results
SELECT 
	seller_id,
	COUNT(*) count
FROM bronze.olist_sellers_dataset
GROUP BY seller_id
HAVING COUNT(*) > 1 OR seller_id IS NULL OR LEN(seller_id) <> 32;

-- -----------------------------------------------------------------
-- Check table 'bronze.olist_orders_dataset'
--   Check for Nulls, Duplicates and Invalid values in Primary key 'order_id'
--   Expectation: No Results
SELECT 
	order_id,
	COUNT(*) count
FROM bronze.olist_orders_dataset
GROUP BY order_id
HAVING COUNT(*) > 1 OR order_id IS NULL OR LEN(order_id) <> 32;

--	 Check for Nulls, Duplicates and Invalid values in key 'customer_id'
SELECT 
	order_id
FROM bronze.olist_orders_dataset
WHERE customer_id IS NULL OR LEN(customer_id) <> 32;

-- -----------------------------------------------------------------
-- Check table 'bronze.olist_reviews_dataset'
--   Check for Nulls and Invalid values in Primary key invalid 'review_id' Aand 'order_id'
--   Expectation: No Results
SELECT 
	review_id
FROM bronze.olist_order_reviews_dataset
WHERE review_id IS NULL OR LEN(review_id) <> 32 OR order_id IS NULL OR LEN(order_id) <> 32;

--   Check for Invalid values in review_score
--   Expectation: Distinct values [1,5]
SELECT DISTINCT review_score
FROM bronze.olist_order_reviews_dataset;

-- -----------------------------------------------------------------
-- Check table 'bronze.olist_products_dataset'
--   Check for multiple occurences of same 'product_id' and NULLs
--   Expectation: No Results
SELECT 
	product_id,
	COUNT(*) count
FROM bronze.olist_products_dataset
GROUP BY product_id
HAVING COUNT(*) > 1 OR product_id IS NULL;

-- -----------------------------------------------------------------
-- Check table 'bronze.olist_order_items_dataset'
--   Check for NULLs in 'order_id'
--   Expectation: No Results
SELECT 
	order_id
FROM bronze.olist_order_items_dataset
WHERE order_id IS NULL;

-- -----------------------------------------------------------------
-- Check table 'bronze.olist_geolocation_dataset'
--   Check distinct 'geolocation_state' values
--   Expectation: No NULLs, Real states
SELECT DISTINCT geolocation_state
FROM bronze.olist_geolocation_dataset;

--   Check for NULLs in 'geolocation_zip_code_prefix' values
--   Expectation: No Results
SELECT 
	geolocation_zip_code_prefix
FROM bronze.olist_geolocation_dataset
WHERE geolocation_zip_code_prefix IS NULL;

-- =================================================================
-- BUSINESS LOGIC
-- =================================================================
-- Check for Invalid Payment 'payment_value' 
--   Expectation: No Results
SELECT
	order_id,
	payment_value
FROM bronze.olist_order_payments_dataset
WHERE payment_value < 0 OR payment_value > 100000;

-- Check for Invalid Payment 'payment_type'
--   Expectation: No Results
SELECT order_id,
	payment_type
FROM bronze.olist_order_payments_dataset
WHERE payment_type NOT IN ('credit_card', 'not_defined', 'debit_card', 'boleto', 'voucher');

-- Check for Invalid Payment 'payment_installments'
--   Expectation: No Results
SELECT order_id,
	payment_type,
	payment_installments
FROM bronze.olist_order_payments_dataset
WHERE payment_installments NOT BETWEEN 0 AND 50;

-- Check for Invalid Product 'product_weight_g' values
--   Expectation: No Results
SELECT
	product_id,
	product_weight_g
FROM bronze.olist_products_dataset
WHERE product_weight_g < 0 OR product_weight_g > 100000;

-- Check for Invalid Product measurement values
--   Expectation: No Results
SELECT
	*
FROM bronze.olist_products_dataset
WHERE product_height_cm > 200 OR product_height_cm = 0;

SELECT *
FROM bronze.olist_products_dataset
WHERE product_width_cm > 200 OR product_width_cm = 0;

-- Check for Invalid Order 'order_status'
--   Expectation: No Results
SELECT order_id,
	order_status
FROM bronze.olist_orders_dataset
WHERE order_status NOT IN ('approved',
'delivered',
'created',
'invoiced',
'processing',
'unavailable',
'canceled',
'shipped');

-- Check for Timeliness
--   Expectation: 2016-2018 for this data set
SELECT	
	MIN(order_purchase_timestamp) first_purchase,
	MAX(order_purchase_timestamp) latest_purchase
FROM bronze.olist_orders_dataset;

-- Check for Order Timestamp Correctness
--   Check for NULLs
--   Expectation: No Results
SELECT 
	order_id,
	order_status
FROM bronze.olist_orders_dataset
WHERE order_purchase_timestamp IS NULL;


-- =================================================================
-- REFERENTIAL INTEGRITY
-- =================================================================
-- Customer for Order
--    Expectation: No results
SELECT 
	o.order_id,
	o.customer_id
FROM bronze.olist_orders_dataset o
LEFT JOIN bronze.olist_customers_dataset c ON o.customer_id = c.customer_id 
WHERE c.customer_id IS NULL;

-- Order for Review
--    Expectation: No results
SELECT 
	r.review_id,
	r.order_id
FROM bronze.olist_order_reviews_dataset r
LEFT JOIN bronze.olist_orders_dataset o ON r.order_id = o.order_id
WHERE o.order_id IS NULL;

-- One Payment for each Order
--    Expectation: No results
SELECT 
	o.order_id,
	o.customer_id,
	p.order_id
FROM bronze.olist_orders_dataset o
JOIN bronze.olist_order_payments_dataset p ON p.order_id = o.order_id
WHERE o.order_id IS NULL OR p.order_id IS NULL;

-- Seller for Order Item
--    Expectation: No results
SELECT 
	r.review_id,
	r.order_id
FROM bronze.olist_order_reviews_dataset r
LEFT JOIN bronze.olist_orders_dataset o ON r.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Order for Order Item
--    Expectation: No results
SELECT 
	r.review_id,
	r.order_id
FROM bronze.olist_order_reviews_dataset r
LEFT JOIN bronze.olist_orders_dataset o ON r.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Max. One Translation for Product Category
--    Expectation: No results
SELECT 
    t.product_category_name,
    COUNT(*) AS translation_count
FROM bronze.product_category_name_translation t
GROUP BY t.product_category_name
HAVING COUNT(*) <> 1;

-- Geolocation for Seller
--    Expectation: Some results are acceptable
SELECT *
FROM bronze.olist_sellers_dataset s
LEFT JOIN bronze.olist_geolocation_dataset g ON s.seller_zip_code_prefix = g.geolocation_zip_code_prefix
WHERE g.geolocation_zip_code_prefix IS NULL;

-- Geolocation for Customer
--    Expectation: Some results are acceptable
SELECT *
FROM bronze.olist_customers_dataset c
LEFT JOIN bronze.olist_geolocation_dataset g ON c.customer_zip_code_prefix = g.geolocation_zip_code_prefix
WHERE g.geolocation_zip_code_prefix IS NULL;

-- Product category name translation for product category name
--   Expectation: Some results are acceptable
SELECT *
FROM bronze.olist_products_dataset p
LEFT JOIN bronze.product_category_name_translation t ON p.product_category_name = t.product_category_name 
WHERE p.product_category_name IS NOT NULL 
	AND t.product_category_name IS NULL;

-- Check if every product has 'product_category_name' 
--   Expectation: Some results or no results
SELECT
    product_id,
    product_category_name
FROM bronze.olist_products_dataset
WHERE product_category_name IS NULL;

