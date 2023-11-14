--EX7 làm cuối cùng
--EX1
Select 
name
from STUDENTS
Where Marks>75
Order By Right(name,3), ID 
  
-- EX2
Select user_id,
Concat(Upper(Left(name,1)),lower(substring(name,2,length(name)-1)))
as name
from Users
Order by user_id
  
--EX3
SELECT Manufacturer,
Concat('$',ROUND(sum(total_sales)/1000000,0),' million') as Sale
FROM pharmacy_sales
Group by Manufacturer
Order By ROUND(sum(total_sales)/1000000,0) DESC, Manufacturer DESC
  
--EX4
SELECT 
extract(month from submit_date) as mth,
product_id as product,
round(avg(stars),2) as avg_stars
FROM reviews
Group by mth, product_id
Order by mth, product_id
  
--EX5
SELECT 
Sender_id,
Count(*) as message_count
FROM messages
Where extract(month from sent_date)=8 and extract(year from sent_date)=2022
Group by Sender_id
Order by message_count DESC
Limit 2
  
--EX6
Select 
tweet_id
from tweets
Where length(content)>15
  
--EX8
Select 
count(id) as employee_hired
from employees
where joining_date Between '2022-01-01' and '2022-07-31'
  -- hoặc
Select 
count(id) as employee_hired
from employees
where extract(month from joining_date) between 1 and 7
and extract(year from joining_date)=2022

--EX9
Select 
position('a' in first_name) as position_of_lower_a
from worker
Where first_name='Amitah'

--EX10
select 
substring(title,length(winery)+2,4) as vintage_years
from winemag_p2
where country= 'Macedonia'
  
--EX7 <https://leetcode.com/problems/user-activity-for-the-past-30-days-i/?envType=study-plan-v2&envId=top-sql-50>
Select 
activity_date as day,
Count(Distinct user_id) as active_users
from Activity
Where datediff('2019-07-27', activity_date) <= 30 and activity_date <= '2019-07-27'
Group by day
Having count(activity_type)>=1





