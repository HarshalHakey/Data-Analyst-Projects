Create database Brazilian_Ecommerce;

Create table Orders(
order_id varchar(50),
customer_id varchar(50),
order_status varchar(20),
order_purchase_timestamp Datetime);

Create table order_items(
order_id varchar(50),
order_item_id varchar(50),
product_id varchar(50),
seller_id varchar(50),
price decimal(10,2));

Create table products(
product_id varchar(50),
product_category_name varbinary(100));

Create table customers(
customer_id varchar(50),
customer_city varchar(100),
customer_state varchar(50));

Create table payments(
order_id varchar(50),
payment_type varchar(50),
payment_value decimal(10,2));

select orders.order_id, products.product_category_name, order_items.price
from orders join order_items
on orders.order_id = order_items.order_id
join products
on order_items.product_id = products.product_id;

#Total Revenue
select sum(payment_value) as total_revenue
from payments;

# Monthly Sales Trend
select date_format(order_purchase_timestamp,'%Y-%M') as Month,
count(order_id) as total_orders
from orders
group by month
order by month;

# Top Product Categories
select products.product_category_name, sum(order_items.price) as revenue
from order_items join products
on order_items.product_id = products.product_id
group by product_category_name
order by revenue desc
limit 10;

# Revenue by State
select customers.customer_state, sum(order_items.price) as revenue
from orders join customers
on orders.customer_id = customers.customer_id
join order_items
on orders.order_id = order_items.order_id
group by customer_state
order by revenue desc;

# Payement Method Analysis
select payment_type, count(order_id) as total_orders
from payments
group by payment_type
order by total_orders desc;

# Top Customers
select customers.customer_id, sum(payments.payment_value) as total_spent
from customers join orders
on customers.customer_id = orders.customer_id
join payments
on orders.order_id = payments.order_id
group by customer_id
order by total_spent desc
limit 10;

# Top Revenue Generating Products
select products.product_category_name, sum(order_items.price) as total_revenue
from order_items join products
on order_items.product_id = products.product_id
group by product_category_name
order by total_revenue desc
limit 10;

