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
Where City like '%a' Or City like'%e' Or City like'%i' Or City like'%o'Or City like'%u'
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
Select Name from Employee
Order by Name 
--EX8
Select name from Employee
Where salary>2000 
And months<10
Order by employee_id
--EX9
Select product_id from Products
Where low_fats='Y' 
And recyclable='Y'
--EX10
Select name from Customer
Where referee_id!=2 
Or referee_id is null
--EX11
Select name, population, area from World
Where area>=3000000
Or population>=25000000
--EX12
Select distinct author_id as id from Views
Where author_id=viewer_id
Order by author_id 
--EX13
SELECT part, assembly_step FROM parts_assembly
Where finish_date is null
--EX14
select * from lyft_drivers
Where yearly_salary<=30000 or yearly_salary>=70000
--EX15





