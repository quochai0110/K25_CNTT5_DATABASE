/*
	CÁC CONSTRAINTS ( RÀNG BUỘC) TRONG CSLD MYSQL
    Sinh ra để làm gì? tại sao cần: 
    - Nhất quán dữ, tránh dư thừa, dữ liệu rác 
    1. PRIMARY KEY : Khóa chính ( không trùng, không rỗng)
    2. UNIQUE      : duy nhất không trùng dữ liệu
    3. NOT NULL    : không được để trống
    4. CHECK       : kiểm tra thêm điều kiện 
    5. DEFAULT     : nếu không điền sẽ lấy giá trị mặc định 
    6. Khóa ngoại  : Liên kết dữ liệu giữa các bảng
*/
USE session02;
CREATE TABLE person(
	id INT PRIMARY KEY,
    fullname varchar(50)
);
ALTER TABLE person
ADD email varchar(50) unique ;
ALTER TABLE person
ADD age int CHECK(age>=18); 
ALTER TABLE person
ADD address varchar(50) DEFAULT 'HN';

-- bảng cha _ danh mục sản phẩm
CREATE TABLE category(
	categoryId INT PRIMARY KEY,
    categoryName varchar(50)
);
-- bảng con _ sản phẩm
CREATE TABLE products(
	productId INT PRIMARY KEY,
    productName varchar (50),
    categoryId INT,
    foreign key (categoryId) references  category(categoryId)
)