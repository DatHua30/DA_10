--Câu 1:
Select productline, year_id, deal_size,
	sum(quantity_ordered * price_Each) as revenue
From public.sales_dataset_rfm_prj_clean
Group by 1,2,3
order by 2

--Câu 2:
with bang1 as(
Select year_id, month_id, sum(quantity_ordered * price_Each) as revenue,
dense_Rank() over(partition by year_id order by sum(quantity_ordered * price_Each) desc ) as stt
From public.sales_dataset_rfm_prj_clean
Group by 1,2
order by 1, 3 desc)

Select year_id, month_id, revenue
From bang1
where stt = 1

=>> Tháng 11/2003, tháng 11/2004, tháng 5/2005 có doanh thu cao nhất

--Câu 3: 
with bang1 as(Select year_id, productline, sum(quantity_ordered * price_Each) as revenue,
dense_Rank() over(partition by year_id order by sum(quantity_ordered * price_Each) desc ) as stt
From public.sales_dataset_rfm_prj_clean
where month_id = 11
Group by 1,2
order by 1, 3 desc)

Select year_id, productline, revenue
From bang1
where stt = 1

=>>Classic Cars là product line được bán nhiều nhất ở tháng 11 từng năm

--Câu 4:
with bang1 as(Select year_id, productline, sum(quantity_ordered * price_Each) as revenue,
dense_Rank() over(partition by year_id order by sum(quantity_ordered * price_Each) desc ) as stt
From public.sales_dataset_rfm_prj_clean
where country = 'UK'
Group by 1,2
order by 1, 3 desc)

Select year_id, productline, revenue
From bang1
where stt = 1

=>> Năm 2003, sản phẩm có doanh thu tốt nhất tại UK là classic cars
 Năm 2004, sản phẩm có doanh thu tốt nhất tại UK là vintage cars
 Năm 2005, sản phẩm có doanh thu tốt nhất tại UK là motorcycles

--Câu 5:
--Bước 1: tính giá trị RFM
with bang1 as(Select customer_name, 
	current_Date - max(order_Date) as R,
	count(distinct order_number) as num_order,
	max(order_DAte) - min(order_date) as day_Diff,
	sum(quantity_ordered * price_Each) as M
From public.sales_dataset_rfm_prj_clean
Group by 1)

, customer_rfm as(Select customer_name, R,
num_order*1.0/(case when day_diff = 0 then 1 else day_diff end ) as F,
M
fROM BANG1)

, rfm_score as(Select customer_name,
ntile(5) over(order by R desc) as R_score,
ntile(5) over(order by F) as F_Score,
ntile(5) over(order by M) as M_score
From customer_rfm)
, final as(Select customer_name,
R_Score:: varchar || F_score::varchar ||M_Score::varchar as RFM_score
From rfm_Score)

Select final.customer_name, segmentscore.segment
From final
inner join segmentscore
on final.RFM_Score = segmentscore.score
where segmentscore.segment in ('Champion','Loyal')
