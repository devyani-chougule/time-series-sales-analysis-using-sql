-- Monthly Sales Trend Analysis with Window Functions
-- --------------------------------------------------

-- This query summarizes monthly total sales and average price,
-- and then applies window functions to calculate cumulative totals
-- and moving average prices over time.

SELECT
  order_date_information,
  YEAR(order_date_information) AS order_year,
  MONTH(order_date_information) AS order_month_number,
  DATE_FORMAT(order_date_information, '%b') AS order_month_name,
  total_sales,
  SUM(total_sales) OVER (
    ORDER BY YEAR(order_date_information), MONTH(order_date_information)
  ) AS current_total_sales,
  ROUND(AVG(average_price) OVER (
    ORDER BY YEAR(order_date_information), MONTH(order_date_information)
  ), 2) AS moving_total_price
FROM (
  SELECT 
    DATE_FORMAT(order_date, '%Y-%m-01') AS order_date_information,
    SUM(sales_amount) AS total_sales,
    AVG(price) AS average_price 
  FROM master.goldfactsales
  WHERE order_date IS NOT NULL
  GROUP BY DATE_FORMAT(order_date, '%Y-%m-01')
) t;
