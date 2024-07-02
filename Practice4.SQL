--Câu 1:
SELECT sum(case when device_type in ('tablet','phone') then 1 else 0 end) as mobile_views,
SUM(case when device_type = 'laptop' then 1 else 0 end ) as laptop_views
FROM viewership;

--Câu 2: 
Select x,y,z,
case when x+y >z then 'Yes' else 'No' end as triangle
From triangle

--Câu 3:
