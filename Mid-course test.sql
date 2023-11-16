--- Link to Practice 5: <https://github.com/anvh74/DA01_SQL/edit/main/Practice_5.sql>
--Mid-course test:
--Question 1
select film_id, title, replacement_cost
from film
Order by replacement_cost

--Question 2
Select 
Case
   When replacement_cost between 9.99 and 19.99 then 'low'
   When replacement_cost between 20.00 and 24.99 then 'medium'
   When replacement_cost between 25.00 and 29.99 then 'high'
   END AS Replacement_cost_range,
Count(*) as films
From film
Group by Replacement_cost_range
Having Case
   When replacement_cost between 9.99 and 19.99 then 'low'
   When replacement_cost between 20.00 and 24.99 then 'medium'
   When replacement_cost between 25.00 and 29.99 then 'high'
   END in ('low')

--Question 3
select 
t1.title, t1.length,
t3.name as category
from film as t1
Inner join film_category as t2 on t1.film_id=t2.film_id
Inner join category as t3 on t2.category_id=t3.category_id
Where t3.name in ('Drama','Sports')
Order by length DESC

--Question 4
select 
t3.name as category,
count(t1.title) as title_count
from film as t1
Inner join film_category as t2 on t1.film_id=t2.film_id
Inner join category as t3 on t2.category_id=t3.category_id
Group by category
Order by title_count DESC

--Question 5
Select 
initcap(t1.first_name ||' '|| t1.last_name) as actor_full_name,
count(t2.film_id) as film_count
from actor as t1
Inner join film_actor as t2 on t1.actor_id=t2.actor_id
Group by actor_full_name
Order by film_count DESC

--Question 6
COUNT(t1.address_id),
t2.customer_id
from address as t1
Left join customer as t2 on t1.address_id=t2.address_id
Where customer_id is null
Group by t2.customer_id

--Question 7
<city --> city_id, city
 payment --> amount, customer_id
 customer --> customer_id, address_id
 address --> address_id, city_id>

Select 
t1.city as Citites,
Sum(t4.amount) as Total_amount
from city as t1
Inner join address as t2 on t1.city_id=t2.city_id
Inner join customer as t3 on t2.address_id=t3.address_id
Inner join payment as t4 on t3.customer_id=t4.customer_id
Group by Citites
Order by Total_amount DESC 
 
--Question 8 
Select 
t1.city || ', ' || t5.country as City_Country,
Sum(t4.amount) as Total_amount
from city as t1
Inner join country as t5 on t1.country_id=t5.country_id
Inner join address as t2 on t1.city_id=t2.city_id
Inner join customer as t3 on t2.address_id=t3.address_id
Inner join payment as t4 on t3.customer_id=t4.customer_id
Group by City_Country
Order by Total_amount DESC
