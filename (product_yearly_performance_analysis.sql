/*
  Analyze the yearly performance of products by comparing their
  sales to both the average sales performance of the product and
  the previous year’s sales.
*/

WITH yearly_product AS (
  SELECT 
    YEAR(s.order_date) AS order_year,
    SUM(s.sales_amount) AS current_sales,
    p.product_name
  FROM master.goldfactsales AS s
  LEFT JOIN master.product AS p
    ON s.product_key = p.product_key
  WHERE s.order_date IS NOT NULL
  GROUP BY 
    YEAR(s.order_date),
    p.product_name
)

SELECT
  order_year,
  current_sales,
  product_name,

  -- Average sales of this product across all years
  AVG(current_sales) OVER (PARTITION BY product_name) AS average_sales,

  -- Difference from average
  current_sales - AVG(current_sales) OVER (PARTITION BY product_name) AS difference_average,

  -- Sales category based on average
  CASE 
    WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) > 0 THEN 'Above average'
    WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) < 0 THEN 'Below average'
    ELSE 'Average'
  END AS category,

  -- Previous year’s sales
  LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS previous_year_sales,

  -- Difference from previous year
  current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS difference_previous_year,

  -- Sales trend compared to previous year
  CASE
    WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increase'
    WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) < 0 THEN 'Decrease'
    ELSE 'No change'
  END AS previous_sales_change

FROM yearly_product
ORDER BY product_name, order_year;
