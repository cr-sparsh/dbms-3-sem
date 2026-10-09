-- LAB 9: Implement Procedures (basic, Insert, Update, Delete)
-- Tested on MySQL / MariaDB

-- 1. Create database, table and insert data
DROP DATABASE IF EXISTS lab9;
CREATE DATABASE lab9;
USE lab9;
CREATE TABLE students (
  roll_no INT PRIMARY KEY,
  name    VARCHAR(30),
  course  VARCHAR(20),
  marks   INT
);
INSERT INTO students VALUES
 (1,'Sparsh','BCA',82),(2,'Aman','BCA',74),(3,'Riya','BCA',91);
SELECT * FROM students;

-- 2. Basic procedure (no parameters) - display all students
DELIMITER //
CREATE PROCEDURE sp_show_students()
BEGIN
  SELECT * FROM students;
END //
DELIMITER ;
CALL sp_show_students();

-- 3. Procedure with IN and OUT parameters - get marks of a student
DELIMITER //
CREATE PROCEDURE sp_get_marks(IN p_roll INT, OUT p_marks INT)
BEGIN
  SELECT marks INTO p_marks FROM students WHERE roll_no = p_roll;
END //
DELIMITER ;
CALL sp_get_marks(3, @m);
SELECT @m AS marks_of_roll_3;

-- 4. Procedure for INSERT
DELIMITER //
CREATE PROCEDURE sp_insert_student(
  IN p_roll INT, IN p_name VARCHAR(30), IN p_course VARCHAR(20), IN p_marks INT)
BEGIN
  INSERT INTO students VALUES (p_roll, p_name, p_course, p_marks);
END //
DELIMITER ;
CALL sp_insert_student(4, 'Neha', 'BCA', 68);
CALL sp_insert_student(5, 'Karan', 'BCA', 77);
SELECT * FROM students;

-- 5. Procedure for UPDATE
DELIMITER //
CREATE PROCEDURE sp_update_marks(IN p_roll INT, IN p_marks INT)
BEGIN
  UPDATE students SET marks = p_marks WHERE roll_no = p_roll;
END //
DELIMITER ;
CALL sp_update_marks(2, 80);
SELECT * FROM students;

-- 6. Procedure for DELETE
DELIMITER //
CREATE PROCEDURE sp_delete_student(IN p_roll INT)
BEGIN
  DELETE FROM students WHERE roll_no = p_roll;
END //
DELIMITER ;
CALL sp_delete_student(5);
SELECT * FROM students;

-- 7. Procedure with IF/ELSE - grade of a student
DELIMITER //
CREATE PROCEDURE sp_grade(IN p_roll INT)
BEGIN
  DECLARE m INT;
  SELECT marks INTO m FROM students WHERE roll_no = p_roll;
  IF m >= 90 THEN SELECT p_roll AS roll_no, m AS marks, 'A+' AS grade;
  ELSEIF m >= 75 THEN SELECT p_roll AS roll_no, m AS marks, 'A' AS grade;
  ELSEIF m >= 60 THEN SELECT p_roll AS roll_no, m AS marks, 'B' AS grade;
  ELSE SELECT p_roll AS roll_no, m AS marks, 'C' AS grade;
  END IF;
END //
DELIMITER ;
CALL sp_grade(3);
CALL sp_grade(2);

-- 8. List the stored procedures created
SELECT routine_name, routine_type
FROM information_schema.routines
WHERE routine_schema = 'lab9'
ORDER BY routine_name;

