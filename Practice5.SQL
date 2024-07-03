--Câu 1: 
Select country.continent, floor(avg(city.population))
From city 
inner join country 
on city.countrycode = country.code
group by 1

--Câu 2:
SELECT 
round(sum(case when a.signup_Action = 'Confirmed' then 1 else 0 end)*1.0/count(b.user_id)*1.0,2) as confirm_rate

FROM texts a 
left join emails b
on a.email_id = b.email_id 

--Câu 3: 
SELECT b.age_bucket,
round((sum(case when activity_type = 'open' then time_spent end)/sum(time_spent))*100.0,2) as open_perc,
round((sum(case when activity_type = 'send' then time_spent end)/sum(time_spent))*100.0,2) as send_perc
FROM activities a   
inner join age_breakdown b
on a.user_id = b.user_id 
where a.activity_type IN ('send', 'open') 
group by 1

--Câu 4:
SELECT a.customer_id
FROM customer_contracts a
inner join products b 
on a.product_id = b.product_id
group by 1
having count(distinct b.product_category) >=3;

--Câu 5:
Select a.employee_id, a.name, count(b.reports_to) as reports_count, round(avg(b.age),0) as average_Age
From employees a
inner join employees b
on a.employee_id = b.reports_to
Group by 1

--Câu 6: 
Select a.product_name, sum(b.unit) as unit
From products a
inner join orders b 
on a.product_id = b.product_id 
and extract(month from order_date) = '2' and extract(year from order_Date) = '2020'
Group by a.product_name
having sum(b.unit) >=100


--Câu 7: 

SELECT a.page_id 
FROM pages a   
left join page_likes b 
on a.page_id = b.page_id 
where b.liked_Date is null 
order by 1 





