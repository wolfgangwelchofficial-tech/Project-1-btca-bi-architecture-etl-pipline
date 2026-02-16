-- =========================================================
-- SAMPLE QUERIES (EXECUTIVE DEEP DIVE)
-- Purpose: Demonstrate how the governed views can be used
-- =========================================================

-- 1) Weekly revenue trend
SELECT *
FROM vw_weekly_revenue;

-- 2) Category product mix for a specific week
-- Replace the year/week values as needed
SELECT
  year,
  week,
  category,
  category_revenue,
  total_revenue,
  product_mix_pct
FROM vw_category_product_mix
WHERE year = 2026 AND week = 1
ORDER BY product_mix_pct DESC;

-- 3) Revenue per transaction (weekly)
SELECT *
FROM vw_revenue_per_transaction;

-- 4) Top products by revenue (directly from fact table)
SELECT
  p.product_name,
  p.category,
  SUM(s.total_amount) AS revenue
FROM fact_sales s
JOIN dim_product p
  ON s.product_id = p.product_id
GROUP BY
  p.product_name,
  p.category
ORDER BY revenue DESC;
