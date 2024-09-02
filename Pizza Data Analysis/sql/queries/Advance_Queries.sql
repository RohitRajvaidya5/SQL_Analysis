# Calculate the percentage contribution of each pizza type to total revenue.
SELECT
    pizza_types.category,
    ROUND(
        SUM(od.quantity * p.price) / (
            SELECT
                SUM(order_details.quantity * pizzas.price)
            FROM
                pizza_data.order_details
                JOIN pizza_data.pizzas ON pizzas.pizza_id = order_details.pizza_id
        ) * 100,
        2
    ) AS revenue
FROM
    pizza_types
    JOIN pizza_data.pizzas p ON pizza_types.pizza_type_id = p.pizza_type_id
    JOIN pizza_data.order_details od ON p.pizza_id = od.pizza_id
GROUP BY
    pizza_types.category
ORDER BY
    revenue DESC;

# Analyze the cumulative revenue generated over time.
SELECT date ,
       SUM(revenue) OVER (ORDER BY date) as cum_revenue
FROM
(SELECT orders.date ,ROUND(SUM(order_details.quantity * pizzas.price),2) as revenue
FROM pizza_data.order_details
JOIN pizza_data.pizzas
ON pizzas.pizza_id = order_details.pizza_id
JOIN pizza_data.orders
ON orders.order_id = order_details.order_id
GROUP BY date) AS sales;

# Determine the top 3 most ordered pizza types based on revenue for each pizza category.
SELECT name,revenue
FROM
(SELECT category,name,revenue,
       rank() over (partition by category order by revenue desc) as rn
    from
(SELECT category, name, SUM(order_details.quantity * pizzas.price) as revenue
FROM order_details JOIN pizzas
ON pizzas.pizza_id = order_details.pizza_id
JOIN pizza_types
ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY category,name) as a) AS b
WHERE rn <= 3;