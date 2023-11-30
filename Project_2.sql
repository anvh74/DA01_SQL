--GOOGLE CLOUD--
--II. Ad-hoc tasks
--1-- Thống kê tổng số lượng người mua và số lượng đơn hàng đã hoàn thành mỗi tháng ( Từ 1/2019-4/2022)

--Note: Vì yêu cầu số lượng đơn hàng đã hoàn thành (aka status 'Complete') --> dùng 'delivered_date' ở bảng oder_items làm mốc thời gian ghi nhận 
Select 
FORMAT_DATE('%Y-%m', t2.delivered_at) as month_year, 
count(DISTINCT t1.user_id) as total_user,
count(t1.ORDER_id) as total_order
from bigquery-public-data.thelook_ecommerce.orders as t1
Join bigquery-public-data.thelook_ecommerce.order_items as t2 
on t1.order_id=t2.order_id
Where t1.status='Complete' and 
t2.delivered_at BETWEEN '2019-01-01 00:00:00' AND '2022-05-01 00:00:00'
Group by month_year
ORDER BY month_year

/*--> Insight: 
    - Nhìn chung số lượng người mua hàng và đơn hàng tiêu thụ đã hoàn thành tăng dần theo mỗi tháng và năm, thể hiện xu hướng tăng của nhóm người mua trung thành của TheLook   
    - Giai đoạn 2019-tháng 1 2022: người mua hàng có xu hướng mua sắm nhiều hơn vào ba tháng cuối năm (10-12) và tháng 1 năm kế tiếp do nhu cầu mua sắm cuối/đầu năm tăng 
           và nhiều chương trình khuyến mãi/giảm giá cuối năm           
    - Giai đoạn bốn tháng đầu năm 2022: ghi nhận tỷ lệ lượng người mua tăng mạnh so với ba tháng cuối năm 2021, khả năng do TheLook triển khai chương trình khuyến mãi mới nhằm 
      kích cầu mua sắm các tháng đầu năm
    - Tháng 7 2021 ghi nhận lượng mua hàng tăng bất thường, trái ngược với lượng mua giảm sút so với cùng kì năm 2020, có thể do TheLook triển khai campaign đặc biệt cải thiện tình hình 
      doanh số cho riêng tháng 7.
*/

--2-- Giá trị đơn hàng trung bình (AOV) và số lượng khách hàng mỗi tháng
--Note: vì yêu cầu tập trung vào người dùng và không yêu cầu đơn hàng đã hoàn thành nên sử dụng 'created_at' (theo mình hiểu thì là ngày đơn hàng được tạo) làm mốc thời gian 
Select 
FORMAT_DATE('%Y-%m', created_at) as month_year,
count(DISTINCT user_id) as distinct_users,
round(sum(sale_price)/count(distinct order_id),2) as average_order_value
from bigquery-public-data.thelook_ecommerce.order_items
Where created_at BETWEEN '2019-01-01 00:00:00' AND '2022-05-01 00:00:00'
Group by month_year
ORDER BY month_year

/*--> Insight: - Giai đoạn năm 2019 do số lượng người dùng ít khiến giá trị đơn hàng trung bình qua các tháng có tỷ lệ biến động cao.
               - Giai đoạn từ cuối năm 2019 lượng người dùng ổn định trên 400 và nhìn chung tiếp tục tăng qua các tháng, giá trị đơn hàng trung bình qua các tháng ổn định ở mức ~80-90
                
--3-- Nhóm khách hàng theo độ tuổi
Tìm các khách hàng có trẻ tuổi nhất và lớn tuổi nhất theo từng giới tính ( Từ 1/2019-4/2022)
Output: first_name, last_name, gender, age, tag (hiển thị youngest nếu trẻ tuổi nhất, oldest nếu lớn tuổi nhất)
Hint: Sử dụng UNION các KH tuổi trẻ nhất với các KH tuổi trẻ nhất 
tìm các KH tuổi trẻ nhất và gán tag ‘youngest’  
tìm các KH tuổi trẻ nhất và gán tag ‘oldest’ 
Insight là gì? (Trẻ nhất là bao nhiêu tuổi, số lượng bao nhiêu? Lớn nhất là bao nhiêu tuổi, số lượng bao nhiêu) 
Note: Lưu output vào temp table rồi đếm số lượng tương ứng 



