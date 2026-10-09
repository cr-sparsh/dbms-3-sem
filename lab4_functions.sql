-- LAB 4: Implement SQL Functions (Conversion and Date Functions)
-- Tested on MySQL / MariaDB

-- 1. Create database, table and insert data
DROP DATABASE IF EXISTS lab4;
CREATE DATABASE lab4;
USE lab4;
CREATE TABLE orders (
  order_id   INT PRIMARY KEY,
  customer   VARCHAR(20),
  amount     VARCHAR(10),
  order_date DATE
);
INSERT INTO orders VALUES
 (1,'Asha','1250.75','2026-01-15'),
 (2,'Ravi','890.50','2026-03-02'),
 (3,'Meera','2300.00','2026-07-28'),
 (4,'Karan','450.25','2026-10-05');
SELECT * FROM orders;

-- 2. CONVERSION: CAST - string to number and number to string
SELECT order_id,
       amount,
       CAST(amount AS DECIMAL(10,2)) AS amount_decimal,
       CAST(amount AS SIGNED)        AS amount_int,
       CAST(order_id AS CHAR)        AS id_as_text
FROM orders;

-- 3. CONVERSION: CONVERT - number and date conversion
SELECT CONVERT('123', UNSIGNED) AS text_to_number,
       CONVERT(98.76, CHAR)     AS number_to_text,
       CONVERT('2026-12-25', DATE) AS text_to_date;

-- 4. CONVERSION: STR_TO_DATE - text in any format to a date
SELECT STR_TO_DATE('25-12-2026', '%d-%m-%Y') AS d1,
       STR_TO_DATE('March 5, 2026', '%M %d, %Y') AS d2;

-- 5. CONVERSION: DATE_FORMAT and FORMAT - date/number to formatted text
SELECT order_id,
       DATE_FORMAT(order_date, '%d-%b-%Y') AS short_date,
       DATE_FORMAT(order_date, '%W, %M %e, %Y') AS long_date,
       FORMAT(CAST(amount AS DECIMAL(10,2)) * 1000, 2) AS amount_formatted
FROM orders;

-- 6. CONVERSION: implicit conversion (string used in arithmetic)
SELECT '10' + 5 AS implicit_add, '3.5' * 2 AS implicit_mul;

-- 7. DATE: current date and time functions
SELECT CURDATE() AS today, CURTIME() AS time_now, NOW() AS date_time_now;

-- 8. DATE: extract parts of a date
SELECT order_id, order_date,
       YEAR(order_date)      AS yr,
       MONTH(order_date)     AS mon,
       DAY(order_date)       AS dy,
       MONTHNAME(order_date) AS month_name,
       DAYNAME(order_date)   AS day_name,
       QUARTER(order_date)   AS qtr
FROM orders;

-- 9. DATE: EXTRACT, WEEK and DAYOFYEAR
SELECT order_date,
       EXTRACT(YEAR FROM order_date) AS yr,
       WEEK(order_date)      AS week_no,
       DAYOFYEAR(order_date) AS day_of_year
FROM orders;

-- 10. DATE: DATE_ADD, DATE_SUB and LAST_DAY
SELECT order_date,
       DATE_ADD(order_date, INTERVAL 10 DAY)   AS plus_10_days,
       DATE_ADD(order_date, INTERVAL 2 MONTH)  AS plus_2_months,
       DATE_SUB(order_date, INTERVAL 1 YEAR)   AS minus_1_year,
       LAST_DAY(order_date)                    AS month_end
FROM orders;

-- 11. DATE: DATEDIFF and TIMESTAMPDIFF - difference between dates
SELECT order_id, order_date,
       DATEDIFF('2026-12-31', order_date)                AS days_to_year_end,
       TIMESTAMPDIFF(MONTH, order_date, '2026-12-31')    AS months_to_year_end
FROM orders;

-- 12. DATE: age calculation and filtering by date
SELECT TIMESTAMPDIFF(YEAR, '2005-06-20', '2026-10-09') AS age_in_years;
SELECT * FROM orders WHERE YEAR(order_date) = 2026 AND MONTH(order_date) >= 7;

