Select * from sales_dataset_rfm_prj;

/*
1/Chuyển đổi kiểu dữ liệu phù hợp cho các trường ( sử dụng câu lệnh ALTER) 
*/

-- Dữ liệu số (numeric/integer)
Alter table sales_dataset_rfm_prj
ALTER column ordernumber TYPE INT USING ordernumber::integer,
ALTER column quantityordered TYPE INT USING quantityordered::integer,
ALTER column priceeach TYPE numeric USING priceeach::numeric,
ALTER column orderlinenumber TYPE INT USING orderlinenumber::integer,
ALTER column sales TYPE numeric USING sales::numeric,
ALTER column msrp TYPE INT USING msrp::integer,
--Dữ liệu ngày
ALTER column orderdate TYPE DATE USING orderdate::date;

/*
2/Check NULL/BLANK (‘’)  ở các trường: 
   ORDERNUMBER, QUANTITYORDERED, PRICEEACH, ORDERLINENUMBER, SALES, ORDERDATE.
*/

Select * from sales_dataset_rfm_prj
Where ORDERNUMBER is null 
OR QUANTITYORDERED is null 
OR PRICEEACH is null 
OR ORDERLINENUMBER is null 
OR SALES is null;

/*
3/ Thêm cột CONTACTLASTNAME, CONTACTFIRSTNAME được tách ra từ CONTACTFULLNAME . 
   Chuẩn hóa CONTACTLASTNAME, CONTACTFIRSTNAME theo định dạng 
        chữ cái đầu tiên viết hoa, chữ cái tiếp theo viết thường. 
   Gợi ý: ( ADD column sau đó INSERT)
*/
ALTER TABLE sales_dataset_rfm_prj
ADD COLUMN CONTACTFIRSTNAME VARCHAR,
ADD COLUMN CONTACTLASTNAME  VARCHAR;

Update sales_dataset_rfm_prj 
SET CONTACTFIRSTNAME= 
      Initcap(Left(CONTACTFULLNAME, position('-' in CONTACTFULLNAME)-1)),
    CONTACTLASTNAME= 
      Initcap(Right(CONTACTFULLNAME,length(CONTACTFULLNAME)-position('-' in CONTACTFULLNAME)));
--> To check
Select CONTACTFIRSTNAME, CONTACTLASTNAME, CONTACTFULLNAME 
from sales_dataset_rfm_prj;

/*
4/ Thêm cột QTR_ID, MONTH_ID, YEAR_ID lần lượt là Qúy, tháng, năm 
    được lấy ra từ ORDERDATE 
*/

ALTER TABLE sales_dataset_rfm_prj
ADD COLUMN QTR_ID INT,
ADD COLUMN MONTH_ID INT,
ADD COLUMN YEAR_ID INT;

Update sales_dataset_rfm_prj 
SET QTR_ID= EXTRACT( QUARTER from ORDERDATE),
	MONTH_ID= EXTRACT(MONTH from ORDERDATE),
    YEAR_ID= EXTRACT(YEAR from ORDERDATE);
	
--> TO CHECK
Select ORDERDATE, QTR_ID, MONTH_ID, YEAR_ID from sales_dataset_rfm_prj;

/*
5/ Hãy tìm outlier (nếu có) cho cột QUANTITYORDERED 
   và hãy chọn cách xử lý cho bản ghi đó (2 cách) 
          ( Không chạy câu lệnh trước khi bài được review)
*/ 
Select quantityordered from sales_dataset_rfm_prj;
--Cách 1: dùng box plot
With box_plot as
(Select Q1-1.5*IQR as min_value,
        Q3+1.5*IQR as max_value
 from
(Select
percentile_cont(0.25) WITHIN GROUP (ORDER BY QUANTITYORDERED) as Q1,
percentile_cont(0.75) WITHIN GROUP (ORDER BY QUANTITYORDERED) as Q3,
percentile_cont(0.75) WITHIN GROUP (ORDER BY QUANTITYORDERED) 
- percentile_cont(0.25) WITHIN GROUP (ORDER BY QUANTITYORDERED) as IQR
from sales_dataset_rfm_prj) as calcualtion)

Select * from sales_dataset_rfm_prj 
Where QUANTITYORDERED>(select max_value from box_plot) 
or QUANTITYORDERED<(select min_value from box_plot);

--Cách 1: dùng Z-SCORE
With t1 as
(Select avg(QUANTITYORDERED) as avg,
stddev(QUANTITYORDERED) as stddev  
from sales_dataset_rfm_prj)
Select *, 
(QUANTITYORDERED-(Select avg from t1))/(Select stddev from t1) as Z_score
from sales_dataset_rfm_prj
Where abs(QUANTITYORDERED-(Select avg from t1))/(Select stddev from t1)>3;

--Xử lý các outliers tìm ra bởi Z-SCORE dùng DELETE

With outlier_list as 
(
With t1 as
(Select avg(QUANTITYORDERED) as avg,
stddev(QUANTITYORDERED) as stddev  
from sales_dataset_rfm_prj)
Select *, 
(QUANTITYORDERED-(Select avg from t1))/(Select stddev from t1) as Z_score
from sales_dataset_rfm_prj
Where abs(QUANTITYORDERED-(Select avg from t1))/(Select stddev from t1)>3
)
DELETE from sales_dataset_rfm_prj
Where QUANTITYORDERED in (select QUANTITYORDERED from outlier_list);
