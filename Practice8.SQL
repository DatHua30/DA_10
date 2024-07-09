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
