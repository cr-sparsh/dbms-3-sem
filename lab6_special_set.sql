-- LAB 6: Implement SQL Operators (Special Operators and Set Operations)
-- Tested on MySQL / MariaDB

-- 1. Create database, tables and insert data
DROP DATABASE IF EXISTS lab6;
CREATE DATABASE lab6;
USE lab6;
CREATE TABLE students (
  roll_no INT PRIMARY KEY,
  name    VARCHAR(20),
  city    VARCHAR(20),
  marks   INT,
  email   VARCHAR(30)
);
INSERT INTO students VALUES
 (1,'Sparsh','Bangalore',82,'sparsh@mail.com'),
 (2,'Aman','Udaipur',74,NULL),
 (3,'Riya','Delhi',91,'riya@mail.com'),
 (4,'Neha','Bangalore',68,NULL),
 (5,'Karan','Mumbai',55,'karan@mail.com');
CREATE TABLE sports (name VARCHAR(20), sport VARCHAR(20));
INSERT INTO sports VALUES ('Sparsh','Chess'),('Riya','Cricket'),('Zoya','Tennis'),('Aman','Chess');
SELECT * FROM students;
SELECT * FROM sports;

-- 2. SPECIAL operator: BETWEEN
SELECT name, marks FROM students WHERE marks BETWEEN 70 AND 90;
SELECT name, marks FROM students WHERE marks NOT BETWEEN 70 AND 90;

-- 3. SPECIAL operator: IN / NOT IN
SELECT name, city FROM students WHERE city IN ('Bangalore','Delhi');
SELECT name, city FROM students WHERE city NOT IN ('Bangalore','Delhi');

-- 4. SPECIAL operator: LIKE with % and _ wildcards
SELECT name FROM students WHERE name LIKE 'S%';
SELECT name FROM students WHERE name LIKE '%a';
SELECT name FROM students WHERE name LIKE '_i%';

-- 5. SPECIAL operator: IS NULL / IS NOT NULL
SELECT name, email FROM students WHERE email IS NULL;
SELECT name, email FROM students WHERE email IS NOT NULL;

-- 6. SPECIAL operator: EXISTS
SELECT name FROM students s
WHERE EXISTS (SELECT 1 FROM sports p WHERE p.name = s.name);

-- 7. SPECIAL operators: ANY and ALL
SELECT name, marks FROM students
WHERE marks > ALL (SELECT marks FROM students WHERE city = 'Bangalore');
SELECT name, marks FROM students
WHERE marks > ANY (SELECT marks FROM students WHERE city = 'Bangalore');

-- 8. SET operation: UNION (removes duplicates)
SELECT name FROM students
UNION
SELECT name FROM sports;

-- 9. SET operation: UNION ALL (keeps duplicates)
SELECT name FROM students
UNION ALL
SELECT name FROM sports;

-- 10. SET operation: UNION with different columns and ORDER BY
SELECT name, 'Student' AS source FROM students WHERE marks >= 80
UNION
SELECT name, sport FROM sports
ORDER BY name;

-- 11. SET operations: INTERSECT and EXCEPT (extra)
SELECT name FROM students
INTERSECT
SELECT name FROM sports;
SELECT name FROM students
EXCEPT
SELECT name FROM sports;

