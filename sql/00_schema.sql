-- ========================================
-- STAR SCHEMA: EXECUTIVE REPORTING LAYER
-- ========================================

-- ======================
-- DIMENSION TABLES
-- ======================

CREATE TABLE dim_date (
    date_id INTEGER PRIMARY KEY,
    full_date DATE,
    year INTEGER,
    quarter INTEGER,
    month INTEGER,
    week INTEGER,
    day INTEGER,
    day_name TEXT
);

CREATE TABLE dim_location (
    location_id INTEGER PRIMARY KEY,
    location_name TEXT,
    city TEXT,
    state TEXT
);

CREATE TABLE dim_product (
    product_id INTEGER PRIMARY KEY,
    product_name TEXT,
    category TEXT
);

-- ======================
-- FACT TABLE
-- ======================

CREATE TABLE fact_sales (
    sale_id INTEGER PRIMARY KEY,
    date_id INTEGER,
    location_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    unit_price DECIMAL(10,2),
    discount DECIMAL(10,2),
    total_amount DECIMAL(10,2),

    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (location_id) REFERENCES dim_location(location_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);
