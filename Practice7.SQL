--Câu 1:
SELECT EXTRACT(year from transaction_Date) as year, product_id,
spend
,lag(spend) over( PARTITION BY product_id order by EXTRACT(year from transaction_Date) ) as prev_year_spend,
round((spend - lag(spend) over( PARTITION BY product_id order by EXTRACT(year from transaction_Date) ))*100.0/lag(spend) over( PARTITION BY product_id order by EXTRACT(year from transaction_Date) ),2) as yoy_Rate
FROM user_transactions
;

--Câu 2:
SELECT 
distinct card_name,
first_value(issued_amount) over(PARTITION BY card_name order by issue_year, issue_month)
FROM monthly_cards_issued
order by 2 desc;

--Câu 3:
with bang1 as( SELECT user_id, spend, transaction_Date,
row_number() over(PARTITION BY user_id order by transaction_Date)
FROM transactions)

Select user_id, spend, transaction_Date
From bang1 
where row_number = 3

--Câu 4:
with bang1 as( Select transaction_Date, user_id, 
RANK() over(PARTITION BY user_id ORDER BY transaction_Date desc) 
From user_transactions)

Select transaction_Date, user_id, count(*)
From bang1 
where rank = 1 
Group by 1,2

--Câu 5:
SELECT user_id, tweet_Date,
round(avg(tweet_count) over(PARTITION BY user_id order by tweet_Date rows between 2 preceding and current row),2)

FROM tweets;

--Câu 6:
with bang1 as(SELECT *,
extract(epoch from transaction_timestamp - LAG(transaction_timestamp) over( PARTITION BY merchant_id, credit_card_id, amount order by transaction_timestamp ))/60 as time_diff
FROM transactions)

Select count(merchant_id) 
From bang1
where time_diff <=10
--Câu 7:
with bang1 as(SELECT category, product, sum(spend)
FROM product_spend
where category = 'electronics' and extract(year from transaction_Date) ='2022'
group by 1,2

union all 

SELECT category, product, sum(spend)
FROM product_spend 
where category = 'appliance' and extract(year from transaction_Date) ='2022'
group by 1,2)

, bang2 as(Select * 
from bang1 
order by sum desc
limit 4)

Select *
From bang2 
order by category 

--Câu 8: 
with bang1 as(SELECT c.artist_name, count(a.song_id),
dense_rank() over(order by count(a.song_id) desc)
FROM global_song_rank a  
inner join songs b 
on a.song_id = b.song_id 
inner join artists c 
on b.artist_id = c.artist_id
where rank <= 10
Group by 1
order by 2 desc)

Select artist_name, dense_Rank
From bang1 
where dense_Rank in (1,2,3,4,5)
