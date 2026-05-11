CREATE DATABASE session14; 
USE session14;
/*
CÁC LỆNH CƠ BẢN TRONG TRANSACTION
1. Bắt đầu transaction:
	+ START TRANSACTION
    + BEGIN
2. Lưu vĩnh viển các thay đổi
	COMMIT;
3. Quay lại trạng thái trước khi transaction thay đổi
	ROLLBACK;
4. Tạo điểm lưu tạm trong transaction
	SAVE POINT;
5. Quay lại 1 điểm SAVE POINT 
	ROLLBACK TO --> đến Diểm save point
6. Bật tắt tự động commit
	-- kiểm tra trạng thái commit
		SELECT @@ autocommit
	-- Cập nhật lại trạng thái commit
		SET autocommit =0;
*/
/*
	VD1: chuyển tiền
    có tài khoản A, B
    - thực hiện chuyển tiền từ tài khoản A sang tài khoản B
    1. không dùng transaction
    2. dùng transaction
*/

SELECT @@autocommit;
SET autocommit =0;

-- TẠO BẢNG LƯU THÔNG TIN TÀI KHOẢN NGƯỜI DÙNG

CREATE TABLE Balance_account (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    balance DECIMAL(10,2) CHECK (balance>=0)
);
-- thêm dữ liệu cho bảng tài khoản 
INSERT INTO Balance_account(name, balance)
VALUES 
	('Minh Thu',1000),
    ('Minh Huyền',500),
    ('Lan Hồng', 200);
    
-- Tạo hàm chuyển tiền 

DELIMITER $$
CREATE PROCEDURE transaction_account (price DECIMAL(10,2), from_id INT, to_id INT)
BEGIN
	UPDATE balance_account SET balance = balance + price WHERE id= to_id;
	UPDATE balance_account SET balance = balance - price WHERE id = from_id;
    
END $$

DELIMITER ;
CALL transaction_account(500, 1,2);

SELECT * FROM balance_account;


-- ÁP DỤNG TRANSACTION ĐỂ XỬ LÝ VẤN ĐỀ ( tài khoản Minh Thu chưa trừ mà tài khoản Minh
-- Huyền đã nhận)

-- Dùng transaction để xử lý vấn đề bài toán

DELIMITER $$ 
CREATE PROCEDURE transaction_acc (
	IN price DECIMAL(10,2),
    IN from_id INT,
    IN to_id INT)
BEGIN
		DECLARE balance_check DECIMAL(10,2);
        SELECT balance INTO balance_check
        FROM balance_account
        WHERE from_id = id
        FOR UPDATE ;
		IF balance_check>= price THEN
			UPDATE balance_account SET balance = balance- price WHERE id= from_id;
            UPDATE balance_account SET balance = balance + price WHERE id= to_id;
            COMMIT;
		ELSE 
			SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Không đủ số dư để chuyển tiền';
			ROLLBACK;
        END IF;
END $$
DELIMITER ; 

CALL transaction_acc(200,1,2);
SELECT * FROM balance_account; 














