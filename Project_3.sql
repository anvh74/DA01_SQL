--Cont project 1 sau khi chạy câu lệnh delete các outliers--
/* 1) Doanh thu theo từng ProductLine, Year  và DealSize?
Output: PRODUCTLINE, YEAR_ID, DEALSIZE, REVENUE  <với revenue mình sử dụng cột sales sau khi so sánh sales và quantityordered * priceeach>
*/
Select productline, year_id, dealsize, sum(sales) as revenue
from sales_dataset_rfm_prj
Group by productline, year_id, dealsize
Order by productline, year_id, dealsize DESC;

/*
2) Đâu là tháng có doanh thu bán tốt nhất mỗi năm?
Output: MONTH_ID, REVENUE, ORDER_NUMBER
*/
select month_id, sum(sales) as revenue, count(distinct ordernumber)
from sales_dataset_rfm_prj
Group by month_id
Order by sum(sales) DESC 
  --> Ans: tháng 11 có doanh thu lớn nhất năm

/*
3) Product line nào được bán nhiều ở tháng 11?
Output: MONTH_ID, REVENUE, ORDER_NUMBER
*/
select month_id, productline, sum(sales) as revenue, count(distinct ordernumber)
from sales_dataset_rfm_prj
Where month_id=11
Group by month_id, productline
Order by sum(sales) DESC
  --> Ans: trong tháng 11 'Classic Cars' bán được nhiều đơn nhất và tạo doanh thu cao nhất

/*
4) Đâu là sản phẩm có doanh thu tốt nhất ở UK mỗi năm? 
Xếp hạng các các doanh thu đó theo từng năm.
Output: YEAR_ID, PRODUCTLINE,REVENUE, RANK
*/
  
Select * from
(
Select year_id, productline, sum(sales) as revenue,
row_number() OVER(PARTITION BY year_id, country ORDER BY sum(sales)) as rank
from sales_dataset_rfm_prj
Where country='UK'
Group by year_id, productline, country
) as UK_ranking
Where rank=1
  /*
  --> Ans: Sản phẩm có doanh thu tốt nhất ở UK mỗi năm lần lượt là: 
            - 2003: Planes
            - 2004: Trains
            - 2005: Motorcycles  */

/*
5) Ai là khách hàng tốt nhất, phân tích dựa vào RFM 
(sử dụng lại bảng customer_segment ở buổi học 23)
*/
--Tạo bảng segment_score và import customer_segment ở buổi học 23
  CREATE TABLE segment_score
(
    segment Varchar,
    scores Varchar)
  
--CÁC BƯỚC RFM <RECENCY-FREQUENCY-MONETARY>--
/*Bước 1: tính giá trị R-F-M
*/
select * from sales_dataset_rfm_prj where ordernumber=10119; --> customers' info & status per order 
--CÁC BƯỚC PHÂN TÍCH THEO RFM <RECENCY-FREQUENCY-MONETARY>--
/*Bước 1: tính giá trị R-F-M
*/
With customer_rfm as
(
Select 
customername,
current_date - max(orderdate) as r,
count(distinct ordernumber) as f,
sum(sales) as m
from sales_dataset_rfm_prj
Group by customername
),
/*Bước 2: Chia các giá trị theo các thang điểm từ 1-5
*/
customer_score as
(
Select customername, 
ntile(5) OVER(ORDER BY r) as r_score,
ntile(5) OVER(ORDER BY f) as f_score,
ntile(5) OVER(ORDER BY m) as m_score
from customer_rfm
),
/*Bước 3: phân nhóm 125 theo tổ hợp RFM
*/
rfm_final as
(
Select customername,
cast(r_score as varchar)||cast(f_score as varchar)||cast(m_score as varchar) 
	as rfm_score
from customer_score
)
/* Bước 4: phân loại 125 tổ hợp segment_score
*/
Select t1.customername,
t2.segment
from rfm_final as t1
join public.segment_score as t2 on t1.rfm_score=t2.scores
  --> Khách hàng tốt nhất (Champions) là "Baane Mini Imports"








