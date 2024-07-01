--Câu 1: 
Select name
From students
where marks > 75 
order by right(name, 3), ID

--Câu 2:
Select user_id,
concat(Upper(left(name,1)), lower(substring(name, 2, length(name)-1))) as name
From users

--Câu 3:
SELECT manufacturer, concat('$',round(sum(total_Sales)/1000000,0), ' ', 'million')
FROM pharmacy_sales
Group by manufacturer
order by sum(total_Sales) desc, manufacturer;

--Câu 4:
SELECT extract(month from submit_Date) as mth, product_id, round(avg(stars),2) as avg_Stars
FROM reviews
Group by 1, product_id
order by 1, product_id

--Câu 5:
SELECT sender_id, count (DISTINCT message_id) as message_count 
FROM messages
where extract(month from sent_Date) = 8 and extract(year from sent_Date) = 2022
Group by sender_id
order by 2 desc 
limit 2;

--Câu 6:
Select tweet_id
From Tweets
where length(content)>15;

--Câu 7:
Select activity_Date as Day, count(distinct user_id) as active_users
From activity
where activity_Date between '2019-06-28' and '2019-07-31'
group by 1


--Câu 8: 
Select employee_id
From employees
where joining_Date between '2022-01-01' and '2022-07-31'

--Câu 9:
select position( 'a' in first_name)
from worker
where first_name = 'Amitah';

--Câu 10: 
select title, substring(title, position('2' in title), 4) as year
from winemag_p2
where country = 'Macedonia'




