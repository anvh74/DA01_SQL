
--EX1--
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

--<Hoặc dùng subquery in From>

--EX2-- >> 2 PRODUCT có doanh thu cao nhất CỦA MỖI C ATEGORY >> Dùng rank <Source: https://stackoverflow.com/questions/70191606/sum-overpartition-by-order-by-a-b>
 With top_spend as
   (Select category, product, sum(spend) as total_spend,
    rank() over (partition by category order by sum(spend) DESC) as category_ranking
    from product_spend
    Where Extract(year FROM transaction_date)=2022
    Group by category, product)
  Select category, product, total_spend from top_spend
  Where category_ranking<=2

--EX3--
With caller_times as
 (Select policy_holder_id, count(case_id) as call_count
  from callers
  Group by policy_holder_id)
 Select count(policy_holder_id) as member_count from caller_times
 Where call_count>=3

--EX4--
Select page_id from pages as t1
Where not page_id in
  (SELECT page_id from page_likes as t2
   Where t1.page_id=t2.page_id)
  
