--EX 1--
With frist_order_date as
(
select 
DISTINCT customer_id, 
min(order_date) OVER (Partition by customer_id ORDER BY order_date) as first_order
from delivery
)
Select
count(t1.customer_id) as immediate_first_order
from Delivery as t1
Join frist_order_date as t2 
on t1.customer_pref_delivery_date=t2.first_order
UNION ALL
Select count(*) from delivery

