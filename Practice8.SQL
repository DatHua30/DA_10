--Câu 1:
with bang1 as(Select customer_id, delivery_id,
Case when order_Date = customer_pref_delivery_Date then 'immediate' 
else 'scheduled' end as type ,
row_number() over(partition by customer_id order by order_Date) as order_num
From delivery)

Select count(case when type = 'immediate' then delivery_id end)*100.0/count(*)*1.0 as immediate_percentage
From bang1 
where order_num = 1

--Câu 2:
with bang1 as(Select player_id, event_date, 
lead(event_Date) over(partition by player_id order by event_Date) as dayafter,
lead(event_Date) over(partition by player_id order by event_Date) -event_Date as day_diff
From activity)

Select round(count(distinct case when day_diff = 1 then player_id end)*1.0/count(distinct player_id),2) as fraction
From bang1


--Câu 3:
with bang1 as(SELECT id, student,
Case when mod(id,2)=0 then id - 1
else id + 1 end as new_id
FROM Seat
order by 3 ) 

Select  
row_number() over(order by new_id) as id, student
From bang1

--Câu 4:


--Câu 5:
with bang1 as(Select pid, tiv_2015, 
dense_rank() over(order by tiv_2015) as stt
From insurance 
order by 2 )
, bang2 as(Select pid 
From bang1
where stt = 1)

/*unique lat lon */

,bang3 as(Select pid, lat, lon, 
dense_rank() over(order by lat, lon) as stt2
From insurance)
,bang4 as(Select pid
From bang3 
where stt2 <>2)

,bang5 as(Select a.pid
From bang2 a 
inner join bang4 b 
on a.pid = b.pid)

SElect sum(tiv_2016) as tiv_2016
From insurance 
where pid in (Select a.pid
From bang2 a 
inner join bang4 b 
on a.pid = b.pid)

--Câu 6:
with bang1 as(Select a.name as department, b.name, b.salary,
dense_rank() over(partition by a.name order by b.salary desc) as stt
From department a 
inner join employee b 
on b.departmentId = a.id)
Select department, name, salary
From bang1
where stt in (1,2,3)
order by 3 desc

