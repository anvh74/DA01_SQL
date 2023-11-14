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
--EX7
SELECT card_name, 
max(issued_amount) - min(issued_amount) as issuance_difference
FROM monthly_cards_issued
Group by card_name
Order by issuance_difference DESC
--EX8
SELECT manufacturer,	
count(product_id) as associated_drug_count,
ABS(sum(total_sales - cogs)) as losses
from pharmacy_sales
Where total_sales - cogs<=0
GROUP BY manufacturer
ORDER BY losses DESC
--EX9
select * 
from Cinema
where id%2!=0 and description NOT like '%boring%'
Order by rating DESC
--EX10
elect teacher_id,
count(distinct subject_id) as cnt
from Teacher
Group by teacher_id
--EX11
Select user_id,
count(follower_id) as followers_count
from followers
Group by user_id
Order by user_id ASC
--EX12
  ---Output: class with at least 5 students
  ---Input: student with associated class---
  ---Condition: phái sinh - lớp có 5 học sing >> Having
Select class
from Courses
Group by class
having count(student)>=5
