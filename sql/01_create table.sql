CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    product_category VARCHAR(50) NOT NULL,
    product_cost NUMERIC(10,2) NOT NULL,
    product_price NUMERIC(10,2) NOT NULL,

    CONSTRAINT chk_product_cost
        CHECK (product_cost >= 0),

    CONSTRAINT chk_product_price
        CHECK (product_price >= 0)
);

CREATE TABLE stores (
    store_id INTEGER PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    store_city VARCHAR(50) NOT NULL,
    store_location VARCHAR(100) NOT NULL,
    store_open_date DATE NOT NULL
);

CREATE TABLE calendar (
    date DATE PRIMARY KEY
);


CREATE TABLE sales (
    sale_id INTEGER PRIMARY KEY,

    sale_date DATE NOT NULL,

    store_id INTEGER NOT NULL,

    product_id INTEGER NOT NULL,

    units INTEGER NOT NULL,

    CONSTRAINT chk_units
        CHECK (units > 0),

    CONSTRAINT fk_sales_store
        FOREIGN KEY (store_id)
        REFERENCES stores(store_id),

    CONSTRAINT fk_sales_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    CONSTRAINT fk_sales_date
        FOREIGN KEY (sale_date)
        REFERENCES calendar(date)
);


CREATE TABLE inventory (

    store_id INTEGER NOT NULL,

    product_id INTEGER NOT NULL,

    stock_on_hand INTEGER NOT NULL,

    CONSTRAINT pk_inventory
        PRIMARY KEY (store_id, product_id),

    CONSTRAINT fk_inventory_store
        FOREIGN KEY (store_id)
        REFERENCES stores(store_id),

    CONSTRAINT fk_inventory_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id),

    CONSTRAINT chk_stock
        CHECK (stock_on_hand >= 0)
);

