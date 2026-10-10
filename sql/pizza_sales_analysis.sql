-- Pizza Sales Analysis | PostgreSQL
-- Dataset: orders, order_details, pizzas, pizza_types
-- Run after importing the four CSV files into tables with matching names.
-- Note: source order_date values are in DD-MM-YYYY format. If needed, set
-- your PostgreSQL session to DMY before importing/converting dates:
-- SET datestyle TO 'DMY';

-- Q01. Retrieve the total number of orders placed.
SELECT COUNT(order_id) AS total_orders
FROM orders;

-- Q02. Calculate total revenue generated from pizza sales.
SELECT ROUND(SUM(od.quantity * p.price)::numeric, 2) AS total_revenue
FROM order_details od
JOIN pizzas p ON p.pizza_id = od.pizza_id;

-- Q03. Identify the highest-priced pizza.
SELECT pt.name, p.price
FROM pizza_types pt
JOIN pizzas p ON p.pizza_type_id = pt.pizza_type_id
ORDER BY p.price DESC
LIMIT 1;

-- Q04. Identify the most common pizza size ordered.
-- This reproduces the original analysis: count of order-detail records by size.
SELECT p.size, COUNT(od.order_details_id) AS count
FROM order_details od
JOIN pizzas p ON p.pizza_id = od.pizza_id
GROUP BY p.size
ORDER BY count DESC
LIMIT 1;

-- Optional alternative for Q04: rank sizes by number of individual pizzas sold.
-- SELECT p.size, SUM(od.quantity) AS total_pizzas
-- FROM order_details od
-- JOIN pizzas p ON p.pizza_id = od.pizza_id
-- GROUP BY p.size
-- ORDER BY total_pizzas DESC
-- LIMIT 1;

-- Q05. List the top 5 most ordered pizza types along with quantities.
SELECT pt.name, SUM(od.quantity) AS qty
FROM pizzas p
JOIN pizza_types pt ON pt.pizza_type_id = p.pizza_type_id
JOIN order_details od ON od.pizza_id = p.pizza_id
GROUP BY pt.name
ORDER BY qty DESC
LIMIT 5;

-- Q06. Find the total quantity ordered for each pizza category.
SELECT pt.category, SUM(od.quantity) AS qty
FROM pizza_types pt
JOIN pizzas p ON p.pizza_type_id = pt.pizza_type_id
JOIN order_details od ON od.pizza_id = p.pizza_id
GROUP BY pt.category
ORDER BY pt.category;

-- Q07. Determine the distribution of orders by hour of the day.
SELECT EXTRACT(HOUR FROM order_time) AS hour,
       COUNT(order_id) AS count
FROM orders
GROUP BY hour
ORDER BY hour;

-- Q08. Find the number of pizza types in each category.
SELECT category, COUNT(name) AS count
FROM pizza_types
GROUP BY category
ORDER BY category;

-- Q09. Calculate the average number of pizzas ordered per day.
SELECT ROUND(AVG(qty), 0) AS avg_qty_order
FROM (
    SELECT o.order_date, SUM(od.quantity) AS qty
    FROM orders o
    JOIN order_details od ON od.order_id = o.order_id
    GROUP BY o.order_date
) AS order_qty;

-- Q10. Determine the top 3 pizza types by revenue.
SELECT pt.name, SUM(p.price * od.quantity) AS revenue
FROM pizza_types pt
JOIN pizzas p ON p.pizza_type_id = pt.pizza_type_id
JOIN order_details od ON od.pizza_id = p.pizza_id
GROUP BY pt.name
ORDER BY revenue DESC
LIMIT 3;

-- Q11. Calculate each pizza CATEGORY's percentage contribution to total revenue.
-- The original query groups by category, so the label is corrected to match its logic.
SELECT pt.category,
       ROUND(
           (SUM(p.price * od.quantity) * 100.0)
           / SUM(SUM(p.price * od.quantity)) OVER (), 2
       ) AS percent_contribution
FROM pizza_types pt
JOIN pizzas p ON p.pizza_type_id = pt.pizza_type_id
JOIN order_details od ON od.pizza_id = p.pizza_id
GROUP BY pt.category
ORDER BY pt.category;

-- Q12. Analyze cumulative revenue over time.
SELECT o.order_date AS date,
       ROUND(SUM(p.price * od.quantity)::numeric, 2) AS daily_sales,
       ROUND(
           SUM(SUM(p.price * od.quantity)) OVER (ORDER BY o.order_date)::numeric, 2
       ) AS cumulative_sales
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas p ON p.pizza_id = od.pizza_id
GROUP BY o.order_date
ORDER BY o.order_date;

-- Q13. Find the top 3 revenue-generating pizza types within each category.
SELECT category, name, revenue, rank
FROM (
    SELECT pt.category,
           pt.name,
           SUM(p.price * od.quantity) AS revenue,
           RANK() OVER (
               PARTITION BY pt.category
               ORDER BY SUM(p.price * od.quantity) DESC
           ) AS rank
    FROM pizzas p
    JOIN pizza_types pt ON pt.pizza_type_id = p.pizza_type_id
    JOIN order_details od ON od.pizza_id = p.pizza_id
    GROUP BY pt.category, pt.name
) AS ranked_pizzas
WHERE rank <= 3
ORDER BY category, rank, name;
