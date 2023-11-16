--- Link to Mid-course Test <https://github.com/anvh74/DA01_SQL/edit/main/Mid-course%20test.sql>
--Practice 5:

--EX 1
Select Country.Continent, 
Floor(AVG(City.Population)) 
from Country 
Inner join City on country.Code=city.CountryCode
Group by COUNTRY.Continent

--EX2
SELECT 
Round(Cast(Count(t1.email_id)as numeric)/Count(Distinct t2.email_id),2) as activation_rate
From emails as t2
LEFT JOIN texts as t1 on t2.email_id = t1.email_id
And t1.signup_action = 'Confirmed'

--EX3 
 Select
 t1.age_bucket,
 Round((Sum(CASE
       When t2.activity_type='send' then t2.time_spent Else 0
       End))*100.00
   /(Sum(CASE
       When t2.activity_type in ('open','send') then t2.time_spent Else 0
       End)),2) As Send_per,
 Round((Sum(CASE
       When t2.activity_type='open' then t2.time_spent Else 0
       End))*100.00
   /(Sum(CASE
       When t2.activity_type in ('open','send') then t2.time_spent Else 0
       End)),2) As Open_per
From age_breakdown as t1
INNER JOIN activities as t2 on t1.user_id=t2.user_id
Group by t1.age_bucket

--EX4 
 ---> A Microsoft Azure Supercloud customer is defined as a company that purchases at least one product from each product category
SELECT 
t1.customer_id as Supercloud_customer
FROM customer_contracts as t1
Inner join products as t2 on t1.product_id=t2.product_id
GROUP BY Supercloud_customer
Having COUNT(DISTINCT t2.product_category)>=3 --> Chưa được optimal lắm...

--EX5
Select 
mng.employee_id as employee_id, 
mng.name as name,
count(emp.employee_id) as reports_count,
Round(AVG(emp.age),0) as average_age
from employees as mng
Inner join employees as emp on emp.reports_to=mng.employee_id 
Group by employee_id

--EX6
Select
t1.product_name as product_name,
Sum(t2.unit) as unit
From Products as t1
inner join Orders as t2 on t1.product_id=t2.product_id
where Extract(Month from t2.order_date)=02 and Extract(Year from t2.order_date)=2020
Group by product_name
Having unit>=100

--EX7
SELECT
t1.page_id
from pages as t1
Left join page_likes as t2 on t1.page_id=t2.page_id
Where (t2.liked_date) is null
Group by t1.page_id
