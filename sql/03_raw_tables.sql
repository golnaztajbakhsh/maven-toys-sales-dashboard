
CREATE TABLE products_raw (
    product_id INTEGER,
    product_name VARCHAR(100),
    product_category VARCHAR(50),
    product_cost TEXT,
    product_price TEXT
);

COPY products_raw
FROM 'F:/Maven+Toys/Maven Toys Data/products.csv'
DELIMITER ','
CSV HEADER;

INSERT INTO products (
    product_id,
    product_name,
    product_category,
    product_cost,
    product_price
)
SELECT
    product_id,
    product_name,
    product_category,
    REPLACE(product_cost, '$', '')::NUMERIC(10,2),
    REPLACE(product_price, '$', '')::NUMERIC(10,2)
FROM products_raw;



CREATE TABLE stores_raw (
    store_id INTEGER,
    store_name VARCHAR(100),
    store_city VARCHAR(50),
    store_location VARCHAR(100),
    store_open_date DATE
);


COPY stores_raw
FROM 'F:/Maven+Toys/Maven Toys Data/stores.csv'
DELIMITER ','
CSV HEADER;


INSERT INTO stores
SELECT *
FROM stores_raw;


CREATE TABLE calendar_raw (
    date DATE
);

COPY calendar_raw
FROM 'F:/Maven+Toys/Maven Toys Data/calendar.csv'
DELIMITER ','
CSV HEADER;

INSERT INTO calendar
SELECT *
FROM calendar_raw;


CREATE TABLE sales_raw (
    sale_id INTEGER,
    sale_date DATE,
    store_id INTEGER,
    product_id INTEGER,
    units INTEGER
);


COPY sales_raw
FROM 'F:/Maven+Toys/Maven Toys Data/sales.csv'
DELIMITER ','
CSV HEADER;

INSERT INTO sales
SELECT *
FROM sales_raw;



CREATE TABLE inventory_raw (
    store_id INTEGER,
    product_id INTEGER,
    stock_on_hand INTEGER
);

COPY inventory_raw
FROM 'F:/Maven+Toys/Maven Toys Data/inventory.csv'
DELIMITER ','
CSV HEADER;

INSERT INTO inventory
SELECT *
FROM inventory_raw;

