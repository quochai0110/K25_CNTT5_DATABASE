CREATE DATABASE review;
USE review;
-- 1.1 TẠO BẢNG THÀNH VIÊN
CREATE TABLE Members (
	member_id VARCHAR(5) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL UNIQUE,
    membership_type VARCHAR(50) NOT NULL,
    join_date DATE NOT NULL
);
-- 1.2 TẠO BẢNG HUẨN LUYỆN VIÊN
CREATE TABLE Trainers(
	trainer_id VARCHAR(5) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    specialty VARCHAR (100) NOT NULL,
    experience INT NOT NULL,
    salary DECIMAL(12,2) NOT NULL
);
-- 1.3 TẠO BẢNG LỚP HỌC TRONG PHÒNG GYM
CREATE TABLE Classes (
	class_id VARCHAR(5) PRIMARY KEY,
    class_name VARCHAR(100) NOT NULL,
    trainer_id VARCHAR (5) NOT NULL,
    schedule_time DATETIME NOT NULL,
    max_capacity INT NOT NULL,
    fee DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (trainer_id) REFERENCES Trainers(trainer_id)
);
-- 1.4 TẠO BẢNG THÀNH VIÊN ĐĂNG KÝ LỚP HỌC
CREATE TABLE Enrollments(
	enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    class_id VARCHAR(5) NOT NULL,
    member_id VARCHAR(5) NOT NULL,
    status VARCHAR(20) NOT NULL,
    enroll_date  DATE NOT NULL,
    UNIQUE(class_id,member_id), -- tránh trường hợp đăng ký trùng
    FOREIGN KEY (class_id) REFERENCES Classes(class_id),
    FOREIGN KEY (member_id) REFERENCES Members(member_id)
);
-- CHÈN DỮ LIỆU BẢNG THÀNH VIÊN
INSERT INTO Members 
VALUES 
	('M01','Nguyễn Văn An', 'an.nguyen@gmail.com','0912345678', 'Premium','2025-01-15'),
    ('M02','Trần Thị Bình', 'binh.tran@gmail.com','0987654321', 'Vip','2025-02-20'),
    ('M03','Lê Hoàng Cường', 'cuong.le@gmail.com','0978123456', 'Basic','2025-03-10'),
    ('M04','Phạm Minh Dũng', 'dung.pham@gmail.com','0909876543', 'Premium','2025-04-05');
-- CHÈN DỮ LIỆU BẢNG HUẤN LUYỆN VIÊN
INSERT INTO Trainers
VALUES
	('T01','Coach Alex','Strength Training', 8,25000000),
    ('T02','Huấn luyện viên Lan','Yoga & Pilates', 6,18000000),
    ('T03','Coach Minh','Functional Fitness', 10,32000000);
-- CHÈN DỮ LIỆU BẢNG LỚP HỌC
INSERT INTO Classes
VALUES
	('C01','Morning Strength','T01', '2025-11-10 06:30:00',20,150000),
    ('C02','Yoga Flow','T02', '2025-11-10 17:30:00',15, 120000),
    ('C03','HIIT Burn','T03', '2025-11-11 18:00:00',18,180000),
    ('C04','Power Lifting','T01', '2025-11-12 07:00:00',12,200000);
-- CHÈN DỮ LIỆU BẢNG ĐĂNG KÝ LỚP HỌC
INSERT INTO Enrollments
VALUES
	(1,'C01','M01', 'Confirmed','2025-11-01'),
    (2,'C02','M02', 'Confirmed','2025-11-02'),
    (3,'C01','M03', 'Canceled','2025-11-03'),
    (4,'C04','M01', 'Confirmed','2025-11-05'),
    (5,'C03','M04', 'Pending','2025-11-06');
-- 1.4 Lớp C03 (HIIT Burn) có nhu cầu cao → tăng học phí (fee) thêm 20%.
UPDATE Classes
SET fee = fee * 1.2
WHERE class_id = 'C03';
-- 1.5 Cập nhật membership_type của thành viên M02 thành 'VIP Elite'.
UPDATE Members 
SET membership_type ='VIP Elite'
WHERE member_id ='M02';
-- 1.6 Xóa tất cả các đơn đăng ký có trạng thái 'Canceled'.
SET SQL_SAFE_UPDATES = 0;
DELETE FROM Enrollments
WHERE status = 'Canceled';
-- 1.7 Thêm ràng buộc cho cột fee trong bảng Classes: học phí phải >= 0.
ALTER TABLE Classes
ADD CONSTRAINT chk_fee CHECK (fee>=0);
-- 1.8 Thiết lập giá trị mặc định cho cột status trong bảng Enrollments là 'Pending'.
ALTER TABLE Enrollments
ALTER status SET DEFAULT 'Pending';
-- 1.9 Thêm cột gender (VARCHAR(10)) vào bảng Members sau khi tạo bảng 
-- (giá trị có thể là 'Male', 'Female', 'Other').
ALTER TABLE Members
ADD gender VARCHAR (10);
-- PHẦN 2 TRUY VẤN DỮ LIỆU CƠ BẢN
-- 10. Liệt kê tất cả các lớp học có chuyên môn liên quan đến "Strength" hoặc "Fitness".
SELECT c.*
FROM Classes c
JOIN Trainers t ON c.trainer_id = t.trainer_id
WHERE 
	t.specialty LIKE "%Strength%"
OR  t.specialty LIKE "%Fitness%" ;
-- 11. Lấy thông tin full_name, email của những thành viên có tên chứa ký tự 'n' .
SELECT full_name, email
FROM Members
WHERE full_name LIKE '%n%';
-- 12. Hiển thị danh sách các lớp học gồm class_id, class_name,
-- schedule_time, sắp xếp theo schedule_time tăng dần.
SELECT class_id, class_name
FROM Classes
ORDER BY schedule_time ASC;
-- 13. Lấy ra 3 lớp học có học phí (fee) thấp nhất.
SELECT *
FROM Classes
ORDER BY fee ASC
LIMIT 3;
-- 14. Hiển thị class_name, specialty từ bảng Classes và Trainers, 
-- bỏ qua lớp đầu tiên và lấy 2 lớp tiếp theo.
SELECT c.class_name, t. specialty
FROM Classes c
JOIN Trainers t
ON c.trainer_id=t.trainer_id
LIMIT 2 OFFSET 1;
-- 15. Giảm 15% học phí cho tất cả các lớp học diễn ra vào buổi sáng (trước 12:00).
UPDATE Classes
SET fee= fee*0.85
WHERE HOUR(schedule_time)<12;
-- 16. Chuyển đổi toàn bộ full_name của thành viên trong bảng Members thành chữ in hoa.
UPDATE Members
SET full_name = UPPER(full_name);
-- 17. Xóa tất cả các lớp học có học phí bằng 0 (nếu có) 
-- và đảm bảo xử lý ràng buộc khóa ngoại với bảng Enrollments.

-- B1: Xóa bảng trung gian trước
	DELETE FROM Enrollments
    WHERE class_id IN(
			SELECT class_id FROM Classes WHERE fee=0
    );
-- B2: Xóa bảng gốc
	DELETE FROM  Classes
    WHERE fee =0;
-- PHẦN 3: TRUY VẤN NÂNG CAO
-- 18. Hiển thị enrollment_id, full_name (thành viên), class_name, full_name → 
--  thay bằng trainer_full_name của các đơn đăng ký có trạng thái 'Confirmed'.
	SELECT e. enrollment_id, m. full_name, c.class_name,t.full_name AS trainer_full_name
    FROM Enrollments e
    JOIN Members  m ON e. member_id = m.member_id
    JOIN Classes  c ON c. class_id = e.class_id
    JOIN Trainers t ON t. trainer_id = c.trainer_id
    WHERE status = 'Confirmed';
    
-- 19. Liệt kê tất cả các lớp học (class_name) và thời gian (schedule_time) tương ứng. 
--    Hiển thị cả những lớp chưa có thành viên nào đăng ký.

	SELECT c.class_name, c.schedule_time
	FROM Classes c
	LEFT JOIN Enrollments e ON c.class_id= e.class_id;

-- 20. Tính tổng số đơn đăng ký theo từng trạng thái (status).
	SELECT status, COUNT(*) AS 'tổng số đơn đăng ký theo trạng thái'
    FROM Enrollments e 
    GROUP BY status;
    
-- 21. Thống kê số lượng lớp học mà mỗi thành viên đã đăng ký. 
--  Chỉ hiển thị những thành viên đăng ký từ 2 lớp trở lên.
   SELECT member_id, COUNT(*) 'SỐ LƯỢNG THÀNH VIÊN ĐĂNG KÍ TỪ 2 LỚP TRỞ LÊN' --  total_classes
   FROM Enrollments 
   GROUP BY member_id
   HAVING COUNT(*) >=2 ;
   
-- 22. Lấy thông tin các lớp học có học phí thấp hơn học phí trung bình của tất cả các lớp.

SELECT *
FROM Classes 
WHERE fee < (SELECT AVG(fee) FROM Classes) ;

-- 23. Hiển thị full_name và membership_type của những thành viên đã đăng ký
--  tham gia lớp "Morning Strength".
 SELECT m.full_name, m.membership_type
 FROM Members m
 JOIN Enrollments e  ON e.member_id = m.member_id
 JOIN Classes c      ON c.class_id = e.class_id
 WHERE c.class_name = 'Morning Strength';
 
 -- 24. Liệt kê danh sách các lớp học diễn ra trong tháng 11 năm 2025.
 SELECT *
 FROM Classes
 WHERE 
	MONTH(schedule_time) =11 
    AND YEAR(schedule_time)=2025
    AND DAY(schedule_time)=10




	



















    











































	









