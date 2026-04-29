USE session_07;

CREATE TABLE Class (
	class_id INT PRIMARY KEY,
    class_name VARCHAR(50) NOT NULL
);

CREATE TABLE Student (
	student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    score DECIMAL(4,2) CHECK (score >=0 AND score<=10),
    class_id INT,
    FOREIGN KEY (class_id) REFERENCES Class (class_id)
);

-- thêm dữ liệu cho bảng
INSERT INTO Class (class_id, class_name)
VALUES 
	(1,'CNTT1'),
    (2,'CNTT2'),
    (3,'CNTT3'),
    (4,'CNTT4'),
    (5,'CNTT5'),
    (6,'CNTT6');

INSERT INTO Student (student_id, student_name,score,class_id )
VALUES 
	(11,'AN',8.1,5),
    (12,'MINH',9.2,1),
    (13,'HOA',6,2),
    (14,'HỒNG',4,5),
    (15,'VÂN',4.5,4),
	(16,'NHUNG',9.5,4),
	(17,'HUỆ',10,1),
	(18,'NGỌC',8.4,3)





