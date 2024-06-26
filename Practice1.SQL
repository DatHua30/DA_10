--Bài 1: 
Select name 
From city
where countrycode = 'USA' and population > 120000

--Bài 2: 
Select *
From city 
where countrycode = 'JPN'

--Bài 3:
Select city, state 
From station

--Bài 4: 
Select distinct city 
From station
where city like 'a%' or city like 'e%' or city like 'i%' or city like 'o%' or city like 'u%'

--Bài 5:
Select distinct city 
From station
where city like '%a' or city like '%e' or city like '%i' or city like '%o' or city like '%u'

--Bài 6: 
Select distinct city 
From station
where city not like 'a%' and city not like 'e%' and city not like 'i%' and city not like 'o%' and city not like 'u%'

--Bài 7: 
Select  name 
From employee
order by name

--Bài 8:
Select name 
From employee 
where salary >2000 and months <10 
order by employee_id

--Bài 9:
Select product_id 
From products
where low_fats = 'Y' and recyclable = 'Y'

--Bài 10: 
Select name
From Customer
Where referee_id <> 2 or referee_id is Null;

--Bài 11:
Select name, population, area
From World
Where area >= 30000000 OR population >= 25000000
ORDER BY NAME ASC;

--Bài 12:
Select distinct author_id as id
From Views
Where author_id = viewer_id
order by author_id ASC;

-Bài 13:
SELECT part, assembly_step FROM parts_assembly
where finish_Date is null;

--Bài 14
select * from lyft_drivers
where yearly_salary <= 30000 or yearly_salary >=70000;

--Bài 15
select * from uber_advertising
where year = 2019 and money_spent > 100000;









