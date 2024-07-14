alter table sales_dataset_rfm_prj
rename column ordernumber to order_number

alter table sales_dataset_rfm_prj
rename column quantityordered to quantity_ordered,

alter table sales_dataset_rfm_prj
rename column priceeach to price_each 

alter table sales_dataset_rfm_prj
rename column orderlinenumber to orderline_number

alter table sales_dataset_rfm_prj
rename column orderdate to order_date

alter table sales_dataset_rfm_prj
rename column productcode to product_code

alter table sales_dataset_rfm_prj
rename column customername to customer_name

alter table sales_dataset_rfm_prj
rename column phone to phone_number

alter table sales_dataset_rfm_prj
rename column addressline1 to address_line_1

alter table sales_dataset_rfm_prj
rename column addressline2 to address_line_2

alter table sales_dataset_rfm_prj
rename column postalcode to postal_code

alter table sales_dataset_rfm_prj
rename column contactfullname to contact_full_name

alter table sales_dataset_rfm_prj
rename column dealsize to deal_size

--Câu1 :
alter table sales_dataset_rfm_prj
ALTER COLUMN quantity_ordered type integer using(quantity_ordered::integer)

alter table sales_dataset_rfm_prj
ALTER COLUMN price_each type numeric using(quantity_ordered::numeric)

alter table sales_dataset_rfm_prj
ALTER COLUMN orderline_number type integer using(quantity_ordered::integer)

alter table sales_dataset_rfm_prj
ALTER COLUMN sales type numeric using(sales::numeric)

alter table sales_dataset_rfm_prj
ALTER COLUMN order_date type date USING(order_date::date)

alter table sales_dataset_rfm_prj
ALTER COLUMN status type text 
