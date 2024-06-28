--Câu 1: 
Select distinct city
from station
where MOD(ID, 2) = 0

--Câu 2:
Select count(city)*1-count(distinct city)*1
From station

--Câu 3:
