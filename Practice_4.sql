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
