II.
/*Câu 1:
SELECT format_DAte('%Y-%m', created_at) AS time,
count(order_id) as num_of_order, count(distinct user_id) as num_of_user
from bigquery-public-data.thelook_ecommerce.orders
where status = 'Complete'
and format_DAte('%Y-%m', created_at) between '2019-01' and '2022-04'
Group by 1
ORDER BY 1*/

--Câu 2: 
Select format_DAte('%Y-%m', created_at) AS time,
count(distinct user_id) as num_of_users, round(sum(sale_price)/count(distinct order_id)*1.0,2) as monthly_avg_value
From bigquery-public-data.thelook_ecommerce.order_items
where status = 'Complete'
and format_DAte('%Y-%m', created_at) between '2019-01' and '2022-04'
Group by 1
order by 1

--Câu 3:
CREATE OLDEST_AND_YOUNGEST_CUS AS(with bang1 as(Select first_name, last_name, gender, age, 
case when age <50 then 'youngest' else 'oldest' end as tag
From bigquery-public-data.thelook_ecommerce.users
where age in(SELECT min from(
--trẻ tuổi nhất theo từng giới tính
Select gender, min(age) as min
from bigquery-public-data.thelook_ecommerce.users
where format_DAte('%Y-%m', created_at) between '2019-01' and '2022-04'
group by 1

union all
--Cao tuổi nhất theo từng giới tính     
Select gender, max(age) as max
from bigquery-public-data.thelook_ecommerce.users
format_DAte('%Y-%m', created_at) between '2019-01' and '2022-04'
group by 1)))

Select gender, tag, count(*)
From bang1 
Group by 1,2)

=>>>Nhận xét:
-Độ tuổi trẻ nhất và già nhất đối với cả 2 giới tính là 12 tuổi và 70 tuổi
-Xét về giới tính nam, có 831 khách hàng thuộc nhóm trẻ nhất và 875 khách hàng thuộc nhóm tuổi già nhất
-Xét về giới tính nữ, có 888 khách hàng thuộc nhóm trẻ nhất và 832 khách hàng thuộc nhóm tuổi già nhất

--Câu 4:
with bang1 as(Select format_Date('%Y-%m',a.created_at) as time, a.product_id, b.name, round(sum(a.sale_price),0) as total_sales, round(sum(b.cost),0) as total_cost, round(sum(a.sale_price) - sum(b.cost),0) as profit 
From bigquery-public-data.thelook_ecommerce.order_items a
inner join bigquery-public-data.thelook_ecommerce.products b 
on a.product_id = b.id
Group by 1,2,3
order by 1)

,bang2 as(Select *, dense_rank() over(partition by time order by profit desc) as rank
From bang1 )

Select *
From bang2 
where rank in (1,2,3,4,5)

--Câu 5:
Select Format_date('%Y-%m-%d', a.created_At) as time, b.category, round(sum(sale_price),0) as rev 
From bigquery-public-data.thelook_ecommerce.order_items a
inner join bigquery-public-data.thelook_ecommerce.products b
on a.product_id =b.id
where Format_date('%Y-%m-%d', a.created_At) between '2022-04-15' and '2022-07-15'
Group by 1,2
order by 1

III.
1. Output của bảng thông tin
--Tổng doanh thu mỗi tháng của từng category
-- SELECT format_Date('%Y-%m', a.created_At) as month, extract(year from a.created_At) as year,
--     c.category,
--     round(sum(b.sale_price),0) as TPV

-- From bigquery-public-data.thelook_ecommerce.orders a 
-- inner join bigquery-public-data.thelook_ecommerce.order_items b
-- on a.order_id = b.order_id
-- inner join bigquery-public-data.thelook_ecommerce.products c
-- on b.product_id = c.id
-- GROUP BY 1,2,3 
-- order by 1

--Tổng số đơn hàng mỗi tháng của từng category
-- SELECT format_Date('%Y-%m', a.created_At) as month, extract(year from a.created_At) as year,
--     c.category,
--     count(a.order_id) as TPV

-- From bigquery-public-data.thelook_ecommerce.orders a 
-- inner join bigquery-public-data.thelook_ecommerce.order_items b
-- on a.order_id = b.order_id
-- inner join bigquery-public-data.thelook_ecommerce.products c
-- on b.product_id = c.id
-- GROUP BY 1,2,3 
-- order by 1

--Revenue growth của từng category
-- with bang1 as(SELECT format_Date('%Y-%m', a.created_At) as month, extract(year from a.created_At) as year,
--     c.category,
--     round(sum(b.sale_price),0) as TPV

-- From bigquery-public-data.thelook_ecommerce.orders a 
-- inner join bigquery-public-data.thelook_ecommerce.order_items b
-- on a.order_id = b.order_id
-- inner join bigquery-public-data.thelook_ecommerce.products c
-- on b.product_id = c.id
-- GROUP BY 1,2,3 
-- order by 1)

-- Select month, year, category,
-- round((lead(TPV) over(partition by category order by month)- TPV)*100/TPV,0) as Revenue_growth
-- From bang1

--Order growth của từng category
-- with bang2 as(SELECT format_Date('%Y-%m', a.created_At) as month, extract(year from a.created_At) as year,
--     c.category,
--     count(a.order_id) as TPV

-- From bigquery-public-data.thelook_ecommerce.orders a 
-- inner join bigquery-public-data.thelook_ecommerce.order_items b
-- on a.order_id = b.order_id
-- inner join bigquery-public-data.thelook_ecommerce.products c
-- on b.product_id = c.id
-- GROUP BY 1,2,3 
-- order by 1)

-- Select month, year, category,
-- round((lead(TPV) over(partition by category order by month) -TPV)*100/TPV,0) as Order_growth
-- From bang2

--Tổng chi phí mỗi tháng của từng category

-- SELECT format_Date('%Y-%m', a.created_At) as month, extract(year from a.created_At) as year,
--     c.category,
--     round(sum(c.cost),0) as Total_cost

-- From bigquery-public-data.thelook_ecommerce.orders a 
-- inner join bigquery-public-data.thelook_ecommerce.order_items b
-- on a.order_id = b.order_id
-- inner join bigquery-public-data.thelook_ecommerce.products c
-- on b.product_id = c.id
-- GROUP BY 1,2,3 
-- order by 1


--Total_profit của từng category
-- with bang1 as(SELECT format_Date('%Y-%m', a.created_At) as month, extract(year from a.created_At) as year,
--     c.category,
--     sum(b.sale_price) - sum(c.cost) as total_profit

-- From bigquery-public-data.thelook_ecommerce.orders a 
-- inner join bigquery-public-data.thelook_ecommerce.order_items b
-- on a.order_id = b.order_id
-- inner join bigquery-public-data.thelook_ecommerce.products c
-- on b.product_id = c.id
-- GROUP BY 1,2,3 
-- order by 1)

-- Select month, year, category,
-- round(sum(total_profit) over(partition by category order by month),0) as total_profit_per_category
-- -- sum(total_profit) over(partition by month order by month) as total_profit_per_month
-- From bang1

--Tỉ lệ lợi nhuận/chi phí mỗi tháng

SELECT format_Date('%Y-%m', a.created_At) as month, extract(year from a.created_At) as year,
    c.category,
    round((sum(b.sale_price) - sum(c.cost))*100/sum(c.cost),0) as profit_to_cost_ratio

From bigquery-public-data.thelook_ecommerce.orders a 
inner join bigquery-public-data.thelook_ecommerce.order_items b
on a.order_id = b.order_id
inner join bigquery-public-data.thelook_ecommerce.products c
on b.product_id = c.id
GROUP BY 1,2,3 
order by 1


