-- Yearly Product Sales Trend Analysis with Window Functions
-- ----------------------------------------------------------

-- This query analyzes yearly product-level sales performance,
-- comparing against the product's average and previous year's performance.

WITH yearly_sales AS (
  SELECT 
    YEAR(f.order_date) AS order_year,
    p.product_name,
    SUM(f.sales_amount) AS current_sales
  FROM master.goldfactsales f 
  LEFT JOIN master.product p ON f.product_key = p.product_key
  WHERE f.order_date IS NOT NULL
  GROUP BY 
    YEAR(f.order_date),
    p.product_name
)

SELECT 
  order_year,
  product_name,
  current_sales,
  
  -- Average sales of the product across all years
  AVG(current_sales) OVER (PARTITION BY product_name) AS average_value,
  
  -- Difference between current year sales and product's average
  current_sales - AVG(current_sales) OVER (PARTITION BY product_name) AS average_difference,

  -- Categorizing performance against average
  CASE
    WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) > 0 THEN 'Above average'
    WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) < 0 THEN 'Lower average'
    ELSE 'Average'
  END AS category,

  -- Previous year's sales
  LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS previous_year,

  -- Year-over-year difference
  current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS difference_in_previousyear,


