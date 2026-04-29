/*
	1. TRUY VẤN LỒNG LÀ GÌ?
		là truy vấn được bên trong 1 truy vấn khác.
	2. CÁC LOẠI TRUY VẤN LỒNG
		2.1: Subquery trả về 1 giá trị
        2.2: Subquery trả về nhiều giá trị
*/

-- Lấy điểm trung bình của tất cả sinh viên
SELECT AVG(score) AS 'ĐIỂM TRUNG BÌNH'
FROM Student;
-- hiển thị sinh viên có điểm số lớn hơn điểm trung bình

SELECT student_name, score
FROM Student
WHERE score > (SELECT AVG(score) FROM Student);

-- hiển thị danh sách sinh viên có điểm lớn hơn 5

SELECT student_name AS 'TÊN SINH VIÊN', score AS 'ĐIỂM'
FROM Student 
WHERE score >5;

-- LẤY DANH SÁCH SINH VIÊN CÓ ĐIỂM TRUNG BÌNH CỦA LỚP LỚN HƠN ĐIỂM TRUNG BÌNH
-- CỦA TẤT CẢ SINH VIÊN 

-- B1: LẤY ĐIỂM TRUNG BÌNH CỦA TỪNG LỚP
SELECT class_id
FROM Student
GROUP BY class_id
HAVING AVG(score) > (SELECT AVG(score) FROM Student);

SELECT class_name
FROM Class
WHERE class_id IN (
	SELECT class_id
	FROM Student
	GROUP BY class_id
	HAVING AVG(score) > (SELECT AVG(score) FROM Student)
);

SELECT class_name, AVG( score) AS ' ĐIỂM'
FROM Student s
JOIN Class c
ON  s.class_id= c.class_id
GROUP BY c.class_name
HAVING AVG (s.score)> (SELECT AVG(score) FROM Student);


-- lấy sinh viên có trong bảng student mà chưa thuộc lớp nào trong bảng class
SELECT student_name
FROM Student
-- WHERE class_id NOT IN (SELECT class_id FROM Class)
WHERE class_id NOT EXISTS (SELECT class_id FROM Class)
