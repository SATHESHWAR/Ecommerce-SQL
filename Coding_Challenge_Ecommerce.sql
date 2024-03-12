create database rest;
create table customers (
    customer_id INT Primary Key,
    F_name VARCHAR(255),
    L_name VARCHAR(255),
    email VARCHAR(255),
    Address VARCHAR(255)
);


create table products (
    product_id INT Primary Key,
    name VARCHAR(255),
    price DECIMAL(10, 2),
    description VARCHAR(250),
    stock_quantity INT
);


create table cart (
    cart_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    Foreign Key (customer_id) References customers(customer_id),
    Foreign Key (product_id) References products(product_id)
);


create table orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_price DECIMAL(10, 2),
    Foreign Key (customer_id) References customers(customer_id)
);

create table order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    Item_price Decimal,
    Foreign Key (order_id) References orders(order_id),
    Foreign Key (product_id) References products(product_id)
);

Insert into products( product_id,name,description,price,stock_quantity) values(1,'Laptop',' High-performance laptop',800.00,10),
(2, 'Smartphone','Latest smartphone',600.00,15),
(3, 'Tablet' ,'Portable tablet', 300.00 ,20),
(4, 'Headphones', 'Noise-canceling', 150.00,30),
(5, 'TV', '4K Smart TV', 900.00 ,5),
(6,' Coffee Maker' ,'Automatic coffee maker', 50.00, 25),
(7, 'Refrigirator','Energy-efficient',700.00,10),
(8, 'Microwave Oven' ,'Countertop microwave', 80.00 ,15),
(9, 'Blender', 'High-speed blender', 70.00,20),
(10, 'Vaccum Cleaner', 'Bagless vacuum cleaner', 120.00 ,10);

INSERT INTO customers (customer_id, F_name, L_name, email, Address) values(1, 'John', 'Doe', 'johndoe@example.com', '123 Main St, City'),
(2, 'Jane', 'Smith', 'janesmith@example.com', '456 Elm St, Town'),
(3, 'Robert', 'Johnson', 'robert@example.com', '789 Oak St, Village'),
(4, 'Sarah', 'Brown', 'sarah@example.com', '101 Pine St, Suburb'),
(5, 'David', 'Lee', 'david@example.com', '234 Cedar St, District'),
(6, 'Laura', 'Hall', 'laura@example.com', '567 Birch St, County'),
(7, 'Michael', 'Davis', 'michael@example.com', '890 Maple St, State'),
(8, 'Emma', 'Wilson', 'emma@example.com', '321 Redwood St, Country'),
(9, 'William', 'Taylor', 'william@example.com', '432 Spruce St, Province'),
(10, 'Olivia', 'Adams', 'olivia@example.com', '765 Fir St, Territory');

INSERT INTO orders (order_id, customer_id, order_date, total_price)values(1, 1, '2023-01-05', 1200.00),
(2, 2, '2023-02-10', 900.00),
(3, 3, '2023-03-15', 300.00),
(4, 4, '2023-04-20', 150.00),
(5, 5, '2023-05-25', 1800.00),
(6, 6, '2023-06-30', 400.00),
(7, 7, '2023-07-05', 700.00),
(8, 8, '2023-08-10', 160.00),
(9, 9, '2023-09-15', 140.00),
(10, 10, '2023-10-20', 1400.00);

INSERT INTO order_items (order_item_id, order_id, product_id, quantity) values (1, 1, 1, 2),
(2, 1, 3, 1),
(3, 2, 2, 3),
(4, 3, 5, 2),
(5, 4, 4, 4),
(6, 4, 6, 1),
(7, 5, 1, 1),
(8, 5, 2, 2),
(9, 6, 10, 2),
(10, 6, 9, 3);

INSERT INTO cart (cart_id, customer_id, product_id, quantity) values(1, 1, 1, 2),
(2, 1, 3, 1),
(3, 2, 2, 3),
(4, 3, 4, 4),
(5, 3, 5, 2),
(6, 4, 6, 1),
(7, 5, 1, 1),
(8, 6, 10, 2),
(9, 6, 9, 3),
(10, 7, 7, 2);

-- 1. Update refrigerator product price to 800.

	Update products set price=800.00 where product_id=7;
    select * from products;
    
-- 2. Remove all cart items for a specific customer.

	Delete from Cart where customer_id=6;
    
-- 3. Retrieve Products Priced Below $100.

	Select * from products where price<100;
    
-- 4. Find Products with Stock Quantity Greater Than 5.

	Select * from products where stock_quantity>5;

-- 5. Retrieve Orders with Total Amount Between $500 and $1000.

	Select * from orders where total_price between 500 and 1000;
    
-- 6. Find Products which name end with letter ‘r’.

	Select name from products where name like'%r';
    
-- 7. Retrieve Cart Items for Customer 5.

	Select * from Cart where customer_id=5;
    
-- 8. Find Customers Who Placed Orders in 2023.

	Select * from orders where YEAR(order_date)='2023';
    
-- 9. Determine the Minimum Stock Quantity for Each Product Category.
	/* Category not mentioned */

-- 10. Calculate the Total Amount Spent by Each Customer.

	Select c.customer_id,c.F_name,c.L_name, SUM(oi.quantity * p.price) AS total_amount_spent,Address
	FROM customers c
	JOIN orders o ON c.customer_id = o.customer_id
	JOIN order_items oi ON o.order_id = oi.order_id
	JOIN products p ON oi.product_id = p.product_id
	GROUP BY c.customer_id;
	
-- 11. Find the Average Order Amount for Each Customer.

    Select c.customer_id,c.F_name,c.L_name, AVG(o.total_price) AS average_order_amount
	FROM customers c
	JOIN orders o ON c.customer_id = o.customer_id
	GROUP BY c.customer_id;

-- 12. Count the Number of Orders Placed by Each Customer.

	Select c.customer_id,c.F_name,c.L_name, COUNT(o.customer_id) AS No_of_orders
	FROM customers c
	JOIN orders o ON c.customer_id = o.customer_id
	GROUP BY c.customer_id;
	
-- 13. Find the Maximum Order Amount for Each Customer.

	Select c.customer_id,c.F_name,c.L_name, MAX(o.total_price) AS Max_order_amount
	FROM customers c
	JOIN orders o ON c.customer_id = o.customer_id
	GROUP BY c.customer_id;

-- 14. Get Customers Who Placed Orders Totaling Over $1000

	SELECT c.customer_id,c.F_name,c.L_name, SUM(oi.quantity * p.price) AS total_amount_spent,Address
	FROM customers c
	JOIN orders o ON c.customer_id = o.customer_id
	JOIN order_items oi ON o.order_id = oi.order_id
	JOIN products p ON oi.product_id = p.product_id
	GROUP BY c.customer_id having total_amount_spent >1000;
    
-- 15.Subquery to Find Products Not in the Cart.

	Select * from Products where product_id NOT IN (Select Distinct product_id from Cart);

-- 16. Subquery to Find Customers Who Haven't Placed Orders.

	Select * FROM customers WHERE customer_id NOT IN (Select DISTINCT customer_id FROM orders);

-- 17. Subquery to Calculate the Percentage of Total Revenue for a Product.

	Select p.product_id,p.name AS product_name,( 
        (Select SUM(oi.quantity * p.price) FROM order_items oi WHERE oi.product_id = p.product_id) /
        (Select SUM(oi.quantity * p.price) FROM order_items oi JOIN products p ON oi.product_id = p.product_id)
		) * 100 AS percentage_of_total_revenue FROM products p;
    
-- 18. Subquery to Find Products with Low Stock.

	Select * from Products where StockQuantity<(select avg(stockquantity) from products);
    
-- 19. Subquery to Find Customers Who Placed High-Value Orders.
    
    Select Distinct c.* FROM customers c JOIN orders o ON c.customer_id = o.customer_id 
    WHERE o.total_price > (Select AVG(total_price) FROM orders);
    
-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% --
    
    

