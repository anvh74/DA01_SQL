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




