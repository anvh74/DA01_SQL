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
   END AS Replacement_cost_category,
Count(*) as films
From film
Group by Replacement_cost_category
