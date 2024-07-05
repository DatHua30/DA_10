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

--Câu 3:

