--EX4:
Select DISTINCT  city from Station    -->> result cannot contain duplicates.
Where left(city,1) IN ('a','e','i','o','u');

--EX5:
Select DISTINCT  city from Station    -->> result cannot contain duplicates.
Where right(city,1) IN ('a','e','i','o','u');

--EX6: 
Select DISTINCT  city from Station    -->> result cannot contain duplicates.
Where left(city,1) NOT IN ('a','e','i','o','u');

--EX10:
Select name from Customer
Where referee_id !=2    -->> chỉ lọc các giá trị không null
 OR referee_id is null; -->> phải lọc riêng các giá trị không null;





