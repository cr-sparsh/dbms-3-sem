-- LAB 5: Implement SQL Operators (Arithmetic, Comparison and Logical)
-- Tested on MySQL / MariaDB

-- 1. Create database, table and insert data
DROP DATABASE IF EXISTS lab5;
CREATE DATABASE lab5;
USE lab5;
CREATE TABLE products (
  pid      INT PRIMARY KEY,
  pname    VARCHAR(20),
  category VARCHAR(20),
  price    INT,
  qty      INT
);
INSERT INTO products VALUES
 (1,'Keyboard','Accessories',800,25),
 (2,'Mouse','Accessories',450,40),
 (3,'Monitor','Display',9500,10),
 (4,'Laptop','Computer',55000,5),
 (5,'Webcam','Accessories',2200,0),
 (6,'Printer','Office',7200,8);
SELECT * FROM products;

-- 2. ARITHMETIC operators: + - * / % and DIV
SELECT 20 + 6 AS addition, 20 - 6 AS subtraction, 20 * 6 AS multiplication,
       20 / 6 AS division, 20 DIV 6 AS integer_division, 20 % 6 AS modulus;

-- 3. ARITHMETIC operators applied on table columns
SELECT pname, price, qty,
       price * qty        AS stock_value,
       price + 100        AS price_plus_100,
       price - price*0.10 AS after_10pct_discount,
       price % 1000       AS remainder
FROM products;

-- 4. COMPARISON operators: =  >  <
SELECT pname, price FROM products WHERE category = 'Accessories';
SELECT pname, price FROM products WHERE price > 5000;
SELECT pname, qty   FROM products WHERE qty < 10;

-- 5. COMPARISON operators: >=  <=  != (<>)
SELECT pname, price FROM products WHERE price >= 7200;
SELECT pname, price FROM products WHERE price <= 800;
SELECT pname, category FROM products WHERE category <> 'Accessories';

-- 6. COMPARISON result as 1 (true) / 0 (false) and NULL-safe equal <=>
SELECT 10 > 5 AS gt, 10 = 5 AS eq, 10 != 5 AS ne, NULL = NULL AS null_eq, NULL <=> NULL AS null_safe_eq;

-- 7. LOGICAL operator: AND
SELECT pname, category, price FROM products
WHERE category = 'Accessories' AND price > 500;

-- 8. LOGICAL operator: OR
SELECT pname, category, price FROM products
WHERE category = 'Display' OR category = 'Office';

-- 9. LOGICAL operator: NOT
SELECT pname, category FROM products
WHERE NOT category = 'Accessories';

-- 10. LOGICAL operators combined with brackets and XOR
SELECT pname, category, price, qty FROM products
WHERE (category = 'Accessories' OR category = 'Office') AND qty > 0;
SELECT pname, price, qty FROM products
WHERE (price > 5000) XOR (qty > 8);

