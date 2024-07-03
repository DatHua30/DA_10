--Câu 1:
SELECT sum(case when device_type in ('tablet','phone') then 1 else 0 end) as mobile_views,
SUM(case when device_type = 'laptop' then 1 else 0 end ) as laptop_views
FROM viewership;

--Câu 2: 
Select x,y,z,
case when x+y >z and x+z>y and y+z>x then 'Yes' else 'No' end as triangle
From triangle

--Câu 3:
SELECT round((sum(case when call_category = 'n/a' or call_category is null then 1 else 0 end)*1.0/count(*)*1.0)*100,1)
FROM callers

--Câu 4:
Select name
From Customer
Where referee_id <> 2 or referee_id is Null;

--Câu 5:
select survived, 
sum(case when pclass = 1 then 1 else 0 end) as first_class,
sum(Case when pclass = 2 then 1 else 0 end) as second_Class,
sum(case when pclass = 3 then 1 else 0 end) as third_class
from titanic
group by 1;
