CREATE DATABASE session13;
USE session13;
/*
	trigger: 
    Khi vào nhà mở cửa(thêm sửa xóa)
    chuông kêu(trigger)
    người đi qua bóng đèn (thêm_insert,sửa_update,
    xóa_delete)
    mà bóng đèn sáng(trigger);
    1. 
*/
-- Tạo bảng user
CREATE TABLE Users (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    create_at DATE,
    age INT CHECK(age>5)
);



/*
	CÚ PHÁP TỔNG QUÁT CỦA TRIGGER
    DELIMITER //
    CREATE TRIGGER TRIGGER_NAME
    BEFORE || AFTER TRIGGER_EVENT (INSERT, UPDATE,DELETE)
    ON TABLE_NAME
    FOR EACH ROW 
    BEGIN
		// LOGIC 
    END 
    DELIMITER ;
    
    XOÁ TRIGGER
    DROP TRIGGER_NAME
*/

DELIMITER //
CREATE TRIGGER insert_user
BEFORE INSERT 
ON Users
FOR EACH ROW
BEGIN
    SET NEW.create_at =NOW();
END //
DELIMITER ;
DROP  TRIGGER insert_user;
SELECT * FROM Users;
-- Dùng trigger kiểm tra giá trị trước khi thêm vào dữ liệu
DELIMITER $$
CREATE TRIGGER check_age
BEFORE INSERT 
ON Users
FOR EACH ROW 
BEGIN
	IF NEW.age <5 THEN
     SIGNAL SQLSTATE '45000'
     SET MESSAGE_TEXT ='tuổi không hợp lệ';
     END IF;
END $$
DELIMITER ;
DROP TRIGGER check_age;
INSERT INTO Users (name,age)
VALUES ('Hồng Vân',4);
SHOW TRIGGERS;

/*
	trong công ty thầy muốn tăng lương cho 1 nhân viên
    muốn có bảng lưu thông tin lưu trước và sau khi tăng
*/
-- Tạo bảng nhân viên
CREATE TABLE Employees (
	id INT PRIMARY KEY AUTO_INCREMENT ,
    name VARCHAR(100),
    salary DECIMAL(12,2)
);
-- Tạo bảng lưu lịch sử lương của nhân viên
CREATE TABLE Logs_salary (
	id INT PRIMARY KEY AUTO_INCREMENT ,
	emp_id INT,
    old_salary DECIMAL(12,2),
	new_salary DECIMAL(12,2)
);
-- Tạo trigger khi cập nhật lương của nhân viên trong bảng employees
-- thì trigger sẽ lưu vào lịch sử 
DELIMITER $$
CREATE TRIGGER update_salary
AFTER UPDATE
ON Employees
FOR EACH ROW
BEGIN
	IF OLD.salary  <> NEW.salary THEN
		INSERT INTO Logs_salary(
			emp_id,
            old_salary,
            new_salary
        )
        VALUES (
			OLD.id,
            OLD.salary,
            NEW.salary
        );
    END IF;
END $$
DELIMITER ;
/*
	OLD: dữ liệu cũ : chỉ dùng cho UPDATE VÀ DELETE
    NEW: dữ liệu mới: dùng cho INSERT VÀ UPDATE
*/
INSERT INTO Employees(name, salary)
VALUES 
	('Hoàng An', 8000000);
-- CẬP NHẬT LƯƠNG
UPDATE Employees
SET salary= '11000000'
WHERE id=1;

--  Khi xóa nhân viên dùng trigger để lưu thông tin nhân viên lại

CREATE TABLE History_emp (
		id INT PRIMARY KEY AUTO_INCREMENT ,
        emp_id INT,
        name VARCHAR(100)
);
-- Tạo trigger khi xóa nhân viên thì lưu lại trong bảng lịch sử nhân viên
DELIMITER $$
CREATE TRIGGER delete_emp 
BEFORE DELETE 
ON Employees
FOR EACH ROW
BEGIN 
    INSERT INTO History_emp (emp_id, name)
    VALUES 
		(OLD.id,OLD.name);
END $$
DELIMITER ;


INSERT INTO Employees(name, salary)
VALUES 
	('Hoàng Văn', 18000000);
DELETE FROM Employees 
WHERE id= 1;










