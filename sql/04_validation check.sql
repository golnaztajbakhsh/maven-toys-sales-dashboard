
SELECT *
FROM products
WHERE product_price < 0;


SELECT * FROM inventory
WHERE stock_on_hand < 0;

SELECT * FROM sales
WHERE units < 0;



SELECT
    product_id,
    COUNT(*) AS duplicate_count
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;

SELECT
    store_id,
    COUNT(*) AS duplicate_count
FROM stores
GROUP BY store_id
HAVING COUNT(*) > 1;

SELECT
    date,
    COUNT(*) AS duplicate_count
FROM calendar
GROUP BY date
HAVING COUNT(*) > 1;


SELECT
    sale_id,
    COUNT(*) AS duplicate_count
FROM sales
GROUP BY sale_id
HAVING COUNT(*) > 1;

SELECT
    store_id,
    product_id,
    COUNT(*) AS duplicate_count
FROM inventory
GROUP BY store_id, product_id
HAVING COUNT(*) > 1;

SELECT
COUNT(*) FILTER (WHERE product_id IS NULL) AS null_product_id,
COUNT(*) FILTER (WHERE product_name IS NULL) AS null_product_name,
COUNT(*) FILTER (WHERE product_cost IS NULL) AS null_product_cost,
COUNT(*) FILTER (WHERE product_price IS NULL) AS null_product_price
FROM products;


SELECT
    COUNT(*) FILTER (WHERE store_id IS NULL) AS null_store_id,
    COUNT(*) FILTER (WHERE store_name IS NULL) AS null_store_name,
    COUNT(*) FILTER (WHERE store_city IS NULL) AS null_store_city,
    COUNT(*) FILTER (WHERE store_location IS NULL) AS null_store_location,
    COUNT(*) FILTER (WHERE store_open_date IS NULL) AS null_store_open_date
FROM stores;


SELECT
    COUNT(*) FILTER (WHERE date IS NULL) AS null_date
FROM calendar;



SELECT
    COUNT(*) FILTER (WHERE sale_id IS NULL) AS null_sale_id,
    COUNT(*) FILTER (WHERE sale_date IS NULL) AS null_sale_date,
    COUNT(*) FILTER (WHERE store_id IS NULL) AS null_store_id,
    COUNT(*) FILTER (WHERE product_id IS NULL) AS null_product_id,
    COUNT(*) FILTER (WHERE units IS NULL) AS null_units
FROM sales;

SELECT
    COUNT(*) FILTER (WHERE store_id IS NULL) AS null_store_id,
    COUNT(*) FILTER (WHERE product_id IS NULL) AS null_product_id,
    COUNT(*) FILTER (WHERE stock_on_hand IS NULL) AS null_stock_on_hand
FROM inventory;



SELECT store_id, product_id, COUNT(*)
FROM vw_inventory_analysis
GROUP BY store_id, product_id
HAVING COUNT(*) > 1;