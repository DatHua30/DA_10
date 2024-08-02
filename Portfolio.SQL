Since the focus of this analysis is on customers, therefore, I create and import 4 main table realting to customers.

CREATE TABLE olist_geolocation_dataset (
	geolocation_zip_code_prefix int,
	geolocation_lat decimal,
	geolocation_lng decimal,
	geolocation_city varchar,
	geolocation_state varchar
)

Create table olist_orders_dataset (
	order_id varchar,
	customer_id varchar,
	order_status varchar,
	order_purchase_timestamp varchar,
	order_approved_at varchar,
	order_delivered_carrier_Date varchar,
	order_delivered_customer_date varchar,
	order_estimated_delivery_date varchar
)

After that, I changed the date format of the remaining to timestamp
alter table public.olist_orders_dataset
alter column order_purchase_timestamp type timestamp using(order_purchase_timestamp:: timestamp )

alter table public.olist_orders_dataset
alter column order_estimated_delivery_Date type timestamp using(order_estimated_delivery_date:: timestamp )


Changing the date format in tables:

alter table public.olist_orders_item_dataset
alter column shipping_limit_date type timestamp  using(shipping_limit_date::timestamp)
DATA CLEANING
After importing data, I noticed there were several syntax errors and inconsistency in date format in the datasets, so I used SQL code to replace the syntax error and update the format.

Dealing with null
when examining the olist_orders_dataset table, I realize that null values appeared in 3 columns:order_approved_at, order_delivered_Carrier_Date, and
order_delivered_Customer_Date. In fact, when doing analysis on customers, I don't really need these columns, therefore, I determined to delete these columns and changing the foramt type of the remaining.

alter table public.olist_orders_dataset
drop column order_approved_At 

alter table public.olist_orders_dataset
drop column order_delivered_carrier_Date 

alter table public.olist_orders_dataset
drop column order_Delivered_customer_DAte

Checking other tables by using is null, I found that the dataset does not contain any NULL values.
Select *
From public.olist_customer_dataset
where customer_id is null

Select *
From public.olist_geolocation_dataset
where geolocation_zip_code_prefix is null

Select *
From public.olist_orders_item_dataset
where order_id is null

Select *
From segment_Score
where segment is null or scores is null


Cleaning duplicate value
By using the ROW_NUMBER() function to group the data and setting the condition that it is greater than 1, we found that the dataset does not contain any duplicate data
Select * From (Select *,
	ROW_NUMBER() OVER(PARTITION BY order_id, order_item, product_id, seller_id, price, freight_value) as stt
From public.olist_orders_item_dataset ) as bang1
where stt >1


Select * From (Select *,
	ROW_NUMBER() OVER(PARTITION BY order_id, customer_id, order_status) as stt
From public.olist_orders_dataset) as bang1
where stt >1



Removing outliers in price, freight_value and order_item in olist_orders_item_dataset table using box plot. In order to not affect the number of rows,
I will choose to update the outliers value with the average values of those outliers.

--Price
with bang1 as(Select percentile_cont(0.25) within group(order by price) as Q1,
percentile_cont(0.75) within group(order by price) as Q3,
percentile_cont(0.75) within group(order by price) - percentile_cont(0.25) within group(order by price) as IQR
From public.olist_orders_item_dataset)

, bang2 as(
	Select Q1-1.5*IQR as min_value,
Q3+1.5*IQR as max_Value
From bang1 )

,bang3 as(Select price 
From public.olist_orders_item_dataset
where price < (Select min_Value from bang2) 
or price > (Select max_value from bang2))

Update public.olist_orders_item_dataset
set price = (Select avg(price) From public.olist_orders_item_dataset )
where price in (Select price from bang3)

--Freight value
with bang1 as(Select percentile_cont(0.25) within group(order by freight_value) as Q1,
percentile_cont(0.75) within group(order by freight_value) as Q3,
percentile_cont(0.75) within group(order by freight_value) - percentile_cont(0.25) within group(order by freight_Value) as IQR
From public.olist_orders_item_dataset)

, bang2 as(
	Select Q1-1.5*IQR as min_value,
Q3+1.5*IQR as max_Value
From bang1 )

,bang3 as(Select freight_Value 
From public.olist_orders_item_dataset
where freight_Value < (Select min_Value from bang2) 
or freight_Value > (Select max_value from bang2))

Update public.olist_orders_item_dataset
set freight_Value = (Select avg(freight_Value) From public.olist_orders_item_dataset )
where freight_Value in (Select freight_Value from bang3)

--order_item

with bang1 as(Select percentile_cont(0.25) within group(order by order_item) as Q1,
percentile_cont(0.75) within group(order by order_item) as Q3,
percentile_cont(0.75) within group(order by order_item) - percentile_cont(0.25) within group(order by order_item) as IQR
From public.olist_orders_item_dataset)

, bang2 as(
	Select Q1-1.5*IQR as min_value,
Q3+1.5*IQR as max_Value
From bang1 )

,bang3 as(Select ORDER_ITEM
From public.olist_orders_item_dataset
where order_item < (Select min_Value from bang2) 
or order_item > (Select max_value from bang2))

Update public.olist_orders_item_dataset
set order_item = (Select avg(order_item) From public.olist_orders_item_dataset )
where order_item in (Select order_item from bang3)

As previously mentioned, this project will focus solely on the year 2018. To optimize code run-time, I will create a new table named 'olist_orders_Dataset_2018', which will include only the data of customers who made purchases in 2018 and their orders were ‘delivered’
Create table olist_orders_dataset_2018 as (
Select *
From public.olist_orders_dataset
where customer_id in (Select customer_id
From public.olist_orders_dataset
where extract(year from order_purchase_timestamp) = '2018' 
and order_status = 'delivered'))



--Analysis
EDA: FIND LIST OF CHURN CUSTOMERS
with bang1 as(Select customer_id, max(order_purchase_timestamp) as latest_Date,
('2018-12-31'-max(cast(order_purchase_timestamp as date))) as date_diff
From public.olist_orders_dataset_2018
group by 1
order by 3 desc)

,bang2 as(Select customer_id,
	case when date_diff >150 then 'Churn' else 'Normal' end as category
from bang1)

,bang3 as(Select a.customer_id, a.category, b.customer_city, b.customer_state
From bang2 a
inner join public.olist_customer_dataset b 
on a.customer_id = b.customer_id
)

A.Churn customer persona
TOP 10 STATE
Select customer_CITY, count(customer_id)
From bang3 
where category = 'Churn'
group by 1
order by 2 desc  
LIMIT 10
SP has the highest number of churned customers (20,446), significantly more than the second-highest state, the RJ (5,682). 

TOP 10 CITY
Select customer_CITY, count(customer_id)
From bang3 
where category = 'Churn'
group by 1
order by 2 desc  
limit 10






--First I find out the distribution of customer in the country according to state
Select customer_state, count( customer_id) as num_of_cus
From public.olist_customer_dataset
Group by 1 
order by 2 desc

From this, I found out that the majority of Olist's customers come from SP, RJ, MG

Next, I calculate the average revenue per customer according to each state
Select customer_state, round(sum(price + freight_value)/count(distinct c.customer_id)*1.0,2) as total_revenue_percapita
From public.olist_orders_item_dataset a 
inner join  public.olist_orders_dataset b 
on a.order_id = b.order_id 
inner join public.olist_customer_dataset c 
on b.customer_id = c.customer_id
Group by 1 
order by 2 desc

From this, I found out that although AP,AC, RR are states with lowest numbers of customer but the customers in these states spend more than any other states in the data







RFM ANALYSIS
--First I calculate 
with bang1 as(Select c.customer_id, round(extract(epoch from current_Date - max(b.order_purchase_timestamp))/3600,0) as R,
count(distinct a.order_id) as F,
round(sum(a.price*a.order_item+a.freight_Value*a.order_item),0) as M
From public.olist_orders_item_dataset a
inner join  public.olist_orders_dataset_2018 b 
on a.order_id = b.order_id 
inner join public.olist_customer_dataset c 
on b.customer_id = c.customer_id
Group by 1)

, rfm_Score as(Select customer_id, 
ntile(5) over(order by R desc) as R_Score,
ntile(5) over(order by F) as F_Score,
ntile(5) over(order by M) as M_score
From bang1)

, final as(Select customer_id, R_Score:: varchar || F_score::varchar ||M_Score::varchar as RFM_score
From rfm_Score)

, bangcuoi as(Select a.customer_id, 
b.segment
From final a 
inner join public.segment_score b 
on a.RFM_score = b.scores)

Select segment, count(customer_id)
From bangcuoi
group by 1
order by 2

After find out the distribution of customers in RFM group, I find out the revenue of each group accordingly
, doanhthu as(Select a.customer_id, a.segment,
round(sum(c.price*c.order_item + c.freight_Value*c.order_item),0) as rev
From bangcuoi a 
inner join public.olist_orders_dataset_2018 b 
on a.customer_id =b.customer_id 
inner join public.olist_orders_item_dataset c 
on b.order_id = c.order_id 
Group by 1,2
order by 3)

Select segment, sum(rev)
From doanhthu
group by 1
order by 2 desc

=>Champion, Loyal and At risk have the highest rev

=>To increase revenue we need to understand the at risk group: where are they from, what they buy and why they stopped buying
a. where are they from 
, location as(Select a.customer_id, a.segment, b.customer_state
From bangcuoi a 
inner join public.olist_customer_dataset b
on a.customer_id = b.customer_id
where a.segment = 'At Risk')

Select customer_State, count(segment) as num_of_at_risk_Cus
From location 
group by 1
order by 2 desc 
=>>They are mainly from SP, RJ,MG state

b. what they buy the most
, category as(Select a.customer_id, d.product_name
From bangcuoi a 
inner join public.olist_orders_dataset_2018 b 
on a.customer_id = b.customer_id 
inner join public.olist_orders_item_dataset c 
on b.order_id = c.order_id 
inner join public.olist_product_dataset d 
on c.product_id = d.product_id
where a.segment = 'At Risk')

Select product_name, count(customer_id) as num_order
From category
where product_name is not null
group by 1
order by 2 desc 

=>> They buy computer accessories, bed bath table, sport_lesiure the most

c. Why they stopped buying
