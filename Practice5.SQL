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
