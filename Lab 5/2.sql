CREATE DATABASE CollegeDB;
USE CollegeDB;

-- Main table
CREATE TABLE Student (
    Student_ID INT PRIMARY KEY,
    Student_Name VARCHAR(50),
    Course VARCHAR(50)
);

CREATE TABLE Student_Count (
    Total_Students INT
);


INSERT INTO Student_Count VALUES (0);



DELIMITER //

CREATE TRIGGER after_student_insert
AFTER INSERT ON Student
FOR EACH ROW
BEGIN
    UPDATE Student_Count
    SET Total_Students = Total_Students + 1;
END //

DELIMITER ;


-- Insert students
INSERT INTO Student VALUES
(101, 'Rahul', 'BCA');

INSERT INTO Student VALUES
(102, 'Priya', 'BCA');

INSERT INTO Student VALUES
(103, 'Aman', 'BCA');



SELECT * FROM Student;

SELECT * FROM Student_Count;

-- Create procedure
DELIMITER //

CREATE PROCEDURE GetStudentDetails(IN p_student_id INT)
BEGIN

    SELECT *
    FROM Student
    WHERE Student_ID = p_student_id;

END //

DELIMITER ;


-- Execute procedure
CALL GetStudentDetails(102);

