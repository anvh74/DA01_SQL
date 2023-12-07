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
  when id<max then
      case when id%2=0 then id-1 else id+1 END
  else max END as id, student
from
(Select id, student, (select max(id) as max_id from seat) as max
from seat) as a
ORDER BY id





