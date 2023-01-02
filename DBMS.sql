-- Active: 1672567514371@@127.0.0.1@3306
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

drop table works;

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

SELECT * FROM employee;

INSERT INTO
    works (
        employee_name,
        company_name,
        salary
    )
VALUES (
        'John Smith',
        'Acme Inc',
        80000.00
    ), (
        'Jane Doe',
        'XYZ Corp',
        75000.00
    ), (
        'Bob Johnson',
        'ABC Inc',
        90000.00
    ), (
        'Alice Williams',
        'Def Co',
        85000.00
    ), (
        'Sara Davis',
        'Acme Inc',
        82500.00
    ), (
        'Mark Thompson',
        'XYZ Corp',
        78000.00
    ), (
        'Ashley Johnson',
        'ABC Inc',
        92000.00
    ), (
        'Emily Williams',
        'Def Co',
        86500.00
    ), (
        'Michael Brown',
        'Acme Inc',
        81000.00
    ), (
        'Samantha Smith',
        'XYZ Corp',
        77000.00
    );

SELECT * FROM works;

INSERT INTO
    company (company_name, city)
VALUES ('XYZ Corp', 'Chicago'), ('ABC Inc', 'Los Angeles'), ('Def Co', 'Houston'), ('123 Inc', 'New York'), ('456 Corp', 'Chicago'), ('789 Inc', 'Los Angeles'), ('321 Co', 'Houston');

-- modify the database so Jane Smith now lives in India

Update employee
set city = 'India'
WHERE
    employee_name = 'Jane Smith'

    
INSERT INTO
    manages (employee_name, manager_name)
VALUES (
        'Bob Johnson',
        'Samantha Williams'
    );

SELECT * FROM company;

SELECT * FROM manages;

SELECT * FROM works;

-- give all employees of 'ACME inc' 10% raise

SELECT
    E.employee_name,
    M.employee_name,
    W.salary
From
    employee E,
    manages M,
    works W
WHERE
    E.employee_name = M.employee_name;

-- code

UPDATE
    works W,
    employee E,
    manages M
SET W.salary = 1.1 * W.salary
WHERE
    W.company_name = 'ACME inc'
    AND E.employee_name = M.employee_name;

-- give all managers of 'ACME inc' 10% raise

UPDATE
    works W,
    employee E,
    manages M
SET W.salary = 1.1 * W.salary
WHERE
    W.company_name = 'ACME inc'
    AND E.employee_name = M.manager_name;

-- give all managers of 'ACME inc' 3% raise if salary greater than 100,000

UPDATE
    works W,
    employee E,
    manages M
SET W.salary = 1.1 * W.salary
WHERE
    W.company_name = 'ACME inc'
    AND E.employee_name = M.manager_name;

-- storing value in variable

SELECT @employee_backup;

SELECT * INTO @employee_backup FROM employee;

DROP TABLE employee_backup;

-- back up into a table

INSERT INTO employee_backup (SELECT * FROM employee);

SELECT * FROM employee_backup;

-- 2.d

SELECT E.employee_name, E.city
From
    employee E,
    company C,
    works W
WHERE
    E.employee_name = W.employee_name
    AND W.company_name = C.company_name
    AND E.city = C.city;

SELECT city from company;

SELECT * from company;

-- employee = manager = street name

SELECT
    E.employee_name,
    M.employee_name,
    E.street
From employee E, manages M
WHERE E.street = E.street;