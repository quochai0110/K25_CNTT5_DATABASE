USE session11;
/*

	THAM SỐ TRONG PROCEDURE?
    CÁC LOẠI THAM SỐ TRONG PROCEDURE
    1. IN : TRUYỀN VÀO 
    2. OUT : ĐẦU RA 
    3. INOUT 
*/
-- TẠO HÀM THỦ TỤC LẤY NGƯỜI DÙNG THEO ID
DELIMITER $$
CREATE PROCEDURE get_user_by_id(IN user_id INT)
BEGIN
	SELECT * FROM Users
    WHERE id= user_id;
END $$
DELIMITER ;
CALL get_user_by_id(7);

-- VIẾT PROCEDURE TÌM KIẾM USER THEO TÊN
DELIMITER $$
CREATE PROCEDURE find_user_by_name(IN name_in VARCHAR(100))
BEGIN
	SELECT * FROM Users 
    WHERE name LIKE CONCAT('%',name_in,'%');
END $$
DELIMITER ;
CALL find_user_by_name('Hoa');
-- VIẾT HÀM THỦ TỤC TRẢ VỀ KẾT QUẢ DANH SÁCH USERS

DELIMITER $$
CREATE PROCEDURE totalUser (OUT total INT)
BEGIN
		SELECT COUNT(*) INTO total FROM Users;
END $$
DELIMITER ;
CALL totalUser(@total);
SELECT @total;

-- Biến trong PROCEDURE : dùng để lưu trữ dữ liệu tạm thời-- xử lý logic
-- cú pháp tạo biến :  DECLARE variable_name data_type

-- tạo hàm thủ tục kiểm trả user, sau đó tạo biến để kiểm tra xem có tồn tại user hay không
-- nếu có hiển thị tên user là:
-- nếu không có thì thông báo user không tồn tại
USE session11;
DELIMITER $$
CREATE PROCEDURE check_user (IN user_id INT)
BEGIN 
	DECLARE full_name VARCHAR(100);
	SELECT name  INTO full_name FROM Users
    WHERE id=user_id;
    IF full_name IS NULL THEN
		SELECT 'user không tồn tại' AS message;
	ELSE
		SELECT  CONCAT('TÊN USER LÀ:',full_name) AS user_name;
	END IF;
END $$
DELIMITER ;
CALL check_user(3);

-- ĐẾM SỐ LƯỢNG USER TRONG BẢNG USER
-- SAU ĐÓ PHÂN LOẠI
-- MỨC ÍT < 10, >10 LỚP ĐÔNG

DELIMITER $$
CREATE PROCEDURE classify_user_count ()
BEGIN
	DECLARE count INT;
	SELECT COUNT(*) INTO count FROM Users;
    IF count <10 THEN
		SELECT 'lớp ít' AS message;
    ELSE 
		SELECT 'lớp đông' AS message;
	END IF;
END $$
DELIMITER ;
CALL classify_user_count();


















