-- LAB 8: Implement Grouping and Ordering (GROUP BY, HAVING, ORDER BY)
-- Tested on MySQL / MariaDB

-- 1. Create database, table and insert data
DROP DATABASE IF EXISTS lab8;
CREATE DATABASE lab8;
USE lab8;
CREATE TABLE employees (
  emp_id INT PRIMARY KEY,
  name   VARCHAR(30),
  dept   VARCHAR(20),
  city   VARCHAR(20),
  salary INT
);
INSERT INTO employees VALUES
 (1,'Asha','IT','Bangalore',60000),
 (2,'Ravi','IT','Udaipur',55000),
 (3,'Meera','HR','Bangalore',45000),
 (4,'Karan','Finance','Delhi',70000),
 (5,'Neha','IT','Bangalore',65000),
 (6,'Imran','HR','Delhi',48000),
 (7,'Priya','Finance','Bangalore',72000);
SELECT * FROM employees;

-- 2. GROUP BY - count and average salary per department
SELECT dept, COUNT(*) AS total_emp, AVG(salary) AS avg_salary
FROM employees
GROUP BY dept;

-- 3. GROUP BY with SUM, MIN and MAX
SELECT dept, SUM(salary) AS total_salary,
       MIN(salary) AS lowest, MAX(salary) AS highest
FROM employees
GROUP BY dept;

-- 4. GROUP BY on multiple columns
SELECT dept, city, COUNT(*) AS total_emp
FROM employees
GROUP BY dept, city;

-- 5. HAVING - keep only groups with average salary above 55000
SELECT dept, AVG(salary) AS avg_salary
FROM employees
GROUP BY dept
HAVING AVG(salary) > 55000;

-- 6. WHERE + GROUP BY + HAVING together (Bangalore only, departments with 2+ people)
SELECT dept, COUNT(*) AS total_emp
FROM employees
WHERE city = 'Bangalore'
GROUP BY dept
HAVING COUNT(*) >= 2;

-- 7. ORDER BY ascending (default)
SELECT name, dept, salary
FROM employees
ORDER BY salary;

-- 8. ORDER BY descending
SELECT name, dept, salary
FROM employees
ORDER BY salary DESC;

-- 9. ORDER BY multiple columns (dept A-Z, then salary high to low)
SELECT name, dept, salary
FROM employees
ORDER BY dept ASC, salary DESC;

-- 10. GROUP BY + HAVING + ORDER BY combined
SELECT dept, COUNT(*) AS total_emp, SUM(salary) AS total_salary
FROM employees
GROUP BY dept
HAVING SUM(salary) > 100000
ORDER BY total_salary DESC;

