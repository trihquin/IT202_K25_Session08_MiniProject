CREATE DATABASE salesManagement;

USE salesManagement;

CREATE TABLE customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    gender TINYINT NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(15) UNIQUE NOT NULL
);

CREATE TABLE category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    product_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES category(category_id)
);

CREATE TABLE orderTable (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE orderDetail (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    order_price DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orderTable(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

INSERT INTO customer(full_name, dob, gender, email, phone_number)
VALUES
('Nguyen Van An', '2002-05-12', 1, 'an@gmail.com', '0901111111'),
('Tran Thi Bich', '1999-09-21', 0, 'bich@gmail.com', '0902222222'),
('Le Minh Quan', '2001-11-10', 1, 'quan@gmail.com', '0903333333'),
('Pham Thu Ha', '1998-03-15', 0, 'ha@gmail.com', '0904444444'),
('Hoang Gia Bao', '2003-07-08', 1, 'bao@gmail.com', '0905555555');

INSERT INTO category(category_name)
VALUES
('Dien tu'),
('Thoi trang'),
('Gia dung'),
('Sach'),
('The thao');

INSERT INTO product(category_id, product_name, product_price)
VALUES
(1, 'Laptop Dell', 22000000),
(1, 'iPhone 15', 28000000),
(2, 'Ao Hoodie', 450000),
(3, 'Noi chien khong dau', 1800000),
(4, 'Sach SQL Co Ban', 120000),
(5, 'Giay Adidas', 2500000);

INSERT INTO orderTable(customer_id, order_date)
VALUES
(1, '2025-05-01'),
(2, '2025-05-02'),
(3, '2025-05-03'),
(1, '2025-05-04'),
(4, '2025-05-05');

INSERT INTO orderDetail(order_id, product_id, quantity, order_price)
VALUES
(1, 1, 1, 22000000),
(1, 5, 2, 5000000),
(2, 2, 1, 28000000),
(3, 3, 3, 1350000),
(4, 4, 2, 240000),
(5, 6, 1, 2500000);

-- 1
SELECT full_name, email,
CASE 
WHEN gender = 1 THEN 'Nam'
ELSE 'Nữ'
END AS Sex
FROM customer;


-- 2
SELECT * FROM customer
ORDER BY (NOW() - YEAR(dob)) LIMIT 3

-- 5
select * from product
where product_price > (select avg(product_price) avg_price from product);

-- 6
select * from customer where customer_id not in (select customer_id from orderTable);
