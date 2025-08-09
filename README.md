📊 Sales & Customer Analytics with SQL (Window Functions + Segmentation)
Project Overview
This project analyzes sales, customers, products, and categories from a retail dataset using advanced SQL queries and window functions.
The goal is to uncover sales trends, customer behavior, and product performance insights for data-driven decision-making.

Key Features
1}Yearly Product Sales Performance

---Compared each product's yearly sales to:

        * Product’s historical average sales

        * Previous year's sales

---Classified yearly performance as Above Average, Average, or Below Average.

2]Customer Segmentation by Spending & Loyalty

---Segmented customers into:

       * VIP: ≥ 12 months history & total spending > $5,000

      * Regular: ≥ 12 months history & total spending ≤ $5,000

      * New: < 12 months history

---Counted total customers in each segment.

3]Monthly Sales Trend Analysis (Window Functions)

---Calculated cumulative total sales and moving average prices over time.

---Summarized monthly sales by year/month.

4]Product Cost Range Analysis

---Grouped products into cost segments:

      *  Below $100

      *  $100–$500

      *  $500–$1000

      *  Above $1000

---Counted total products in each segment.

5]Category Sales Contribution

---Calculated total sales per category.

---Computed percentage contribution to overall company sales.

6]Yearly Category Performance

---Analyzed sales per category year-over-year.

7]Skills & Concepts Used
---SQL Window Functions:

     *  AVG() OVER for product average

     *  LAG() for previous year sales

    *   Cumulative sums & moving averages

---CASE Statements for segmentation & categorization

---CTEs (WITH clauses) for query readability


8]Insights Generated
---Identified products with consistent above-average sales growth.

---Found high-value customers driving revenue.

---Revealed seasonal trends in monthly sales.

---Discovered which product cost ranges dominate the catalog.

---Highlighted top-performing categories contributing the most to total sales.

---Date functions: YEAR(), MONTH(), DATE_FORMAT()

---Customer & product segmentation logic
