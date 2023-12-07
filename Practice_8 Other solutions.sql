select id, 
    case when id%2 <> 0 then coalesce(lead(student)over(order by id), student)
    else lag(student)over(order by id) end student
from Seat 

