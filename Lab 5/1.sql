CREATE DATABASE CompanyDB;
USE CompanyDB;


-- Employee table
CREATE TABLE Employee (
    Emp_ID INT PRIMARY KEY,
    Emp_Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);


-- Salary audit table
CREATE TABLE Salary_Audit (
    Audit_ID INT AUTO_INCREMENT PRIMARY KEY,
    Emp_ID INT,
    Old_Salary DECIMAL(10,2),
    New_Salary DECIMAL(10,2),
    Change_Time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Insert employees
INSERT INTO Employee VALUES
(1, 'Rahul', 'IT', 50000);

INSERT INTO Employee VALUES
(2, 'Priya', 'HR', 45000);


-- Trigger
DELIMITER //

CREATE TRIGGER after_salary_update
AFTER UPDATE ON Employee
FOR EACH ROW
BEGIN
    IF OLD.Salary <> NEW.Salary THEN

        INSERT INTO Salary_Audit
        (Emp_ID, Old_Salary, New_Salary)
        VALUES
        (OLD.Emp_ID, OLD.Salary, NEW.Salary);

    END IF;
END //

DELIMITER ;


-- Change salary
UPDATE Employee
SET Salary = 60000
WHERE Emp_ID = 1;



UPDATE Employee
SET Salary = 50000
WHERE Emp_ID = 2;

SELECT * FROM Employee;
SELECT * FROM Salary_Audit;
