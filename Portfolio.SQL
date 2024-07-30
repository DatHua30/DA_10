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

After that, I changed the date format of the remaining to timestamp
alter table public.olist_orders_dataset
alter column order_purchase_timestamp type timestamp using(order_purchase_timestamp:: timestamp )

alter table public.olist_orders_dataset
alter column order_estimated_delivery_Date type timestamp using(order_estimated_delivery_date:: timestamp )


Changing the date format in tables:

alter table public.olist_orders_item_dataset
alter column shipping_limit_date type timestamp  using(shipping_limit_date::timestamp)

Removing outliers in price and freight_value in olist_orders_item_dataset table using box plot





