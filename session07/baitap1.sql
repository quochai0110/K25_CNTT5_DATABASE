-- bài tập 1

SELECT title, price
FROM Courses
WHERE PRICE = (SELECT price FROM (Course)
	WHERE instructor_id=5);
/*
	phân tích vấn đề:
    -	
*/
-- giải quyết vấn đề