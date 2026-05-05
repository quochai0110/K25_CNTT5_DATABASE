CREATE DATABASE session10;
-- Tạo 2 bảng dữ liệu
-- bảng 1: danh sách khách hàng
USE session10;
CREATE TABLE Customers (
	customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL
);
-- bảng 2: danh sách đơn hàng 
CREATE TABLE Orders (
		order_id INT AUTO_INCREMENT PRIMARY KEY,
        customer_id INT,
        amount DECIMAL(10,2) CHECK (amount>0),
        FOREIGN KEY (customer_id)  REFERENCES Customers(customer_id)
);
-- thêm dữ liệu cho bảng khách hàng
INSERT INTO Customers (name, city)
VALUES 
		('Minh Thu','Hà Nội'),
		('Hồng Vân','HCM'),
		('Ngọc Lan','DN');
-- thêm dữ liệu cho bảng danh sách đơn hàng
INSERT INTO Orders (customer_id,amount)
VALUES  
		(1,5000000),
        (1,1000000),
        (1,2000000),
        (2,600000),
        (3,800000);
-- lấy tên khách hàng và giá trị đơn hàng

SELECT c.name, o.amount
FROM Customers c
JOIN Orders  o  ON c.customer_id = o.customer_id;
-- VIEW sinh ra để làm gì?
/*
	1. giả sử có nhiều phòng ban cần lấy thông tin của khách hàng và số tiền
	người ta mua thì phải cần rất nhiều câu lệnh query
    VIEW sinh ra để giúp các phòng ban lấy tin khách hàng mà không mất
    thời gian viết lại câu lệnh query
    2. ẩn đi các thông tin quan trọng 
*/
-- cú pháp tạo view
CREATE VIEW customer_amount AS 
SELECT c.name, o.amount
FROM Customers c
JOIN Orders  o  ON c.customer_id = o.customer_id;

-- phòng ban A cần lấy thông tin khách hàng

SELECT * FROM customer_amount ;

-- thêm cột email cho bảng Customers
ALTER TABLE Customers 
ADD email VARCHAR(50) UNIQUE;
-- lấy thông tin khách hàng
SELECT * FROM Customers;

CREATE VIEW customer_info AS 
SELECT name,city
FROM Customers;

-- CÁC PHÒNG BAN MUỐN LẤY THÔNG TIN KHÁCH HÀNG MÀ CHE ĐI EMAIL
SELECT * FROM customer_info;

-- WITH CHECK OPTION (  ràng buộc điều kiện) 
-- lấy ra các đơn hàng có giá lớn hơn 1.000.000 đ
SELECT * FROM Orders 
WHERE amount>1000000 ;

CREATE VIEW result_amount AS
SELECT * FROM Orders 
WHERE amount>1000000;

SELECT * FROM result_amount;

-- THÊM ĐƠN HÀNG VÀO BẢNG ORDER 
INSERT INTO Orders(customer_id,amount)
VALUES 
	(1,700000);
-- KHI TẠO VIEW MÀ THÊM CHECK OPTION THÌ KHI THÊM, CẬP NHẬT, XÓA DỮ LIỆU
-- THÌ PHẢI THỎA MÃN WITH CHECK OPTION THÌ MỚI THAO TÁC VỚI DỮ LIỆU ĐƯỢC
CREATE VIEW result_order AS
SELECT * FROM Orders 
WHERE amount>1000000
WITH CHECK OPTION;
INSERT INTO result_order(customer_id,amount)
VALUES 
	(1,1120000);

	







