# ShopMetrics — E-Commerce Funnel and Basket Analytics

SQL-based analytics project analyzing customer funnel behavior and product basket patterns using a 25,000-session synthetic e-commerce dataset.

## Tech Stack
MariaDB (XAMPP), phpMyAdmin, SQL

## Key Findings
- Overall conversion rate: 22.46%
- Cart abandonment rate: 65.15%
- Average Order Value: ₹1,801.31
- Total revenue analyzed: ₹1,01,16,169.06
- Device type and marketing channel show minimal impact on conversion (21.7%–23.6% across all segments) — cart abandonment is the primary drop-off point, not acquisition quality.

## Pipeline
1. **Week 1** — Database setup, import, and data validation (`week_1.sql`)
2. **Week 2** — Funnel and conversion analysis by device/channel (`week_2.sql`)
3. **Week 3** — Product performance and market basket analysis (`week3.sql`)

## Project Structure
ShopMetrics/
├── sql/ # week_1.sql, week_2.sql, week3.sql
├── data/ # Ecommerce.csv
└── docs/ # README and project report
