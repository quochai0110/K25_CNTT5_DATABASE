/*
	CÁC CÂU LỆNH DDL : data definition languge
    1. Cách tạo bảng
		CREATE TABLE table_name(
			column_name data_type,
			column_name data_type
		)
	2. Cách xóa bảng
		DROP TABLE table_name;
	3. Thêm thuộc tính cho bảng
		ALTER TABLE table_name
        ADD property_name data_type
	4. Cập nhật thuộc tính trong bảng 
		ALTER TABLE table_name
        change property_old property_new datatype
	5. Xóa thuộc tính
		ALTER TABLE table_name
        DROP property_name
    
*/
-- CREATE DATABASE session02;
USE session02;
CREATE TABLE students(
	id INT,
    student_name varchar(50)
);
-- DROP TABLE students;
ALTER TABLE students
ADD address varchar(50);
ALTER TABLE students
DROP address;