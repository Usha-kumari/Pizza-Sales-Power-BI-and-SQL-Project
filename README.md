# Pizza-Sales-Power-BI-and-SQL-Project
This is a Power BI and SQL project to analyze the pizza sales data multiple tables and to build a interactive data visuals dashboard to draw insights.


QUESTIONS TO BE ANSWERED:

1. Total Revenue (How much money did we make this year?)
2. Average Order Value
3. Total Pizzas Sold
4. Total Orders
5. Average Pizzas per Order
6. Percentage of Sales by Pizza Category
7. Percentage of Sales by Pizza Size
8. Total Pizzas Sold by Pizza Category
9. Top 5 Best Sellers by Total Pizzas Sold
10. Bottom 5 Worst Sellers by Total Pizzas Sold

    FINDINGS:

1. Total Revenue for the year was $1.64M
2. Average Order Value was $49.5

3. Total Pizzas Sold – 50,000
4. Total Orders – 21,000
5. Average Pizzas per Order – 2

6. Classic pizza has the highest percentage of sales (26.91%), followed by Supreme (25.46%), Chicken (23.96%), and Veggie (23.68%) pizzas.

7. Large-size pizzas record the highest sales (45.89%) followed by medium (30.49%), then small (21.77%). XL and XXL only account for 1.72% and 0.12% respectively.

8. Classic Pizza accounts for the highest sales (14,888 pizzas) followed by Supreme (11,987 pizzas), Veggie (11,649 pizzas), and Chicken (11,050 pizzas).

9. Top 5 Best Sellers are the Classic Deluxe (2453 pizzas), Barbecue Chicken (2432 pizzas), Hawaiian (2422), Pepperoni (2418 pizzas), and Thai Chicken (2371 pizzas).

10. Bottom 5 Worst Sellers are Brie Carre (490 pizzas), Mediterranean (934 pizzas), Calabrese (937 pizzas), Spinach Supreme (950 pizzas) and Soppressata (961).77.


 CONCLUSION:

The outlet should capitalize on Large-size Classic, Supreme, Veggie, and Chicken pizzas.

Since XL and XXL pizzas account for such a small percentage of their sales (just 1.94%), they can safely get rid of these pizza sizes.

Even though the Brie Carre pizza is the worst seller, it recorded 490 pizzas sold. It would still be a good idea to keep it on the menu.

QUERIES USED:

1) Total Revenue



SELECT 


 round(SUM(quantity * price), 2)


FROM order_details AS o
 
 
 JOIN pizzas AS p 
 
 
 ON o.pizza_id = p.pizza_id;


 

 2) Average Order Value
total order value/order count

SELECT 


 SUM(quantity * price)/ COUNT(DISTINCT order_id) AS [Average Order Value]


FROM order_details AS o
 
 
 JOIN pizzas AS p 
 
 
 ON o.pizza_id = p.pizza_id;

 

3) Total pizzas sold

   
 
 SELECT
  
  
  SUM(quantity) AS [Total_Pizzas_Sold]


FROM
  order_details;

  
4) Total Orders



SELECT
  COUNT(DISTINCT order_id) AS [Total_Orders]

FROM
  order_details;

5) Average Pizzas Per Order
quantity sold/order IDs

SELECT
 
  
  ROUND(SUM(quantity)/COUNT(DISTINCT order_id),2) AS [Average Pizzas Per Order]

FROM
  order_details;

  
Sales Analysis Questions


6) Percentage of Sales by Pizza Category
a: calculate total revenue per category
% sales calculated as (a:/total revenue) * 100

SELECT 
    category,
    
    
    ROUND(SUM(quantity * price), 2) AS revenue,
    
    
    ROUND(SUM(quantity * price) * 100.0 / (SELECT SUM(quantity * price) FROM pizzas AS p2 JOIN order_details AS od2 ON od2.pizza_id = p2.pizza_id), 2) 
    
    AS percentage_of_sales


FROM 
    pizzas AS p


JOIN 
    pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id


JOIN 
    order_details AS od ON od.pizza_id = p.pizza_id

GROUP BY 
    Category;

7) Percentage of Sales by Pizza Size


SELECT 
    size
    
    ,ROUND(SUM(quantity * price), 2) AS revenue
    
    
    ,ROUND(SUM(quantity * price) * 100.0 / (SELECT SUM(quantity * price) FROM pizzas AS p2
    
    JOIN order_details AS od2 ON od2.pizza_id = p2.pizza_id), 2) AS percentage_of_sales


FROM 
    pizzas AS p


JOIN 
    pizza_types AS pt ON p.pizza_type_id = pt.pizza_type_id


JOIN 
    order_details AS od ON od.pizza_id = p.pizza_id
GROUP BY 
    size;
    
8) Total Pizzas Sold by Pizza Category



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



9) Top 5 Best Sellers by Total Pizzas Sold
    


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
limit 5;

10) Bottom 5 Best Sellers by Total Pizzas Sold




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
limit 5;


SQL QUERIES FILE: https://docs.google.com/document/d/1-ipvgdkTuDP0FO3-VY_CgEO9uALaSa_k1K-EhsDetck/edit?usp=sharing


   

