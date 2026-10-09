-- LAB 10: Implement Triggers (validation before/after insert, update, delete)
-- Tested on MySQL / MariaDB

-- 1. Create database, tables and insert data
DROP DATABASE IF EXISTS lab10;
CREATE DATABASE lab10;
USE lab10;
CREATE TABLE students (
  roll_no INT PRIMARY KEY,
  name    VARCHAR(30),
  marks   INT
);
CREATE TABLE audit_log (
  log_id     INT AUTO_INCREMENT PRIMARY KEY,
  action     VARCHAR(30),
  roll_no    INT,
  old_marks  INT,
  new_marks  INT
);
INSERT INTO students VALUES (1,'Sparsh',82),(2,'Aman',74);
SELECT * FROM students;

-- 2. BEFORE INSERT trigger - validate marks are between 0 and 100
DELIMITER //
CREATE TRIGGER trg_before_insert
BEFORE INSERT ON students
FOR EACH ROW
BEGIN
  IF NEW.marks < 0 OR NEW.marks > 100 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Invalid marks: must be between 0 and 100';
  END IF;
END //
DELIMITER ;
INSERT INTO students VALUES (3,'Riya',150);

-- 3. Valid insert still works
INSERT INTO students VALUES (3,'Riya',91);
SELECT * FROM students;

-- 4. AFTER INSERT trigger - record the action in audit_log
DELIMITER //
CREATE TRIGGER trg_after_insert
AFTER INSERT ON students
FOR EACH ROW
BEGIN
  INSERT INTO audit_log(action, roll_no, old_marks, new_marks)
  VALUES ('INSERT', NEW.roll_no, NULL, NEW.marks);
END //
DELIMITER ;
INSERT INTO students VALUES (4,'Neha',68);
SELECT * FROM audit_log;

-- 5. BEFORE UPDATE trigger - reject marks outside 0 to 100
DELIMITER //
CREATE TRIGGER trg_before_update
BEFORE UPDATE ON students
FOR EACH ROW
BEGIN
  IF NEW.marks < 0 OR NEW.marks > 100 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Update rejected: marks must be between 0 and 100';
  END IF;
END //
DELIMITER ;
UPDATE students SET marks = 120 WHERE roll_no = 2;

-- 6. AFTER UPDATE trigger - log old and new marks
DELIMITER //
CREATE TRIGGER trg_after_update
AFTER UPDATE ON students
FOR EACH ROW
BEGIN
  INSERT INTO audit_log(action, roll_no, old_marks, new_marks)
  VALUES ('UPDATE', NEW.roll_no, OLD.marks, NEW.marks);
END //
DELIMITER ;
UPDATE students SET marks = 80 WHERE roll_no = 2;
SELECT * FROM students;
SELECT * FROM audit_log;

-- 7. BEFORE DELETE trigger - toppers (marks >= 90) cannot be deleted
DELIMITER //
CREATE TRIGGER trg_before_delete
BEFORE DELETE ON students
FOR EACH ROW
BEGIN
  IF OLD.marks >= 90 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Delete rejected: topper records cannot be deleted';
  END IF;
END //
DELIMITER ;
DELETE FROM students WHERE roll_no = 3;

-- 8. AFTER DELETE trigger - log the deleted record
DELIMITER //
CREATE TRIGGER trg_after_delete
AFTER DELETE ON students
FOR EACH ROW
BEGIN
  INSERT INTO audit_log(action, roll_no, old_marks, new_marks)
  VALUES ('DELETE', OLD.roll_no, OLD.marks, NULL);
END //
DELIMITER ;
DELETE FROM students WHERE roll_no = 4;
SELECT * FROM students;
SELECT * FROM audit_log;

-- 9. List the triggers created
SELECT trigger_name, action_timing, event_manipulation, event_object_table
FROM information_schema.triggers
WHERE trigger_schema = 'lab10'
ORDER BY trigger_name;

