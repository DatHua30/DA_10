--Câu 1:
with bang1 as(SELECT company_id, title, description
FROM job_listings
Group by 1,2,3
having count(job_id) > 1)
Select count(*)
From bang1

--Câu 2: 
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

--Câu 4;
SELECT a.page_id 
FROM pages a   
left join page_likes b 
on a.page_id = b.page_id 
where b.liked_Date is null 
order by 1 


--Câu 3:
with bang1 as( SELECT policy_holder_id, count(Call_Date) 
FROM callers
Group by 1 
having count(call_Date) >=3)

Select count(*) 
From bang1


--Câu 5:

with bang1 as(SELECT  extract(month from event_Date), user_id
FROM user_actions
where event_Date between '2022-06-01' and '2022-07-01'
and event_type in ('sign-in','like','comment'))

--Danh sách hoạt động tháng 7
SELECT  extract(month from a.event_Date), count( distinct a.user_id)
FROM user_actions a  
inner join bang1 b 
on a.user_id = b.user_id
where a.event_Date between '2022-07-01' and '2022-08-01'
and a.event_type in ('sign-in','like','comment')
Group by 1

--Câu 7:
SELECT
    product_id,
    year AS first_year,
    quantity,
    price
FROM Sales
WHERE
    (product_id, year) IN (
        SELECT
            product_id,
            MIN(year) AS year
        FROM Sales
        GROUP BY product_id
    );

--Câu 6:
SELECT
  DATE_FORMAT(trans_date, '%Y-%m') AS month,
  country,
  COUNT(*) AS trans_count,
  count( case when state = 'approved' then amount end) AS approved_count,
  SUM(amount) AS trans_total_amount,
  SUM(case when state = 'approved' then amount end) AS approved_total_amount
FROM Transactions
GROUP BY 1, 2;


-Câu 8:

with bang1 as(Select a.customer_id, b.product_key
From customer a
inner join product b 
on a.product_key = b.product_key )

Select customer_id
From bang1 
Group by 1
having count(product_key) =2 

--Câu 9:
Select employee_id 
From employees 
Where manager_id not in(Select employee_id
from employees)
and employee_id in (Select employee_id 
From employees 
where salary < 30000)

--Câu 10:
with bang1 as(SELECT company_id, title, description
FROM job_listings
Group by 1,2,3
having count(job_id) > 1)
Select count(*)
From bang1

--Câu 11:


