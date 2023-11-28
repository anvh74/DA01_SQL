_1--EX1--
With 
 title_by_company AS
  (Select company_id, title, count(title) as count_title
  from job_listings
  Group by company_id, title)
Select count(DISTINCT company_id) as duplicate_companies
from title_by_company
Where count_title>1

  Hoặc
With 
 title_by_company AS
  (Select company_id, title, count(title) as count_title
  from job_listings
  Group by company_id, title
  Having count(title)>1)
Select count(DISTINCT company_id) as duplicate_companies
from title_by_company

--EX2--
