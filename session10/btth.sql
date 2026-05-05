CREATE DATABASE session10_btth;
USE session10_btth;

-- THAO TÁC 1 : THIẾT KẾ BẢNG DỮ LIỆU 
-- TẠO BẢNG THÔNG TIN CỦA BỆNH NHÂN
CREATE TABLE Patients (
	Patient_ID VARCHAR(5) PRIMARY KEY,
    Full_Name VARCHAR(50) NOT NULL,
    Admission_Time DATETIME DEFAULT NOW()
);

-- TẠO BẢNG LƯU LỊCH SỬ BỆNH NHÂN
CREATE TABLE Vitals_Log (
	Log_id INT AUTO_INCREMENT PRIMARY KEY,
    Patient_ID VARCHAR(5),
    Heart_Rate INT CHECK (Heart_Rate>0),
    Blood_Pressure VARCHAR(50),
    Record_Time DATETIME DEFAULT NOW(),
    FOREIGN KEY (Patient_ID) REFERENCES Patients (Patient_ID)
);

-- THAO TÁC 2: TỐI ƯU HÓA CÂU LỆNH TRUY VẤN
-- Hệ thống sẽ tra cứu nhịp tim theo từng bệnh nhân và theo thời gian gần nhất. 
-- Hãy viết lệnh:
-- Tạo một Composite Index trên hai cột Patient_ID và Record_Time của bảng Vitals_Logs
-- để tăng tốc độ lọc dữ liệu mới nhất.
CREATE INDEX composite_index ON Vitals_logs(Patient_ID,Record_Time);

-- THAO TÁC 3 : XÂY DỰNG DASHBOARD HIỂN THỊ 

CREATE VIEW  ER_Dashboard_View AS 
SELECT  p.full_name , 
		CASE WHEN Heart_Rate > 120 OR Heart_Rate <50 
        THEN 'critical' 
		ELSE  'STABLE'
		END AS 'Urgency_Level'
FROM Patients p
JOIN Vitals_logs v 
ON p.Patient_ID = v.Patient_ID




