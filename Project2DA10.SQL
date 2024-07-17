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
group by 1

union all
--Cao tuổi nhất theo từng giới tính     
Select gender, max(age) as max
from bigquery-public-data.thelook_ecommerce.users
group by 1)))

Select gender, tag, count(*)
From bang1 
Group by 1,2)

=>>>Nhận xét:
-Độ tuổi trẻ nhất và già nhất đối với cả 2 giới tính là 12 tuổi và 70 tuổi
-Xét về giới tính nam, có 831 khách hàng thuộc nhóm trẻ nhất và 875 khách hàng thuộc nhóm tuổi già nhất
-Xét về giới tính nữ, có 888 khách hàng thuộc nhóm trẻ nhất và 832 khách hàng thuộc nhóm tuổi già nhất

--Câu 4:

