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


