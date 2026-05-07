-- Note: please do not use any functions which are not taught in the class. you need to solve the questions only with the concepts that have been discussed so far.
-- Run below table script to create icc_world_cup table:

create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

-- 1- write a query to produce below output from icc_world_cup table.
-- team_name, no_of_matches_played , no_of_wins , no_of_losses

with cte as
(select Team_1 as team,
case
	when Team_1=Winner then 1 else 0
end as winning_team
from icc_world_cup
UNION
select Team_2 as team,
case 
	when Team_2=Winner then 1 else 0
end as winning_team
from icc_world_cup
)

select team,count(team) as no_of_matches,SUM(winning_team) as no_of_wins,count(team)-SUM(winning_team) as no_of_loss
from cte
group by team;

-- 2- write a query to print first name and last name of a customer using orders table(everything after first space can be considered as last name)
-- customer_name, first_name,last_name
select trim(customer_name) as customer_name,
substring_index(customer_name,' ',1) as first_name,
right(customer_name,length(customer_name)-locate(' ',customer_name)) as last_name
from superstore_orders;


-- Run below script to create drivers table:

create table drivers(id varchar(10), start_time time, end_time time, start_loc varchar(10), end_loc varchar(10));
insert into drivers values('dri_1', '09:00', '09:30', 'a','b'),('dri_1', '09:30', '10:30', 'b','c'),('dri_1','11:00','11:30', 'd','e');
insert into drivers values('dri_1', '12:00', '12:30', 'f','g'),('dri_1', '13:30', '14:30', 'c','h');
insert into drivers values('dri_2', '12:15', '12:30', 'f','g'),('dri_2', '13:30', '14:30', 'c','h');


-- 3- write a query to print below output using drivers table. Profit rides are the no of rides where 
-- end location of a ride is same as start location of immediate next ride for a driver
-- id, total_rides , profit_rides
-- dri_1,5,1
-- dri_2,2,0

with cte as(select *,
lag(end_loc) over(partition by id order by end_loc) as lag_loc
from drivers
)

select id,count(id) as totol_rides,
SUM(case 
	when lag_loc=start_loc then 1
    else 0
end) as profit_ride
from cte
group by id;

-- 4- write a query to print customer name and no of occurence of character 'n' in the customer name.
-- customer_name , count_of_occurence_of_n

select customer_name,
LENGTH(lower(customer_name))-LENGTH(replace(customer_name,'n','')) as count_of_n
from superstore_orders;

-- 5-write a query to print below output from orders data. example output
-- hierarchy type,hierarchy name ,total_sales_in_west_region,total_sales_in_east_region
-- category , Technology, ,
-- category, Furniture, ,
-- category, Office Supplies, ,
-- sub_category, Art , ,
-- sub_category, Furnishings, ,
-- --and so on all the category ,subcategory and ship_mode hierarchies 

select 
'category' as hierarchy_type,category as hierarchy_name
,sum(case when region='West' then sales end) as total_sales_in_west_region
,sum(case when region='East' then sales end) as total_sales_in_east_region
from superstore_orders
group by category
UNION ALL
select 
'sub_category' as hierarchy_type,sub_category as hierarchy_name
,sum(case when region='West' then sales end) as total_sales_in_west_region
,sum(case when region='East' then sales end) as total_sales_in_east_region
from superstore_orders
group by sub_category
UNION ALL
select 
'ship_mode' as hierarchy_type,ship_mode as hierarchy_name
,sum(case when region='West' then sales end) as total_sales_in_west_region
,sum(case when region='East' then sales end) as total_sales_in_east_region
from superstore_orders
group by ship_mode;

select *
from superstore_orders;

-- 6- the first 2 characters of order_id represents the country of order placed .
-- write a query to print total no of orders placed in each country
-- (an order can have 2 rows in the data when more than 1 item was purchased in the order but it should be considered as 1 order)

with cte as(select order_id,count(distinct order_id) as total_count,left(order_id,2) as code
from superstore_orders
group by order_id
)

select code,SUM(total_count)
from cte
group by code;


