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

With t1 AS
(SELECT user_id, tweet_date, tweet_count, 
Row_number() Over(Partition by user_id order by tweet_date) as row_number 
FROM tweets
GROUP BY user_id, tweet_date, tweet_count)

Select user_id, tweet_date,
 Case 
  When row_number<=3 Then round(avg(tweet_count) Over(Partition by user_id 
                        order by tweet_date),2)  
  Else ROUND (CAST ((lag((tweet_count),2) Over(Partition by user_id 
                        order by tweet_date) 
                    +lag(tweet_count) Over(Partition by user_id 
                        order by tweet_date) 
                    +tweet_count)AS DECIMAL)/3,2)  
  End as rolling_3day_count
  From t1
  GROUP BY user_id, tweet_date, tweet_count, row_number

--EX6--
With t1 as
(SELECT credit_card_id,
EXTRACT(minute FROM(transaction_timestamp 
- lag(transaction_timestamp) Over (PARTITION BY merchant_id, credit_card_id, amount
                             ORDER BY transaction_timestamp))) as diff
From transactions)

Select count(credit_card_id) from t1
Where diff<=10

--EX 7-- 
 With top_spend as
   (Select category, product, sum(spend) as total_spend,
    rank() over (partition by category order by sum(spend) DESC) as category_ranking
    from product_spend
    Where Extract(year FROM transaction_date)=2022
    Group by category, product)
  Select category, product, total_spend from top_spend
  Where category_ranking<=2

--EX8--
With ranking_table as
(SELECT t3.artist_name as artist_name, 
Dense_rank () Over (order by count(t2.song_id) DESC) as artist_rank 
from global_song_rank as t1
Join songs as t2 on t1.song_id=t2.song_id
Join artists as t3 on t2.artist_id=t3.artist_id
Where t1.rank<=10
Group by t3.artist_name)

SELECT *
FROM ranking_table
WHERE artist_rank <= 5
