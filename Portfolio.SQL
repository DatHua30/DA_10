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

