USE sales;
SELECT d.year, d.month_name, EXTRACT(MONTH FROM d.date) AS month_number, COUNT(*) AS total_orders
FROM transactions t
JOIN date d ON t.order_date = d.date
GROUP BY d.year, d.month_name, month_number
ORDER BY d.year, month_number;

SELECT p.product_type, SUM(t.sales_qty) AS total_quantity
FROM transactions t
JOIN products p ON t.product_code = p.product_code
GROUP BY p.product_type
ORDER BY total_quantity DESC;

SELECT c.customer_type, SUM(t.sales_qty) AS total_sales
FROM transactions t
JOIN customers c ON t.customer_code = c.customer_code
GROUP BY c.customer_type
ORDER BY total_sales DESC;

SELECT m.zone, SUM(t.sales_qty) AS total_sales
FROM transactions t
JOIN markets m ON t.market_code = m.markets_code
GROUP BY m.zone
ORDER BY total_sales DESC;

SELECT d.year, SUM(t.sales_qty) AS yearly_sales
FROM transactions t
JOIN date d ON t.order_date = d.date
GROUP BY d.year
ORDER BY d.year;

SELECT t.product_code, SUM(t.sales_qty) AS total_sales
FROM transactions t
GROUP BY t.product_code
ORDER BY total_sales DESC
LIMIT 5;

SELECT m.markets_name, COUNT(*) AS total_orders
FROM transactions t
JOIN markets m ON t.market_code = m.markets_code
GROUP BY m.markets_name
ORDER BY total_orders DESC;

SELECT c.custmer_name, SUM(t.sales_qty) AS total_purchased
FROM transactions t
JOIN customers c ON t.customer_code = c.customer_code
GROUP BY c.custmer_name
ORDER BY total_purchased DESC
LIMIT 5;

SELECT c.customer_type, AVG(t.sales_qty) AS avg_order_qty
FROM transactions t
JOIN customers c ON t.customer_code = c.customer_code
GROUP BY c.customer_type;

SELECT product_code, total_sales
FROM (
  SELECT product_code, SUM(sales_qty) AS total_sales
  FROM transactions
  GROUP BY product_code
) AS product_sales
WHERE total_sales > (
  SELECT AVG(sales_qty) FROM transactions
);


SELECT t.order_date, c.custmer_name, p.product_type, m.zone, t.sales_qty
FROM transactions t
JOIN customers c ON t.customer_code = c.customer_code
JOIN products p ON t.product_code = p.product_code
JOIN markets m ON t.market_code = m.markets_code
LIMIT 100;

SELECT t.*, p.product_type
FROM transactions t
LEFT JOIN products p ON t.product_code = p.product_code;


CREATE VIEW monthly_product_sales AS
SELECT d.year, d.month_name, p.product_type, SUM(t.sales_qty) AS total_qty
FROM transactions t
JOIN date d ON t.order_date = d.date
JOIN products p ON t.product_code = p.product_code
GROUP BY d.year, d.month_name, p.product_type;


CREATE INDEX dx_order_date ON transactions(order_date);

SELECT d.month_name, SUM(t.sales_qty) AS total_sales
FROM transactions t
JOIN date d ON t.order_date = d.date
WHERE d.year = 2022
GROUP BY d.month_name
ORDER BY FIELD(d.month_name, 'January', 'February', 'March', 'April', 'May', 
                'June', 'July', 'August', 'September', 'October', 'November', 'December');








