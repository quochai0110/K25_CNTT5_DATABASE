/*
	INDEX: hay là chỉ mục giúp truy vấn dữ liệu nhanh hơn
    CÁCH HOẠT ĐỘNG: MYSQL : dùng cấu trúc dữ liệu
    B-TREE để lưu 
*/
USE session10; 
CREATE TABLE Users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50),
    email VARCHAR(100),
    city VARCHAR(50),
    age INT,
    created_at DATE
);
DELIMITER $$

CREATE PROCEDURE seed_users()
BEGIN
    DECLARE i INT DEFAULT 1;

    WHILE i <= 1000 DO
        INSERT INTO users (username, email, city, age, created_at)
        VALUES (
            CONCAT('user', i),
            CONCAT('user', i, '@mail.com'),
            ELT(FLOOR(1 + RAND()*5), 'Hanoi', 'HCM', 'Danang', 'Hue', 'Cantho'),
            FLOOR(18 + RAND()*50),
            DATE_SUB(CURDATE(), INTERVAL FLOOR(RAND()*1000) DAY)
        );
        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;
CALL seed_users();

-- lấy thông tin user mà có địa chỉ hà nội
EXPLAIN ANALYZE
SELECT * FROM Users
WHERE city ='Hanoi';

-- đánh index
 CREATE INDEX idx_city ON Users(city);
 -- chạy lại câu lệnh truy vấn sau khi đánh index
 EXPLAIN ANALYZE
SELECT * FROM Users
WHERE city ='Hanoi';





