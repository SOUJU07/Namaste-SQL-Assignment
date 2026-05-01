-- Note: please do not use any functions which are not taught in the class. you need to solve the questions only with the concepts that have been discussed so far.

-- 1- write a update statement to update city as null for order ids :  CA-2020-161389 , US-2021-156909

update superstore_orders
set city = NULL
where order_id IN ('CA-2020-161389' , 'US-2021-156909');



-- 2- write a query to find orders where city is null (2 rows)

SELECT *
FROM superstore_orders
where city IS NULL;

-- 3- write a query to get total profit, first order date and latest order date for each category

select category,sum(profit) as total_profit, min(order_date),max(order_date)
from superstore_orders
group by category;


-- 4- write a query to find sub-categories where average profit is more than the half of the max profit in that sub-category

select sub_category,avg(profit) as avg_profit,max(profit)
from superstore_orders
group by sub_category
having avg(profit) > (max(profit)/2);


-- 5- create the exams table with below script;
-- create table exams (student_id int, subject varchar(20), marks int);

CREATE table exams(
student_id int,
subject varchar(20),
marks int);

insert into exams values (1,'Chemistry',91),(1,'Physics',91),(1,'Maths',92)
,(2,'Chemistry',80),(2,'Physics',90)
,(3,'Chemistry',80),(3,'Maths',80)
,(4,'Chemistry',71),(4,'Physics',54)
,(5,'Chemistry',79);

-- write a query to find students who have got same marks in Physics and Chemistry.

select student_id,marks,COUNT(*)
from exams
where subject IN ('Chemistry','Physics')
group by student_id,marks
having COUNT(*) =2;

-- 6- write a query to find total number of products in each category.

select category, count(distinct product_id) as no_of_products
from superstore_orders
group by category;



-- 7- write a query to find top 5 sub categories in west region by total quantity sold

select sub_category,SUM(quantity) as total_quantity_sold
from superstore_orders
where region = 'West'
group by sub_category
order by total_quantity_sold DESC
LIMIT 5;


-- 8- write a query to find total sales for each region and ship mode combination for orders in year 2020

select region,ship_mode,SUM(sales) as total_sales
from superstore_orders
where year(order_date) = 2020
group by region,ship_mode;





