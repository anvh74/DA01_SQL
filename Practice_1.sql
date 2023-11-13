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
Where City like 'A%' Or City like'E%' Or City like'I%' Or City like'O%'Or City like'U%'
---Hoặc 
Select distinct City from Station
Where Left(City,1) In('A','E','I','O','U')
--EX5
Select distinct City from Station
Where City like '%a' 
Or City like'%e' 
Or City like'%i' 
Or City like'%o'
Or City like'%u'
---hoặc
Select distinct City from Station
Where Right(City,1) In('a','e','i','o','u')
--EX6
Select distinct City from Station
Where NOT (City like 'A%' Or City like'E%' Or City like'I%' Or City like'O%'Or City like'U%')
---hoặc
Select distinct City from Station
Where Not (Left(City,1) In('A','E','I','O','U'))
--EX7





