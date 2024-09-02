USE pizza_data;

# Retrieve the total number of orders placed.
SELECT COUNT(order_id) as Total_Orders FROM order_details;

# Calculate the total revenue generated from pizza sales.
SELECT
    ROUND(SUM(order_details.quantity * pizzas.price),2) as total_revenue
FROM
    order_details JOIN pizzas
ON
    pizzas.pizza_id = order_details.pizza_id;

# Identify the highest-priced pizza.
SELECT * FROM pizzas
ORDER BY price DESC
LIMIT 1;
# OR
select pizza_types.name, pizzas.price
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
order by pizzas.price desc limit 1;

# Identify the most common pizza size ordered.
SELECT * FROM pizzas;
SELECT * FROM pizza_types;
SELECT * FROM orders;
SELECT * FROM order_details;

SELECT size , COUNT(order_details.order_details_id) as count
FROM pizzas
JOIN order_details
ON pizzas.pizza_id = order_details.pizza_id
GROUP BY size
ORDER BY count DESC
LIMIT 1;

# List the top 5 most ordered pizza types along with their quantities.
SELECT pizza_types.name , SUM(order_details.quantity) as count_quantity
FROM pizza_types
JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY count_quantity DESC
LIMIT 5;