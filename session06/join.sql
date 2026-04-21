USE session_06;
-- tạo bảng danh mục
CREATE TABLE Categories(
	category_id INT PRIMARY KEY,
    category_name VARCHAR(255)
);
-- tạo bảng sản phẩm
CREATE TABLE Products (
	product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    price DECIMAL(10,2) CHECK (price>0),
    category_id INT
);
-- thêm dữ liệu cho các bảng dữ liệu

INSERT INTO Categories (category_id,category_name)
VALUES 
	(11, 'điện thoại'),
    (13, 'máy tính'),
	(15, 'quần'),
    (17, 'áo');

INSERT INTO Products (product_id, product_name, price, category_id )
VALUES 
	(1, 'iphone15', 15000000, 11),
    (2, 'sam sung note 10', 16000000, 11),
    (3, 'quần âu', 300000, 15),
    (4, 'áo sơ mi', 500000, 17),
	(5, 'khô gà', 200000, 20);

-- INNER JOIN : lấy điểm chung của các bảng dữ liệu

SELECT product_name AS 'TÊN SẢN PHẨM', category_name
FROM Products p
INNER JOIN Categories c 
ON p.category_id = c.category_id;
    
-- LEFT JOIN 
SELECT product_name, category_name
FROM Products
LEFT JOIN Categories
ON Categories.category_id= Products.category_id;

-- RIGHT JOIN 
SELECT product_name, category_name
FROM Products
RIGHT JOIN Categories
ON Categories.category_id= Products.category_id;

