--Câu 1: 
Select distinct city
from station
where MOD(ID, 2) = 0

--Câu 2:
Select count(city)*1-count(distinct city)*1
From station

--Câu 3:
SELECT CEIL((AVG(salary)) - (AVG(REPLACE(salary, '0', '')))) AS avg_salary
From employees

--Câu 4:
SELECT round(sum(item_count :: decimal *order_occurrences)/sum(order_occurrences) , 1)
FROM items_per_order;

--Câu 5: 
SELECT candidate_id
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill) = 3
ORDER BY candidate_id;

--Câu 6:
SELECT user_id, extract(Day from max(post_Date) - MIN(post_Date)) as days_between
FROM posts
where extract(year from post_Date ) = 2021
Group by 1
having extract(Day from max(post_Date) - MIN(post_Date)) >0 
order by user_id
; 

--CÂU 7: 
SELECT card_name, max(issued_amount) - min(issued_amount) as difference
FROM monthly_cards_issued
Group by card_name
order by 2 desc ;

--Câu 8:
SELECT
  manufacturer,
  COUNT(drug) AS drug_count,
  ABS(SUM(total_sales - cogs)) AS total_loss
FROM pharmacy_sales
WHERE total_sales - cogs <= 0
GROUP BY manufacturer
ORDER BY total_loss DESC;


--Câu 9:
Select id, movie, description, rating
From cinema
where mod(id,2) <> 0 
and description <> 'boring'
order by rating desc

--Câu 10:

SELECT teacher_id, count(distinct subject_id) as cnt
From teacher
Group by 1

--Câu 11
Select user_id, count(follower_id) as followers_count
From followers 
Group by 1

-- Câu 12:
Select class
From courses
group by class
having count(student) >=5


