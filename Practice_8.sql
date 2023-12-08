--EX 1--
Select 
 round(sum(Case when first_order=customer_pref_delivery_date then 1 else 0 END)
    / count(distinct customer_id)*100.00,2) AS immediate_percentage
from
 (select 
  customer_id, 
  min(order_date) OVER (Partition by customer_id ORDER BY order_date) as first_order,
  customer_pref_delivery_date
  from delivery) as first_order_date

--EX 2--
Select 
round(sum(case when next_day - first_day=1 then 1 else 0 end) 
       /count(distinct player_id),2) as fraction
from
(Select player_id, 
min(event_date) OVER (PARTITION BY player_id ORDER BY event_date) as first_day,
lead(event_date) OVER (PARTITION BY player_id ORDER BY event_date) as next_day
from Activity) as first_next_day

--EX 3--
Select 
Case 
  when id < (select max(id) from seat) then   
     case when id%2=0 then id-1 else id+1 END 
  when id= (select max(id) from seat) then
     case when (select max(id) from seat)%2=0 then (select max(id) from seat)-1 
        else (select max(id) from seat) END 
END as id, student
from seat
Order by id 

--EX 4 --
With cte as
(
Select visited_on,
   --> [ROWS BEWTEEN...CURRENT ROW] - tham khảo từ một solution của EX5 Practice 6
sum(amount) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) as amount, 
ROUND(avg(amount) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW),2) as average_amount,
lag(visited_on,6) over (ORDER BY visited_on) as previous  
from 
(Select 
distinct visited_on as visited_on,
sum(amount) as amount
from customer
Group by visited_on) as t1
Order by visited_on 
)
Select visited_on, amount, average_amount 
from cte
Where previous is not null

--EX 5--
select ROUND(sum(tiv_2016), 2) tiv_2016 from 
(
 select *, 
 count(tiv_2015)over(partition by tiv_2015 order by tiv_2015) as tiv2015_count
 count(concat(lat, lon))over(partition by lat, lon order by lat, lon) as lat_lon
 from insurance
) as t1 
where tiv2015_count> 1 and lat_lon = 1

--EX 6 --
Select Department, Employee, Salary
from(
SELECT 
t1.name as Department,
t2.name as Employee,
t2.salary as Salary,
DENSE_rank() Over (Partition by t1.name order by t2.salary DESC) as rank 
from department as t1
Join employee as t2 on t1.id=t2.departmentid
) as Dept_Emp
Where rank <=3

--EX 7 --
Select person_name from
(
Select *,
Sum(weight) OVER (Order by turn) as total_weight
from queue) as sum_weight
Where total_weight<=1000
ORDER BY total_weight DESC
Limit 1

--EX 8 --






















