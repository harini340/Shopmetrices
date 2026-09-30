-- ShopMetrics - Week 1
-- Database setup and initial data analysis

-- 1. Create database
CREATE DATABASE IF NOT EXISTS shopmetrics;

-- 2. Select database
USE shopmetrics;

-- 3. Preview first 10 records
SELECT *
FROM ecommerce_events
LIMIT 10;

-- 4. Count total records
SELECT COUNT(*) AS total_records
FROM ecommerce_events;

-- 5. View table structure
DESCRIBE ecommerce_events;

-- 6. Count unique customers
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM ecommerce_events;

-- 7. Count unique sessions
SELECT COUNT(DISTINCT session_id) AS total_sessions
FROM ecommerce_events;

-- 8. Count purchase sessions
SELECT COUNT(DISTINCT session_id) AS purchase_sessions
FROM ecommerce_events
WHERE purchased = 1;

-- 9. Calculate total revenue from purchased sessions
SELECT SUM(revenue) AS total_revenue
FROM ecommerce_events
WHERE purchased = 1;

-- 10. Calculate average order value
SELECT
    SUM(revenue) /
    NULLIF(COUNT(DISTINCT CASE
        WHEN purchased = 1 THEN session_id
    END), 0) AS average_order_value
FROM ecommerce_events
WHERE purchased = 1;

-- 11. Calculate session conversion rate
SELECT
    COUNT(DISTINCT CASE
        WHEN purchased = 1 THEN session_id
    END) * 100.0 /
    NULLIF(COUNT(DISTINCT session_id), 0)
    AS conversion_rate_percent
FROM ecommerce_events;

-- 12. Calculate cart abandonment rate
SELECT
    COUNT(DISTINCT CASE
        WHEN added_to_cart = 1 AND purchased = 0 THEN session_id
    END) * 100.0 /
    NULLIF(COUNT(DISTINCT CASE
        WHEN added_to_cart = 1 THEN session_id
    END), 0) AS cart_abandonment_percent
FROM ecommerce_events;

-- 13. Check missing values
SELECT
    SUM(customer_id IS NULL) AS missing_customers,
    SUM(session_id IS NULL) AS missing_sessions,
    SUM(product_id IS NULL) AS missing_products,
    SUM(visit_date IS NULL) AS missing_dates,
    SUM(revenue IS NULL) AS missing_revenue
FROM ecommerce_events;

-- 14. Check duplicate session IDs
SELECT
    session_id,
    COUNT(*) AS records
FROM ecommerce_events
GROUP BY session_id
HAVING COUNT(*) > 1
LIMIT 20;

-- 15. Check dataset date range
SELECT
    MIN(STR_TO_DATE(visit_date, '%d-%m-%Y')) AS first_date,
    MAX(STR_TO_DATE(visit_date, '%d-%m-%Y')) AS last_date
FROM ecommerce_events;