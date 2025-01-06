Use elpizzario_pizza; 
-- Retrieve the total number of orders placed.
select count(order_id) as Total_Order_Count from orders_final;
-- Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(orders_details.oreder_quantity * pizzas.price),0) AS TOTAL_SALES
FROM
    orders_details
        JOIN
    pizzas ON orders_details.pizza_id = pizzas.pizza_id;
-- Identify the highest-priced pizza.
SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;
-- Identify the most common pizza size ordered.
SELECT 
    pizzas.size,
    COUNT(orders_details.order_detail_id) AS Order_count
FROM
    pizzas
        JOIN
    orders_details ON pizzas.pizza_id = orders_details.pizza_id
GROUP BY pizzas.size
ORDER BY Order_count DESC; 

-- List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pizza_types.name,
    SUM(orders_details.oreder_quantity) AS Total_Orders_Qty
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY Total_Orders_Qty DESC
LIMIT 5;

-- Join the necessary tables to find the total quantity of each pizza category ordered
SELECT 
    pizza_types.category,
    SUM(orders_details.oreder_quantity) AS Total_Orders_Qty
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY Total_Orders_Qty DESC;

-- Determine the distribution of orders by hour of the day.

SELECT 
    HOUR(time) AS Order_Hours, COUNT(order_id) AS Orders_count
FROM
    orders_final
GROUP BY Order_Hours
ORDER BY Orders_count DESC;

-- find the category-wise pizzas item count.
SELECT 
    pizza_types.category, COUNT(name) AS count_item
FROM
    pizza_types
GROUP BY category;

-- perday avarage order count

SELECT 
    ROUND(AVG(order_count), 0) AS AVG_QTY_PERDAY
FROM
    (SELECT 
        orders_final.date,
            SUM(orders_details.oreder_quantity) AS order_count
    FROM
        orders_details
    JOIN orders_final ON orders_final.order_id = orders_details.order_id
    GROUP BY date
    ORDER BY order_count) AS AVG_ORDER_QTY;
    
-- Top 5 most revenue earning pizza
SELECT 
    pizza_types.name,
    ROUND(SUM(orders_details.oreder_quantity * pizzas.price),
            0) AS Revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    orders_details ON orders_details.pizza_id = pizzas.pizza_id
GROUP BY name
ORDER BY Revenue DESC
LIMIT 5;


