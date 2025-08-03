/*
  Group customers into three segments based on their spending behavior:
  - VIP:     At least 12 months of history and total spending > $5,000
  - Regular: At least 12 months of history and total spending ≤ $5,000
  - New:     Less than 12 months of history

  The query returns the total number of customers in each segment.
*/

WITH spending AS (
  SELECT 
    c.customer_key,
    SUM(f.sales_amount) AS total_spending,
    MIN(f.order_date) AS first_order,
    MAX(f.order_date) AS last_order,
    TIMESTAMPDIFF(MONTH, MIN(f.order_date), MAX(f.order_date)) AS lifespan
  FROM master.goldfactsales f
  LEFT JOIN master.custmor c
    ON f.customer_key = c.customer_key
  GROUP BY c.customer_key
)

SELECT 
  category,
  COUNT(customer_key) AS total_customer
FROM (
  SELECT 
    customer_key,
    lifespan,
    total_spending,
    CASE
      WHEN lifespan >= 12 AND total_spending > 5000 THEN 'VIP'
      WHEN lifespan >= 12 AND total_spending <= 5000 THEN 'Regular'
      ELSE 'New'
    END AS category
  FROM spending
) t
GROUP BY category
ORDER BY total_customer DESC;
