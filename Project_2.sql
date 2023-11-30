--/*II. Ad-hoc tasks
--Thống kê tổng số lượng người mua và số lượng đơn hàng 
--đã hoàn thành mỗi tháng ( Từ 1/2019-4/2022)
--*/
Select 
count(DISTINCT user_id) as user_count,
count(DISTINCT ORDER_id) as order_count,
Extract(YEAR from shipped_at) || '-'|| Extract(MONTH from shipped_at) as year_month_shipped 
from bigquery-public-data.thelook_ecommerce.orders
Where status='Shipped' and 
shipped_at BETWEEN '2019-01-01 00:00:00' AND '2022-05-01 00:00:00'
Group by year_month_shipped
ORDER BY year_month_shipped
