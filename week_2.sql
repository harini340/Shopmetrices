-- ShopMetrics - Week 2
-- Conversion and Cart Abandonment Analysis

USE shopmetrics;

-- 1. Conversion Funnel
-- Total sessions, cart sessions, and purchase sessions

SELECT
    COUNT(DISTINCT session_id) AS total_sessions,
    COUNT(DISTINCT CASE
        WHEN added_to_cart = 1 THEN session_id
    END) AS cart_sessions,
    COUNT(DISTINCT CASE
        WHEN purchased = 1 THEN session_id
    END) AS purchase_sessions
FROM ecommerce_events;


-- 2. Funnel Percentages
-- Cart rate and overall conversion rate

SELECT
    COUNT(DISTINCT CASE
        WHEN added_to_cart = 1 THEN session_id
    END) * 100.0 /
    NULLIF(COUNT(DISTINCT session_id), 0)
    AS cart_rate_percent,

    COUNT(DISTINCT CASE
        WHEN purchased = 1 THEN session_id
    END) * 100.0 /
    NULLIF(COUNT(DISTINCT session_id), 0)
    AS conversion_rate_percent
FROM ecommerce_events;


-- 3. Cart Abandonment Rate

SELECT
    COUNT(DISTINCT CASE
        WHEN added_to_cart = 1 THEN session_id
    END) AS cart_sessions,

    COUNT(DISTINCT CASE
        WHEN added_to_cart = 1
         AND purchased = 0 THEN session_id
    END) AS abandoned_sessions,

    COUNT(DISTINCT CASE
        WHEN added_to_cart = 1
         AND purchased = 0 THEN session_id
    END) * 100.0 /
    NULLIF(
        COUNT(DISTINCT CASE
            WHEN added_to_cart = 1 THEN session_id
        END), 0
    ) AS abandonment_rate_percent
FROM ecommerce_events;


-- 4. Conversion Rate by Device

SELECT
    device_type,
    COUNT(DISTINCT session_id) AS total_sessions,
    COUNT(DISTINCT CASE
        WHEN purchased = 1 THEN session_id
    END) AS purchase_sessions,
    COUNT(DISTINCT CASE
        WHEN purchased = 1 THEN session_id
    END) * 100.0 /
    NULLIF(COUNT(DISTINCT session_id), 0)
    AS conversion_rate_percent
FROM ecommerce_events
GROUP BY device_type
ORDER BY conversion_rate_percent DESC;


-- 5. Conversion Rate by Marketing Channel

SELECT
    marketing_channel,
    COUNT(DISTINCT session_id) AS total_sessions,
    COUNT(DISTINCT CASE
        WHEN purchased = 1 THEN session_id
    END) AS purchase_sessions,
    COUNT(DISTINCT CASE
        WHEN purchased = 1 THEN session_id
    END) * 100.0 /
    NULLIF(COUNT(DISTINCT session_id), 0)
    AS conversion_rate_percent
FROM ecommerce_events
GROUP BY marketing_channel
ORDER BY conversion_rate_percent DESC;


-- 6. Cart Abandonment by Marketing Channel

SELECT
    marketing_channel,
    COUNT(DISTINCT CASE
        WHEN added_to_cart = 1 THEN session_id
    END) AS cart_sessions,

    COUNT(DISTINCT CASE
        WHEN added_to_cart = 1
         AND purchased = 0 THEN session_id
    END) AS abandoned_sessions,

    COUNT(DISTINCT CASE
        WHEN added_to_cart = 1
         AND purchased = 0 THEN session_id
    END) * 100.0 /
    NULLIF(
        COUNT(DISTINCT CASE
            WHEN added_to_cart = 1 THEN session_id
        END), 0
    ) AS abandonment_rate_percent
FROM ecommerce_events
GROUP BY marketing_channel
ORDER BY abandonment_rate_percent DESC;


-- 7. Monthly Conversion Rate

SELECT
    DATE_FORMAT(
        STR_TO_DATE(visit_date, '%d-%m-%Y'),
        '%Y-%m'
    ) AS visit_month,

    COUNT(DISTINCT session_id) AS total_sessions,

    COUNT(DISTINCT CASE
        WHEN purchased = 1 THEN session_id
    END) AS purchase_sessions,

    COUNT(DISTINCT CASE
        WHEN purchased = 1 THEN session_id
    END) * 100.0 /
    NULLIF(COUNT(DISTINCT session_id), 0)
    AS conversion_rate_percent
FROM ecommerce_events
GROUP BY visit_month
ORDER BY visit_month;