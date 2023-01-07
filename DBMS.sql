-- Active: 1672567514371@@127.0.0.1@3306@DBMS

CREATE DATABASE Company_DB;

USE Company_DB;

CREATE TABLE
    employee (
        employee_name varchar(255) not null,
        street varchar(255) not null,
        city varchar(255) not null,
        primary key(employee_name)
    );

CREATE TABLE
    works (
        employee_name varchar(255) not null,
        FOREIGN KEY (employee_name) references employee(employee_name),
        company_name varchar(255),
        salary decimal(10, 2)
    );

CREATE TABLE
    company (
        company_name varchar(255) not null,
        city varchar(255),
        PRIMARY KEY(company_name)
    );

CREATE TABLE
    manages (
        employee_name varchar(255) not null,
        FOREIGN KEY (employee_name) references employee(employee_name),
        manager_name varchar(255)
    );

INSERT INTO
    employee (employee_name, street, city)
VALUES (
        'John Smith',
        '123 Main St',
        'New York'
    ), (
        'Jane Doe',
        '456 Park Ave',
        'Chicago'
    ), (
        'Alice Williams',
        '321 Maple St',
        'Houston'
    ), (
        'Sara Davis',
        '159 Broadway',
        'New York'
    ), (
        'Mark Thompson',
        '235 Fifth Ave',
        'New York'
    ), (
        'Ashley Johnson',
        '876 Market St',
        'Chicago'
    ), (
        'Emily Williams',
        '741 First St',
        'Los Angeles'
    ), (
        'Michael Brown',
        '902 Main St',
        'Houston'
    ), (
        'Samantha Smith',
        '111 Second St',
        'Chicago'
    );

INSERT INTO
    employee (employee_name, street, city)
VALUES (
        'Patrick',
        '123 Main St',
        'New Mexico'
    );

INSERT INTO
    works (
        employee_name,
        company_name,
        salary
    )
VALUES (
        'John Smith',
        'First Bank Corporation',
        80000.00
    ), (
        'Jane Doe',
        'First Bank Corporation',
        75000.00
    ), (
        'Bob Johnson',
        'First Bank Corporation',
        90000.00
    ), (
        'Alice Williams',
        'First Bank Corporation',
        85000.00
    ), (
        'Sara Davis',
        'First Bank Corporation',
        82500.00
    ), (
        'Mark Thompson',
        'Small Bank Corporation',
        78000.00
    ), (
        'Ashley Johnson',
        'Small Bank Corporation',
        92000.00
    ), (
        'Emily Williams',
        'Small Bank Corporation',
        86500.00
    ), (
        'Michael Brown',
        'Small Bank Corporation',
        81000.00
    ), (
        'Samantha Smith',
        'Small Bank Corporation',
        77000.00
    );

INSERT INTO
    works (
        employee_name,
        company_name,
        salary
    )
VALUES (
        'Patrick',
        'Pongyang Corporation',
        500000
    );

UPDATE works
SET salary = '1000'
WHERE
    employee_name = 'John Smith'
    AND company_name = 'First Bank Corporation';

INSERT INTO
    company (company_name, city)
VALUES (
        'Small Bank Corporation',
        'Chicago'
    ), ('ABC Inc', 'Los Angeles'), ('Def Co', 'Houston'), (
        'First Bank Corporation',
        'New York'
    ), ('456 Corp', 'Chicago'), ('789 Inc', 'Los Angeles'), ('321 Co', 'Houston');

INSERT INTO
    company(company_name, city)
values (
        'Pongyang Corporation',
        'Chicago'
    );

INSERT INTO
    manages(employee_name, manager_name)
VALUES ('John Smith', 'Jane Doe'), ('Bob Johnson', 'Jane  Doe');

INSERT INTO
    manages (employee_name, manager_name)
VALUES (
        'Bob Johnson',
        'Samantha Williams'
    );

UPDATE employee
SET street = '123'
WHERE
    employee_name = 'Jane Doe';

SELECT * FROM employee;

SELECT * FROM works;

SELECT * FROM company;

SELECT * FROM manages;

----------------------------------------------------------------------------------------------------------------------------------------------------------

-- 2 (a) Find the names of all employees who work for First Bank Corporation

SELECT employee_name
FROM works
WHERE
    company_name = 'First Bank Corporation';

----------------------------------------------------------------------------------------------------------------------------------------------------------

-- 2 (b) Find the names and cities of residence of all employees who work for First Bank Corporation

SELECT E.employee_name, E.city
FROM employee E, works W
WHERE
    E.employee_name = W.employee_name
    AND W.company_name = 'First Bank Corporation';

-- ************************************** USING JOIN **************************************

SELECT E.employee_name, E.city
FROM employee E
    NATURAL JOIN works W
WHERE
    W.company_name = 'First Bank Corporation';

----------------------------------------------------------------------------------------------------------------------------------------------------------

-- 2 (c) Find the names, street addresses, and cities of residence of all employees who work for First Bank Corporation and earn more than $100,000

SELECT
    E.employee_name,
    E.street,
    E.city
FROM employee E, works w
WHERE
    E.employee_name = W.employee_name
    AND W.company_name = 'First Bank Corporation'
    AND W.salary > 10000;

-- ************************************** USING JOIN **************************************

SELECT
    E.employee_name,
    E.street,
    E.city
FROM employee E
    NATURAL JOIN works W
WHERE
    W.company_name = 'First Bank Corporation'
    AND W.salary > 10000;

----------------------------------------------------------------------------------------------------------------------------------------------------------

-- 2 (d) Find all employees in the database who live in the same cities as companies for which they work

SELECT E.employee_name
FROM
    employee E,
    company C,
    works W
WHERE
    E.employee_name = W.employee_name
    AND W.company_name = C.company_name
    AND E.city = C.city;

-- ************************************** USING JOIN **************************************

SELECT E.employee_name
FROM employee E
    NATURAL JOIN (company C, works W)
WHERE
    W.company_name = C.company_name
    AND E.city = C.city;

----------------------------------------------------------------------------------------------------------------------------------------------------------

-- 2 (e) Find all employees in database who live in the same cities and on the same streets as do their manager

SELECT
    E1.employee_name,
    M.manager_name
FROM
    employee E1,
    employee E2,
    manages M
WHERE
    E1.employee_name = M.employee_name
    AND E2.employee_name = M.manager_name
    AND E1.street = E2.street
    AND E1.city = E2.city;

-- ************************************** USING JOIN **************************************

----------------------------------------------------------------------------------------------------------------------------------------------------------

-- 2 (f) Find all employees in database who do not work for First Bank Corporation

SELECT
    W.employee_name,
    W.company_name
FROM works W
WHERE
    NOT W.company_name = 'First Bank Corporation';

-- ************************************** USING JOIN **************************************

SELECT
    E.employee_name,
    W.company_name
FROM employee E
    NATURAL JOIN works W
WHERE
    W.company_name != 'First Bank Corporation';

----------------------------------------------------------------------------------------------------------------------------------------------------------

-- 2 (g) Find all employees in the database who earn more than each employee of Small Bank Corporation

SELECT W.employee_name
FROM works W
WHERE
    NOT W.company_name = 'Small Bank Corporation'
    AND W.salary > (
        SELECT MAX(W.salary)
        FROM works W
        WHERE
            W.company_name = 'Small Bank Corporation'
    );

----------------------------------------------------------------------------------------------------------------------------------------------------------

-- 2 (h) Assume that the companies may be located in several cities. Find the companies located in every city in which Small Bank Corporation is located.

SELECT C.company_name, C.city
FROM company C
WHERE C.city = (
        SELECT city
        FROM company
        WHERE
            company_name = 'Small Bank Corporation'
    )
    AND NOT C.company_name = 'Small Bank Corporation';

----------------------------------------------------------------------------------------------------------------------------------------------------------

-- 2 (i) Find all employees who earn more than the average salary of all employees of their company.

SELECT
    W.employee_name,
    W.company_name
FROM works W
WHERE W.salary > (
        SELECT AVG(salary)
        FROM works
    );

----------------------------------------------------------------------------------------------------------------------------------------------------------

-- 2 (j) Find the company that has the most employees

SELECT
    W.company_name,
    count(W.company_name) as occurence
FROM works W
GROUP BY company_name
ORDER BY occurence DESC
LIMIT 1;

----------------------------------------------------------------------------------------------------------------------------------------------------------

-- 2 (k) Find the company that has the smallest payroll

SELECT
    W.company_name,
    W.salary
FROM works W
WHERE W.salary = (
        SELECT MIN(salary)
        FROM works
    );

----------------------------------------------------------------------------------------------------------------------------------------------------------

-- 2 (l) Find those companies whose employees earn a higher salary, on average, than the average salary at First Bank Corporation.

SELECT W.company_name
FROM works W
GROUP BY W.company_name
HAVING AVG(W.salary) > (
        SELECT AVG(salary)
        FROM works
        WHERE
            company_name = 'First Bank Corporation'
    );

----------------------------------------------------------------------------------------------------------------------------------------------------------

-- 3 (a) Modify the database so that John Smith now lives in Newton

Update employee
SET city = 'Newton'
WHERE
    employee_name = 'John Smith';

SELECT city FROM employee WHERE employee_name = 'John Smith';

----------------------------------------------------------------------------------------------------------------------------------------------------------

-- 3 (b) Give all employees of 'First Bank Corporation' 10% raise

SELECT employee_name, salary
FROM works
WHERE
    company_name = 'First Bank Corporation';

UPDATE works
SET salary = 1.1 * salary
WHERE
    company_name = 'First Bank Corporation';

----------------------------------------------------------------------------------------------------------------------------------------------------------

-- 3 (c) Give all managers of 'First Bank Corporation' 10% raise

-- select manager and salary

SELECT
    W.employee_name,
    W.salary
FROM works W, manages M
WHERE
    W.employee_name = M.manager_name
    AND W.company_name = 'First Bank Corporation';

-- update manager salary

UPDATE works W, manages M
SET W.salary = 1.1 * W.salary
WHERE
    W.company_name = 'First Bank Corporation'
    AND W.employee_name = M.manager_name;

----------------------------------------------------------------------------------------------------------------------------------------------------------

-- 3 (d) Give all managers of 'First Bank Corporation' 10% raise unless the salary becomes greater than $100,000; in such case, give only 3 % raise

SELECT
    W.employee_name,
    W.salary
FROM works W, manages M
WHERE
    W.employee_name = M.manager_name;

-- code

UPDATE works W, manages M
SET
    W.salary = (
        CASE
            WHEN (W.salary + salary * 0.1) < 100000 THEN W.salary * 1.1
            ELSE W.salary * 1.03
        END
    )
WHERE
    W.employee_name = M.manager_name
    AND W.company_name = 'First Bank Corporation';

----------------------------------------------------------------------------------------------------------------------------------------------------------

-- 3 (e) Delete all tuples in the works relation for employees of Small Bank Corporation

SELECT * FROM works;

--code

DELETE FROM works WHERE company_name = 'Small Bank Corporation';