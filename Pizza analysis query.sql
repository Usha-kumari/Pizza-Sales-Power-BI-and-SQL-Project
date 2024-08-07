use pizza;

SELECT *from pizzas;
select*from order_details;
-- KPIs

-- 1) Total Revenue

-- a) verify that the price given is for one pizza

SELECT*FROM pizzas

WHERE pizza_id = 'big_meat_s'

ORDER BY price DESC;

-- big_meat_s quantity 4

SELECT*FROM order_details AS o
JOIN pizzas AS p
ON o.pizza_id = p.pizza_id
ORDER BY quantity DESC;
-- final query

 SELECT 
 round(SUM(quantity * price), 2)

FROM order_details AS o

JOIN pizzas AS p

ON o.pizza_id = p.pizza_id;
 
 -- Average order value
 -- Total order value/ order count


SELECT

SUM(quantity * price)/ COUNT(DISTINCT order_id) AS Average_Order_Value

FROM order_details AS o

JOIN pizzas AS p

ON o.pizza_id = p.pizza_id;
 
 -- Total pizzas sold
 select sum(quantity) as total_quantity
 from order_details;
 
 -- Total orders
 
 select count(distinct order_id) as total_orders
 from order_details;
 
 -- Average pizza order per order
 -- pizza sold/ number of pizzas
 
 SELECT
  ROUND(SUM(quantity)/COUNT(DISTINCT order_id),2) AS  Average_Pizzas_Per_Order
FROM
  order_details;
  
  -- Sales Analysis Questions
  -- 1) Daily Trends for Total Order
  SELECT 
 FORMAT( Date , 'dddd') AS DayOfWeek
 ,COUNT(DISTINCT order_ID) AS total_orders
FROM orders
GROUP BY FORMAT(Date, 'dddd')
ORDER BY total_orders DESC;


 -- Percentage of Sales by Pizza Category
-- a: calculate total revenue per category
-- % sales calculated as (a:/total revenue) * 100
SELECT 
    category,
    ROUND(SUM(quantity * price), 2) AS revenue,
    ROUND(SUM(quantity * price) * 100.0 / (SELECT SUM(quantity * price) FROM pizzas AS p2 JOIN order_details AS od2 ON od2.pizza_id = p2.pizza_id), 2) AS percentage_of_sales
FROM 
    pizzas AS p
JOIN 
    pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
JOIN 
    order_details AS od ON od.pizza_id = p.pizza_id
GROUP BY 
    category;
    
    -- Percentage of Sales by Pizza Size
    
    SELECT 
    size
    ,ROUND(SUM(quantity * price), 2) AS revenue
    ,ROUND(SUM(quantity * price) * 100.0 / (SELECT SUM(quantity * price) FROM pizzas AS p2 JOIN order_details AS od2 ON od2.pizza_id = p2.pizza_id), 2) AS percentage_of_sales
FROM 
    pizzas AS p
JOIN 
    pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
JOIN 
    order_details AS od ON od.pizza_id = p.pizza_id
GROUP BY 
    size;

--  Total Pizzas Sold by Pizza Category

SELECT
 category
 ,SUM(quantity) AS quantity_sold
FROM 
    pizzas AS p
JOIN 
    pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
JOIN 
    order_details AS od ON od.pizza_id = p.pizza_id
GROUP BY category;

-- Top 5 Best Sellers by Total Pizzas Sold

SELECT 
  name
  ,SUM(quantity) AS total_quantity_sold
FROM 
    pizzas AS p
JOIN 
    pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
JOIN 
    order_details AS od ON od.pizza_id = p.pizza_id
GROUP BY name
ORDER BY total_quantity_sold DESC
LIMIT 5;

-- Bottom 5 Best Sellers by Total Pizzas Sold

SELECT
  name
  ,SUM(quantity) AS total_quantity_sold
FROM 
    pizzas AS p
JOIN 
    pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id
JOIN 
    order_details AS od ON od.pizza_id = p.pizza_id
GROUP BY name
ORDER BY total_quantity_sold ASC
LIMIT 5;