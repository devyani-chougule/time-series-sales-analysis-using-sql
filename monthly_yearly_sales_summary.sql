-- Monthly Sales Summary by Year and Month (using YEAR and MONTH)
SELECT 
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customer,
    SUM(quantity) AS total_quantity
FROM master.goldfactsales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY YEAR(order_date), MONTH(order_date);

-- Monthly Sales Summary using DATE_FORMAT (first of the month)
SELECT 
    DATE_FORMAT(order_date, '%Y-%m-01') AS order_year,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customer,
    SUM(quantity) AS total_quantity
FROM master.goldfactsales
WHERE order_date IS NOT NULL
GROUP BY DATE_FORMAT(order_date, '%Y-%m-01')
ORDER BY DATE_FORMAT(order_date, '%Y-%m-01');

-- Yearly Sales Summary using DATE_FORMAT
SELECT 
    DATE_FORMAT(col, '%Y-01-01') AS order_year,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customer,
    SUM(quantity) AS total_quantity
FROM master.goldfactsales
WHERE order_date IS NOT NULL
GROUP BY DATE_FORMAT(col, '%Y-01-01')
ORDER BY DATE_FORMAT(col, '%Y-01-01');
