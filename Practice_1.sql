-- EX1
Select name from CITY
Where Countrycode='USA'
AND population>120000
--EX2
Select * from CITY
Where countrycode='JPN'
--EX3
Select CITY, STATE from Station
--EX4
Select distinct City from Station
Where City like 'A%' 
Or City like'E%' 
Or City like'I%' 
Or City like'O%'
Or City like'U%'
--Hoặc 
Select distinct City from Station
Where Substr(City,1,1) In('A','E','I','O','U')
--EX5
