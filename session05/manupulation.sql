/*
	1. Chỉ lấy những đơn hàng có giá trị thanh toán (total_amount)
    dao động từ 2.000.000đ đến 5.000.000đ.
    2. trạng thái đơn hàng không được ở trạng thái CANCELLED
    3. Tùy biến hiển thị: Tạo một cột ảo tên là Alert_Level trên màn hình. 
    Nếu đơn hàng > 4.000.000đ, in ra 'Nguy hiểm', còn lại in ra 'Bình thường'.
    4. Viết công thức tính toán OFF_SET
    off_set = (curent_page -1) * limit) : n là muốn hiển thị trang nào
    limit 5 off_set 0
    limit 5 off_set 5 
    limit 5 off_set 10
    5. chặn lại 
		if(page<=0){
			page=1;
		}
        if(limit <=0){
			limit= 20;
        }
        
*/
SELECT *
FROM order_detail
WHERE total_amount BETWEEN 2000000 AND 5000000
AND status <> 'CANCELLED'
AND (note LIKE '%gấp%' OR (user_id IS NULL));

SELECT *,
	CASE 
		WHEN total_amount > 4000000 THEN 'NGUY HIỂM'
        ELSE 'BÌNH THƯỜNG'
	END AS alert_level
FROM order_detail

;
