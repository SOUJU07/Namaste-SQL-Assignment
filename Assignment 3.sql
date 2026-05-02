-- 1- write a query to get region wise count of return orders

select region,count(distinct t2.order_id) 
from superstore_orders t1
join returns t2
on t1.order_id=t2.order_id
group by region;


-- 2- write a query to get category wise sales of orders that were not returned

select category,SUM(sales) as sales
from superstore_orders t1
left join returns t2
on t1.order_id=t2.order_id
where t2.order_id IS NULL and t2.return_reason IS NULL
group by category;


-- 3- write a query to print dep name and average salary of employees in that dep .

select dep_name,avg(salary)
from employee t1
join dept t2
on t1.dept_id=t2.dep_id
group by dep_name;


-- 4- write a query to print dep names where none of the emplyees have same salary.

select d.dep_name,count(e.emp_id),count(distinct e.salary)
from employee e
inner join dept d on e.dept_id=d.dep_id
group by d.dep_name
having count(distinct e.salary) < 2;


-- 5- write a query to print sub categories where we have all 3 kinds of returns (others,bad quality,wrong items)

select sub_category,count(distinct return_reason) as three_kinds
from superstore_orders t1
join returns t2
on t1.order_id = t2.order_id
group by sub_category
having three_kinds = 3;


-- 6- write a query to find cities where not even a single order was returned.

select city,count(distinct return_reason) as no_return
from superstore_orders t1
left join returns t2
on t1.order_id = t2.order_id
group by city
having no_return = 0;


-- 7- write a query to find top 3 subcategories by sales of returned orders in east region

select sub_category,SUM(sales) as sales
from superstore_orders t1
join returns t2
on t1.order_id=t2.order_id
where region = 'East'
group by sub_category
order by sales DESC
LIMIT 3;


-- 8- write a query to print dep name for which there is no employee

select dep_name
from employee e
right join dept d
on e.dept_id=d.dep_id
where emp_id IS NULL;


select d.dep_id,d.dep_name
from dept d 
left join employee e on e.dept_id=d.dep_id
group by d.dep_id,d.dep_name
having count(e.emp_id)=0;

-- 9- write a query to print employees name for dep id is not avaiable in dept table

select emp_name,dept_id,COUNT(dep_id)
from employee e
left join dept d
on e.dept_id=d.dep_id
group by dept_id,emp_name
having count(dep_id) = 0;


select e.*
from employee e 
left join dept d  on e.dept_id=d.dep_id
where d.dep_id is null;

