
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

--EX5--
With active_user as 
 (SELECT user_id, EXTRACT(month from event_date) as month
  from user_actions 
  Where EXTRACT(year from event_date)='2022'
  and event_type in ('sign-in', 'like', 'comment')
  GROUP BY user_id, month )

Select t1.month, count(DISTINCT t1.user_id) from active_user as t1    --> t1 current month
Join active_user as t2                                                --> t2 previous month
on t1.user_id=t2.user_id and t1.month=t2.month+1
Where t1.month=7
Group by t1.month

--EX6--

SELECT  DATE_FORMAT(trans_date, '%Y-%m') as month,    -->> lọc năm vả tháng
        country, 
        COUNT(id) as trans_count, 
        SUM(Case When state in ('approved') then 1 else 0 END) as approved_count,
        SUM(amount) as trans_total_amount,
        SUM(Case When State in ('approved') then amount else 0 END) as approved_total_amount
FROM  Transactions
GROUP BY month,country
 
--With CTE-- >> Processing...
With approved_trans as
  (Select DATE_FORMAT(trans_date, '%Y-%m') as month,
   country,
   count(id) as approved_count,
   sum(amount) as approved_total_amount
   from Transactions 
   Where state in ('approved')
   Group by month, country)

Select DATE_FORMAT(t1.trans_date, '%Y-%m') as month,
t1.country,
count(t1.id) as trans_count,
t2.approved_count, 
sum(t1.amount) as trans_total_amount, t2.approved_total_amount
 from Transactions as t1
 Join approved_trans as t2 on t1.trans_date=t2.month and t1.country=t2.country
Group by month, country

--EX7--
With year_rank_product AS
(SELECT product_id, year, quantity, price, 
        RANK() OVER(partition by product_id order by year) as year_rank
        from Sales)
SELECT product_id, year as first_year, quantity, price
FROM year_rank_product
WHERE year_rank = 1

--EX8--
Select customer_id from customer
Group by customer_id
Having count(DISTINCT product_key)=(Select count(DISTINCT product_key) from product)

--EX9--
Select employee_id
From employees
Where salary<30000
and manager_id not in (Select employee_id from employees)
Order by employee_id

--EX10-- >> Link trên ripid trùng với EX1, các bạn cho mình xin link khác nhé

--EX11--
(select t2.name as results
    from movierating as t1
    Join users as t2 on t1.user_id=t2.user_id
    Group by t1.user_id
    Order by count( distinct t1.movie_id) DESC, name
    Limit 1)
 Union all    
    (Select t2.title as results
    from movierating as t1
    Join movies as t2 on t1.movie_id=t2.movie_id
    where t1.created_at between '2020-02-01' and '2020-02-28'
    Group by t1.movie_id
    Order by avg(t1.rating) DESC, t2.title 
    Limit 1)

--EX12--


 
