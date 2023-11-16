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

--EX3 --LOADING--
SELECT 
t1.age_bucket,
round(sum(t2.time_spent)/Sum(t3.time_spent),2) as sending_time,
round(Sum(t3.time_spent)/Sum(t2.time_spent),2) as opening_time
From age_breakdown as t1
Inner join activities as t2 on t1.user_id=t2.user_id and t2.activity_type in ('send')
Inner join activities as t3 on t1.user_id=t2.user_id and t3.activity_type in ('open')
Group by t1.age_bucket

--EX4 
