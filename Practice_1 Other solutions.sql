--EX4:
Select DISTINCT  city from Station    -->> result cannot contain duplicates.
Where left(city,1) IN ('a','e','i','o','u');
