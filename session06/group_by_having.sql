/*
	Các hàm tổng hợp
    1. count(): đếm số lượng bản ghi
    2. sum()  : tính tổng
    3. avg()  : tính trung bình
    4. min()  : tìm giá trị nhỏ nhất
    5. max()  : tìm giá trị lớn nhất
    
*/
USE session_06;
-- count đếm số lượng danh mục
SELECT COUNT(category_id) AS 'tổng số danh mục'
FROM Categories;
-- tính tổng tiền của tất cả sản phẩm
SELECT SUM(price) AS 'tổng tiền sản phẩm'
FROM Products;
-- tính giá trung bình của tất cả sản phẩm
SELECT AVG(price) AS 'giá trung bình'
FROM Products;
-- tìm sản phẩm có giá lớn nhất
SELECT p.product_name, p.price, c.category_name
FROM Products p
JOIN Categories c
ON p.category_id = c.category_id
WHERE p.price = (SELECT MAX(price) FROM Products);
-- Hiển thị tên sản phẩm có giá lớn nhất, giá, danh mục của nó !
-- GROUP BY : gộp nhóm kết hợp với các hàm tổng hợp
-- hiển thị số lượng sản phẩm trong từng danh mục
SELECT category_name AS 'Tên danh mục', Count(product_id) AS 'số lượng sản phẩm'
FROM Categories
JOIN Products 
ON Products.category_id = Categories.category_id
GROUP BY category_name
HAVING MIN(price)> 8000000
-- HAVING: thêm điều kiện cho Group by , ( không dùng được where)
