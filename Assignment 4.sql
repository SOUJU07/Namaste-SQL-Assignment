-- Run the following command to add and update dob column in employee table
alter table  employee add dob date;
UPDATE employee
SET dob = DATE_SUB(CURDATE(), INTERVAL emp_age YEAR);

select *
from employee;


-- 1- write a query to print emp name , their manager name and diffrence in their age (in days) 
-- for employees whose year of birth is before their managers year of birth

select e.emp_name,m.emp_name as manager_name,timestampdiff(day,e.dob,m.dob) as days
from employee e
join employee m
on e.manager_id=m.emp_id
where e.dob < m.dob;

-- 2- write a query to find subcategories who never had any return orders in the month of november (irrespective of years)

select sub_category
from superstore_orders t1
left join returns t2
on t1.order_id=t2.order_id
where MONTH(order_date) = 11
group by sub_category
having count(t2.order_id) = 0;


-- 3- orders table can have multiple rows for a particular order_id when customers buys more than 1 product in an order.
-- write a query to find order ids where there is only 1 product bought by the customer.

select order_id,count(*)
from superstore_orders
group by order_id
having count(*) = 1
order by order_id;

-- 4- write a query to print manager names along with the comma separated list(order by emp salary) of all employees directly reporting to him.

select m.emp_name as manager,group_concat(e.emp_name separator '--')
from employee e
join employee m
on e.manager_id=m.emp_id
group by manager;




-- 5- write a query to get number of business days between order_date and ship_date (exclude weekends). 
-- Assume that all order date and ship date are on weekdays only

select order_id,datediff(ship_date,order_date)
from superstore_orders;


-- 6- write a query to print 3 columns : category, total_sales and (total sales of returned orders)

select category,SUM(sales),
sum(case
	when t2.order_id IS NOT NULL then sales
end) as return_sales
from superstore_orders t1
left join returns t2
on t1.order_id=t2.order_id
group by category;


-- 7- write a query to print below 3 columns
-- category, total_sales_2019(sales in year 2019), total_sales_2020(sales in year 2020)

select category,
SUM(case
		when YEAR(order_date)=2019 then sales
	end) as total_sales_2019,
SUM(case 
		when YEAR(order_date)=2020 then sales
	end) as total_sales_2020
from superstore_orders
group by category;

-- 8- write a query print top 5 cities in west region by average no of days between order date and ship date.

select city,avg(datediff(ship_date,order_date)) as avg_days
from superstore_orders
where region = 'West'
group by city
order by avg_days desc
limit 5;

-- 9- write a query to print emp name, manager name and senior manager name (senior manager is manager's manager)

select e.emp_name,m.emp_name,sm.emp_name
from employee e
join employee m
on e.manager_id=m.emp_id
join employee sm
on m.manager_id=sm.emp_id;






