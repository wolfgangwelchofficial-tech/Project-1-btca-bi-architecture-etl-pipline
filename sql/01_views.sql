-- ========================================
-- EXECUTIVE KPI VIEWS (GOVERNED METRICS)
-- ========================================

-- 1) Weekly Revenue
-- Definition: Total revenue generated during a calendar week
CREATE VIEW vw_weekly_revenue AS
SELECT
    d.year,
    d.week,
    SUM(s.total_amount) AS weekly_revenue
FROM fact_sales s
JOIN dim_date d
    ON s.date_id = d.date_id
GROUP BY
    d.year,
    d.week
ORDER BY
    d.year,
    d.week;

-- 2) Product Mix % (by category)
-- Definition: Category revenue / total revenue for the period
CREATE VIEW vw_category_product_mix AS
WITH category_revenue AS (
    SELECT
        d.year,
        d.week,
        p.category,
        SUM(s.total_amount) AS category_revenue
    FROM fact_sales s
    JOIN dim_date d
        ON s.date_id = d.date_id
    JOIN dim_product p
        ON s.product_id = p.product_id
    GROUP BY
        d.year,
        d.week,
        p.category
),
total_revenue AS (
    SELECT
        year,
        week,
        SUM(category_revenue) AS total_revenue
    FROM category_revenue
    GROUP BY
        year,
        week
)
SELECT
    cr.year,
    cr.week,
    cr.category,
    cr.category_revenue,
    tr.total_revenue,
    CASE
        WHEN tr.total_revenue = 0 THEN 0
        ELSE (cr.category_revenue * 1.0) / tr.total_revenue
    END AS product_mix_pct
FROM category_revenue cr
JOIN total_revenue tr
    ON cr.year = tr.year
   AND cr.week = tr.week
ORDER BY
    cr.year,
    cr.week,
    cr.category;

-- 3) Revenue per Transaction
-- Definition: Total revenue / number of sales (transactions)
CREATE VIEW vw_revenue_per_transaction AS
SELECT
    d.year,
    d.week,
    SUM(s.total_amount) AS total_revenue,
    COUNT(s.sale_id) AS transaction_count,
    CASE
        WHEN COUNT(s.sale_id) = 0 THEN 0
        ELSE (SUM(s.total_amount) * 1.0) / COUNT(s.sale_id)
    END AS revenue_per_transaction
FROM fact_sales s
JOIN dim_date d
    ON s.date_id = d.date_id
GROUP BY
    d.year,
    d.week
ORDER BY
    d.year,
    d.week;
