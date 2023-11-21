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
 from year_spend
