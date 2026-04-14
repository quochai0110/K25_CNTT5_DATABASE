/*
	CÁC CONSTRAINTS ( RÀNG BUỘC) TRONG CSLD MYSQL
    Sinh ra để làm gì? tại sao cần: 
    - Nhất quán dữ, tránh dư thừa, dữ liệu rác 
    1. PRIMARY KEY : Khóa chính ( không trùng, không rỗng)
    2. UNIQUE      : duy nhất không trùng dữ liệu
*/
USE session02;
CREATE TABLE person(
	id INT PRIMARY KEY,
    fullname varchar(50)
);
ALTER TABLE person
ADD email varchar(50) unique