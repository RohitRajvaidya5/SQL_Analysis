-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT pizza_types.category ,  SUM(order_details.quantity) as quantity
FROM pizza_types
JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity;

# Determine the distribution of orders by hour of the day.
SELECT HOUR(orders.time) as hours, COUNT(orders.order_id) as orders
FROM orders
GROUP BY hours;

# Join relevant tables to find the category-wise distribution of pizzas.
SELECT category, COUNT(*) as PizzaCount
FROM pizza_types
GROUP BY category ;

# Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT ROUND(AVG(quantity),0) as avg_quantity FROM
(SELECT orders.date , SUM(order_details.quantity) AS quantity
FROM orders
JOIN order_details
on orders.order_id = order_details.order_id
GROUP BY orders.date) AS order_quantity;

# Determine the top 3 most ordered pizza types based on revenue.
SELECT name , SUM(order_details.quantity * pizzas.price) as price
FROM pizza_types
JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON order_details.pizza_id = pizzas.pizza_id
GROUP BY name
ORDER BY price DESC
LIMIT 3;