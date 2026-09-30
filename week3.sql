
-- ShopMetrics - Week 3
-- Product Analysis and Basket Recommendations

USE shopmetrics;

-- 1. Check number of products and sessions

SELECT
    COUNT(DISTINCT session_id) AS total_sessions,
    COUNT(DISTINCT product_id) AS unique_products
FROM ecommerce_events;


-- 2. Check whether sessions contain multiple products

SELECT
    session_id,
    COUNT(DISTINCT product_id) AS products_in_session
FROM ecommerce_events
GROUP BY session_id
HAVING COUNT(DISTINCT product_id) > 1
LIMIT 10;


-- 3. Top 10 purchased products

SELECT
    product_id,
    COUNT(DISTINCT session_id) AS purchase_sessions,
    SUM(quantity) AS total_quantity,
    SUM(revenue) AS total_revenue
FROM ecommerce_events
WHERE purchased = 1
GROUP BY product_id
ORDER BY purchase_sessions DESC
LIMIT 10;


-- 4. Product category analysis

SELECT
    product_category,
    COUNT(DISTINCT session_id) AS purchase_sessions,
    SUM(quantity) AS total_quantity,
    SUM(revenue) AS total_revenue
FROM ecommerce_events
WHERE purchased = 1
GROUP BY product_category
ORDER BY total_revenue DESC;


-- 5. Cart abandonment by product

SELECT
    product_id,
    COUNT(DISTINCT CASE
        WHEN added_to_cart = 1 THEN session_id
    END) AS cart_sessions,
    COUNT(DISTINCT CASE
        WHEN purchased = 1 THEN session_id
    END) AS purchase_sessions,
    COUNT(DISTINCT CASE
        WHEN added_to_cart = 1 AND purchased = 0
        THEN session_id
    END) AS abandoned_sessions
FROM ecommerce_events
GROUP BY product_id
ORDER BY abandoned_sessions DESC
LIMIT 10;


-- 6. Product pairs purchased in the same session
-- Run only if Step 2 shows sessions with multiple products

SELECT
    a.product_id AS product_1,
    b.product_id AS product_2,
    COUNT(DISTINCT a.session_id) AS sessions_together
FROM ecommerce_events a
JOIN ecommerce_events b
    ON a.session_id = b.session_id
    AND a.product_id < b.product_id
WHERE a.purchased = 1
  AND b.purchased = 1
GROUP BY a.product_id, b.product_id
ORDER BY sessions_together DESC
LIMIT 20;