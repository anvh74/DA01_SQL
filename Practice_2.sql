--EX 3 giải cuối cùng!!
-- EX1
Select Distinct City
from station
Where ID%2=0
--EX2
Select count(City) - count(distinct city) 
from station
--EX4
Select round(CAST(sum(order_occurrences * item_count)/sum(order_occurrences) AS DECIMAL),1) as mean
from items_per_order
--EX5
SELECT DISTINCT candidate_id 
FROM candidates
Where skill in ('Python','Tableau','PostgreSQL')
group by candidate_id
Having count(skill)=3
ORDER BY candidate_id 
--EX6
SELECT user_id, 
max(DATE(post_date)) - min(DATE(post_date)) as diff
FROM posts
Where (date(post_date)) BETWEEN '01/01/2021' AND '12/31/2021'
Group BY user_id
Having count(user_id)>1
