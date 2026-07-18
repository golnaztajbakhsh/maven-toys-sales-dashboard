CREATE VIEW vw_sales_analysis AS
SELECT
    s.sale_id,
    s.sale_date,
    s.store_id,
    s.product_id,

    st.store_name,
    st.store_city,
    st.store_location,

    p.product_name,
    p.product_category,
    p.product_cost,
    p.product_price,

    s.units,

    (s.units * p.product_price) AS revenue,

    ((p.product_price - p.product_cost) * s.units) AS profit

FROM sales s
JOIN products p
    ON s.product_id = p.product_id
JOIN stores st
    ON s.store_id = st.store_id;
	
	
CREATE VIEW vw_store_kpis AS
WITH store_kpis AS (
    SELECT
        store_name,
        store_city,
        SUM(revenue) AS total_revenue,
        SUM(profit) AS total_profit,
        SUM(units) AS total_units_sold
    FROM vw_sales_analysis
    GROUP BY store_name, store_city
)
SELECT
    store_name,
    store_city,
    total_revenue,
    total_profit,
    total_units_sold,
    RANK() OVER (ORDER BY total_profit DESC) AS profit_rank,
    RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM store_kpis;



CREATE VIEW vw_product_kpis AS
WITH product_kpis AS (
    SELECT
        product_id,
        product_name,
        product_category,
        SUM(revenue) AS total_revenue,
        SUM(profit) AS total_profit,
        SUM(units) AS total_units_sold
    FROM vw_sales_analysis
    GROUP BY product_id, product_name, product_category
)
SELECT
    product_id,
    product_name,
    product_category,
    total_revenue,
    total_profit,
    total_units_sold,
	RANK() OVER (ORDER BY total_profit DESC) AS profit_rank,
    RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank,
    RANK() OVER (ORDER BY total_units_sold DESC) AS units_rank
FROM product_kpis;




CREATE VIEW vw_category_kpis AS 
WITH category_kpis AS (
    SELECT
        product_category,

        SUM(revenue) AS total_revenue,
        SUM(profit) AS total_profit,
        SUM(units) AS total_units_sold

    FROM vw_sales_analysis

    GROUP BY product_category
)

SELECT
    product_category,

    total_revenue,
    total_profit,
    total_units_sold,

    RANK() OVER (ORDER BY total_profit DESC) AS profit_rank,

    RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank,

    RANK() OVER (ORDER BY total_units_sold DESC) AS units_rank

FROM category_kpis;




CREATE VIEW vw_inventory_analysis AS

WITH sales_by_store_product AS (
    SELECT
        store_id,
        product_id,
        SUM(units) AS total_units_sold,
        SUM(revenue) AS total_revenue,
        SUM(profit) AS total_profit
    FROM vw_sales_analysis
    GROUP BY
        store_id,
        product_id
)

SELECT
    i.store_id,
    st.store_name,

    i.product_id,
    p.product_name,
    p.product_category,

    i.stock_on_hand,

    COALESCE(s.total_units_sold, 0) AS total_units_sold,
    COALESCE(s.total_revenue, 0) AS total_revenue,
    COALESCE(s.total_profit, 0) AS total_profit,

    p.product_cost,
    p.product_price

FROM inventory i

JOIN stores st
    ON i.store_id = st.store_id

JOIN products p
    ON i.product_id = p.product_id

LEFT JOIN sales_by_store_product s
    ON i.store_id = s.store_id
   AND i.product_id = s.product_id;	
	