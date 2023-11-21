--EX 1--
With year_spend as   
  (Select extract(year from transaction_date) as yr,
       Product_id,
       Sum(spend) as curr_year_spend
  From user_transactions
  Group by extract(year from transaction_date), Product_id
  Order by product_id)
 Select *,
 lag(curr_year_spend) OVER(PARTITION BY product_id ORDER BY product_id) as prev_year_spend,
 Round((curr_year_spend-lag(curr_year_spend) OVER(PARTITION BY product_id ORDER BY product_id))
 /lag(curr_year_spend) OVER(PARTITION BY product_id ORDER BY product_id)*100,2)
 as yoy_rate
 from year_spend;

--EX2--
SELECT DISTINCT card_name, 
FIRST_VALUE(issued_amount) 
   OVER(PARTITION BY card_name Order by issue_year, issue_month) as issued_amount
FROM monthly_cards_issued
ORDER BY issued_amount DESC

--EX3--
With t1 as
(SELECT * ,
Rank() OVER(PARTITION BY user_id ORDER BY transaction_date) as rank
FROM transactions)
Select user_id, spend, transaction_date
from t1 where rank=3

--EX4--
With t1 AS
(SELECT transaction_date, user_id,
Count(product_id) OVER (PARTITION BY User_id 
                  ORDER BY transaction_date DESC) 
                  as purchase_count,
Row_number () OVER(PARTITION BY user_id
        ORDER BY transaction_date DESC)
        as rank
FROM user_transactions)

Select transaction_date, user_id, purchase_count 
from t1 where rank=1
ORDER BY transaction_date

--EX5--
