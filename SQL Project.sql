# Fashion Store Analysis SQL Project 

create database fashionstore;
use fashionstore;

# customers table
CREATE TABLE customers (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(100),
  gender CHAR(1),
  city VARCHAR(50)
);

INSERT INTO customers VALUES
(1,'David Warner','M','Hyderabad'),
(2,'Amelia Kerr','F','Mumbai'),
(3,'Dewald Brevis','M','Chennai'),
(4,'Linsey Smith','F','Delhi'),
(5,'Mohit Sharma','M','Lucknow');

# items table
CREATE TABLE items (
  item_id INT PRIMARY KEY,
  item_name VARCHAR(100),
  category VARCHAR(50),
  price DECIMAL(10,2)
);

INSERT INTO items VALUES
(1,'Hoodie','Casual',900),
(2,'Jeans','Western',2000),
(3,'Kurta','Traditional',1000),
(4,'Skirt','Casual',1200),
(5,'Shorts','Western',600),
(6,'Tracksuit','Sportswear',1750);

# orders table
CREATE TABLE orders (
  order_id INT PRIMARY KEY,
  customer_id INT,
  order_date DATE,
  total_amount DECIMAL(10,2),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO orders VALUES
(101,1,'2025-01-20',2000),
(102,2,'2025-01-21',3500),
(103,3,'2025-01-22',1500),
(104,5,'2025-01-23',2700),
(105,4,'2025-01-24',1200),
(106,1,'2025-01-25',3000);

# ORDER DETAILS Table
CREATE TABLE order_details (
  order_id INT,
  item_id INT,
  quantity INT,
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (item_id) REFERENCES items(item_id)
);

INSERT INTO order_details VALUES
(101, 1, 1),
(101, 5, 2),
(101, 6, 1),
(102, 2, 1),
(102, 4, 1),
(103, 3, 2),
(104, 5, 1),
(104, 6, 1),
(105, 4, 2),
(105, 1, 1),
(106, 3, 1),
(106, 6, 2);

select * from customers;
select * from items;
select * from orders;
select * from order_details;

# Queries with Solution

# give the list of all customers
select * from customers;

# give the total number of orders
select count(*) as total_orders from orders;

# show revenue
select sum(total_amount) as total_revenue from orders;

# give the customername who lives in hyderabad
select customer_name from customers
where city='Hyderabad';

# List all items ordered in order id=102
select i.item_name,od.quantity
from items i join order_details od
on i.item_id=od.item_id
where od.order_id=102;
# order id 102 includes 1 jeans and 1 skirt

# give me the most popular/sold item
select i.item_name,sum(od.quantity) as total_sold
from items i join order_details od
on i.item_id=od.item_id
group by i.item_name
order by total_sold desc
limit 1;
# the item which is most sold is tracksuit, 4 tracksuits have been sold

#Customer who spent the most
select c.customer_name, sum(o.total_amount) as total_spent
from customers c join orders o
on c.customer_id=o.customer_id
group by c.customer_name
order by total_spent desc
limit 1;
# customer david warner spent the most 

# category wise revenue
select i.category,sum(i.price * od.quantity) as category_revenue
from items i join order_details od
on i.item_id=od.item_id
group by i.category
order by category_revenue desc;

# average order value
select avg(total_amount) from orders;

# orders per city
select c.city,count(o.order_id) 
from orders o join customers c
on o.customer_id=c.customer_id
group by c.city;

