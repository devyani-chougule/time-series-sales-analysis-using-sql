/*
  Which category contributes the most to overall sales?
  This query calculates the total sales per category and
  their percentage contribution to overall company sales.
*/

WITH category_sales AS (
  SELECT 
    p.category,
    SUM(s.sales_amount) AS total_sales 
  FROM master.goldfactsales AS s 
  LEFT JOIN master.product AS p
    ON p.product_key = s.product_key
  WHERE p.category IS NOT NULL
  GROUP BY p.category
)

SELECT 
  category,
  total_sales,
  SUM(total_sales) OVER () AS overall_sales,
  CONCAT(ROUND((total_sales / SUM(total_sales) OVER ()) * 100, 2), '%') AS total_percentage
FROM category_sales
ORDER BY total_sales DESC;
