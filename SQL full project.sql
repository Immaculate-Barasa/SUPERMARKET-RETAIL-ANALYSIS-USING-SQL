--SECTION ONE
--show all coliumns from customers TABLE
SELECT *
FROM customers;

--full name and city of customers, order by city alphabetically
SELECT full_name, city
FROM customers
ORDER BY city ASC;

--top 5 most expensive products, show product name and unit price
SELECT product_name, unit_price
FROM products
ORDER BY unit_price DESC
LIMIT 5;

--all orders where payment method was mpesa
SELECT *
FROM orders
WHERE payment_method = 'M-Pesa';

--show all female customers who signed up after 1/7/2023
--display full name, city, sign up date
SELECT full_name, city, signup_date
FROM customers
WHERE gender = 'Female' AND signup_date > '2023-07-01';

--all products from beverages, sorted by price ASC
SELECT product_name, unit_price
FROM products
WHERE category = 'Beverages'
ORDER BY unit_price ASC;

--first 10 orders placed, their order id, order date, status
SELECT order_id, order_date, status
FROM orders
ORDER BY order_date ASC;

--SECTION TWO ANALYSIS
--how many customers in the database
SELECT COUNT(customer_id)
FROM customers;

--customers from each city, show city and count DESC
SELECT city, COUNT(customer_id) as total_customers 
FROM customers
GROUP BY city
ORDER BY total_customers DESC;

--average price of all products
SELECT AVG(unit_price) as averageprice
FROM products;

--orders per payment method
SELECT payment_method, COUNT(order_id) as totalorders
FROM orders
GROUP BY payment_method;

--total quantity sold per product
SELECT p.product_name, COUNT(oi.order_id) as totalquantity
FROM order_items oi
JOIN products p ON p.product_id = oi.product_id
GROUP BY p.product_name;

SELECT product_id, COUNT(order_id) as totalquantity
FROM order_items 
GROUP BY product_id;

--cities with more than 3 customers
SELECT city, COUNT(*) as totalcustomers
FROM customers
GROUP BY city
HAVING COUNT(*) > 3;

--show each status and order count
SELECT status, COUNT(*) as ordercount
FROM orders
GROUP BY status;

--total revenue generated from order items
SELECT ROUND(SUM(quantity * unit_price),2) as revenue
FROM order_items;

--SECTION 3 JOINS
--show each order alongside customers name and city
SELECT c.full_name, c.city, o.order_id, o.order_date
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;

--count of orders from each city
SELECT c.city, COUNT(o.order_id) as total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY total_orders DESC;

--list all order items, show product_name,quantity, unit_price,item_id, order_id
SELECT p.product_name, oi.quantity, oi.unit_price, oi.item_id, oi.order_id
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id;

--customers with 3 or more orders
SELECT c.full_name, COUNT(o.customer_id) as ordercount
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.full_name
HAVING COUNT(*) >= 3
ORDER BY ordercount DESC;

--show each order alongside staff who processed it
--display order_id, order_date, customer name, staff name, department
SELECT c.full_name, s.full_name, s.department, o.order_id, o.order_date
FROM staff s
JOIN orders o ON s.staff_id = o.staff_id
JOIN customers c ON c.customer_id = o.customer_id;

--revenue generated for each product category
SELECT p.category, SUM(oi.quantity * oi.unit_price) as category_revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY category_revenue DESC;
