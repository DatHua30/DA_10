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

alter table sales_dataset_rfm_prj
ALTER COLUMN productline type text 

alter table sales_dataset_rfm_prj
ALTER COLUMN msrp type integer using(msrp::integer) 

alter table sales_dataset_rfm_prj
ALTER COLUMN city type text 

alter table sales_dataset_rfm_prj
ALTER COLUMN state type text 

alter table sales_dataset_rfm_prj
ALTER COLUMN country type text 

alter table sales_dataset_rfm_prj
ALTER COLUMN territory type text 

alter table sales_dataset_rfm_prj
ALTER COLUMN contact_full_name type text 

alter table sales_dataset_rfm_prj
ALTER COLUMN deal_size type text

--Câu 2:
Select *
From public.sales_dataset_rfm_prj
where order_number is null or order_number = ' '

Select *
From public.sales_dataset_rfm_prj
where quantity_ordered is null 

Select *
From public.sales_dataset_rfm_prj
where price_Each is null 

Select *
From public.sales_dataset_rfm_prj
where order is null 

Select order_Date
From public.sales_dataset_rfm_prj
group by 1

Select *
From public.sales_dataset_rfm_prj
where sales is null

--Câu 3:
update sales_dataset_rfm_prj 
set contact_first_name = left(contact_full_name, position('-' in contact_full_name)-1)

update sales_dataset_rfm_prj
set contact_last_name = right(contact_full_name,length(contact_full_name) - position('-' in contact_full_name))

--Câu 4: 
