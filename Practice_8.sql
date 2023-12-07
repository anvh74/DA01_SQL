--EX 1--
With first_order_date as
(
select 
customer_id, 
min(order_date) OVER (Partition by customer_id ORDER BY order_date) as first_order,
customer_pref_delivery_date
from delivery
)
Select 
 round(sum(Case when first_order=customer_pref_delivery_date then 1 else 0 END)
    / count(distinct customer_id)*100.00,2) AS immediate_percentage
  from first_order_date
