--Cont project 1 sau khi chạy câu lệnh delete các outliers--
/* 1) Doanh thu theo từng ProductLine, Year  và DealSize?
Output: PRODUCTLINE, YEAR_ID, DEALSIZE, REVENUE
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






