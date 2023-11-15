--EX1
Select 
Sum( Case 
          WHEN device_type in('laptop') then 1 Else 0
          End) as laptop_reviews,
Sum( CASE 
          WHEN device_type in ('tablet','phone') then 1 Else 0
          End) as mobile_views
from viewership
--EX2 
Select 
*,
Case 
  When x+y>z and x+z>y and y+z>x then 'Yes'
  Else 'No'
  End as triangle 
from Triangle
Group by triangle
--EX3 --> mình thử RUN sql như dưới và có tham khảo comment của những người khác nhưng kết quả trả ra đều là NULL
SELECT 
round(sum(CASE
       When call_category is null or call_category in ('n/a') then 1 
       ELSE 0
       End)*100
/count(case_id),1)
as call_percentage
FROM callers
--EX4
Select name 
from Customer
Where referee_id!=2 or referee_id is null
--EX 5 <https://platform.stratascratch.com/coding/9881-make-a-report-showing-the-number-of-survivors-and-non-survivors-by-passenger-class?code_type=1>
select 
survived,
Sum(Case
      When pclass=1 then 1 else 0
      End) as first_class,
Sum(Case
      When pclass=2 then 1 else 0
      End) as second_class,
Sum(Case
      When pclass=3 then 1 else 0
      End) as third_class
from titanic
Group by survived




