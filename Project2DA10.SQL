/*Câu 1:
SELECT concat(extract(year from created_at),'/',extract(month from created_At)) AS time,
count(order_id) as num_of_order, count(distinct user_id) as num_of_user
from bigquery-public-data.thelook_ecommerce.orders
where status = 'Complete'
and concat(extract(year from created_at),'/',extract(month from created_At)) between '2019-01' and '2022-04'
Group by 1
ORDER BY 1*/

--Câu 2: 
Select parse_date('%y-%m',concat(extract(year from created_at),'/',extract(month from created_At))) AS time,
count(distinct user_id) as num_of_users, round(sum(sale_price)/count(distinct order_id)*1.0,2) as monthly_avg_value
From bigquery-public-data.thelook_ecommerce.order_items
where status = 'Complete'
and concat(extract(year from created_at),'/',extract(month from created_At)) between '2019-01' and '2022-04'
Group by 1
order by 1
