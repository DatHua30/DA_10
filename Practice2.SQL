--Câu 1: 
Select distinct city
from station
where MOD(ID, 2) = 0

--Câu 2:
Select count(city)*1-count(distinct city)*1
From station

--Câu 3:

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
