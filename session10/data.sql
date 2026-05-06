CREATE DATABASE session11;
USE session11;
CREATE TABLE Users (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(100) NOT NULL  
);
INSERT INTO Users( name, address)
VALUES 
	('Linh', 'HaNoi'),
    ('Hoa', 'ĐN'),
    ('Vân', 'HCM'),
    ('Ngọc', 'HCM'),
    ('Hồng', 'HaNoi')

