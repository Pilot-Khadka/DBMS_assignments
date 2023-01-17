-- Active: 1672567514371@@127.0.0.1@3306@DBMS

CREATE DATABASE University_DB;

USE University_DB;

CREATE TABLE
    department (
        dept_name varchar (20),
        building varchar (15),
        budget numeric (12, 2),
        primary key (dept_name)
    );

CREATE TABLE
    course (
        course_id varchar (7),
        title varchar (50),
        dept_name varchar (20),
        credits numeric (2, 0),
        primary key (course_id),
        foreign key (dept_name) references department(dept_name)
    );

create table
    instructor (
        ID varchar (5),
        name varchar(20) not null,
        dept_name varchar (20),
        salary numeric (8, 2),
        primary key (ID),
        foreign key (dept_name) references department(dept_name)
    );

create table
    section (
        course_id varchar (8),
        sec_id varchar (8),
        semester varchar (6),
        year numeric (4, 0),
        building varchar (15),
        room_number varchar (7),
        time_slot_id varchar(4),
        primary key (
            course_id,
            sec_id,
            semester,
            year
        ),
        foreign key (course_id) references course (course_id)
    );

create table
    teaches (
        ID varchar (5),
        course_id varchar (8),
        sec_id varchar (8),
        semester varchar (6),
        year numeric (4, 0),
        primary key (
            ID,
            course_id,
            sec_id,
            semester,
            year
        ),
        foreign key (
            course_id,
            sec_id,
            semester,
            year
        ) references section (
            course_id,
            sec_id,
            semester,
            year
        ),
        foreign key (ID) references instructor(ID)
    );

create table
    student(
        s_id varchar(5),
        name varchar(20) not null,
        dept_name varchar(20),
        tot_cred int,
        primary key(s_id),
        foreign Key (dept_name) references department(dept_name)
    );

create table
    takes(
        s_id varchar(5),
        course_id varchar (8),
        sec_id varchar (8),
        semester varchar (6),
        year numeric (4, 0),
        grade int,
        foreign key(s_id) references student(s_id),
        foreign key(
            course_id,
            sec_id,
            semester,
            year
        ) references section(
            course_id,
            sec_id,
            semester,
            year
        )
    );

create table
    advisor(
        s_id varchar(5),
        ID varchar(8),
        foreign key(s_id) references student(s_id),
        foreign key(ID) references instructor(ID)
    );

INSERT INTO
    department(dept_name, building, budget)
VALUES (
        'Computer Science',
        'Kalkin',
        1000000
    ), ('Physics', 'Williams', 800000), ('Biology', 'Votey', 900000), (
        'Mathematics',
        'Waterman',
        700000
    ), ('English', 'Old Mill', 600000), (
        'Chemistry',
        'Williams',
        900000
    ), ('History', 'Waterman', 800000), (
        'Political Science',
        'Dewey',
        700000
    ), ('Art', 'Hillyer', 500000), (
        'Music',
        'Music Building',
        800000
    ), (
        'Theater',
        'Royall Tyler',
        600000
    ), (
        'Philosophy',
        'Old Mill',
        700000
    );

INSERT INTO
    course (
        course_id,
        title,
        dept_name,
        credits
    )
VALUES (
        'CS101',
        'Introduction to Computer Science',
        'Computer Science',
        4
    ), (
        'CS102',
        'Data Structures and Algorithms',
        'Computer Science',
        4
    ), (
        'PHY101',
        'Classical Mechanics',
        'Physics',
        3
    ), (
        'PHY102',
        'Quantum Mechanics',
        'Physics',
        3
    ), (
        'BIO101',
        'Introduction to Biology',
        'Biology',
        4
    ), (
        'BIO102',
        'Molecular Biology',
        'Biology',
        4
    ), (
        'MATH101',
        'Calculus',
        'Mathematics',
        4
    ), (
        'MATH102',
        'Linear Algebra',
        'Mathematics',
        4
    );

INSERT INTO
    instructor (ID, name, dept_name, salary)
VALUES (
        'I001',
        'John Smith',
        'Computer Science',
        80000
    ), (
        'I002',
        'Jane Doe',
        'Physics',
        90000
    ), (
        'I003',
        'Bob Johnson',
        'Biology',
        75000
    ), (
        'I004',
        'Emma Williams',
        'Mathematics',
        85000
    ), (
        'I005',
        'Michael Brown',
        'English',
        65000
    ), (
        'I006',
        'Amy Davis',
        'Chemistry',
        80000
    ), (
        'I007',
        'David Miller',
        'History',
        72000
    ), (
        'I008',
        'Sara Wilson',
        'Political Science',
        78000
    );

INSERT INTO
    section (
        course_id,
        sec_id,
        semester,
        year,
        building,
        room_number,
        time_slot_id
    )
VALUES (
        'CS101',
        '1',
        'Fall',
        2022,
        'Kalkin',
        '101',
        'M10'
    ), (
        'CS102',
        '1',
        'Fall',
        2022,
        'Kalkin',
        '102',
        'W10'
    ), (
        'PHY101',
        '1',
        'Fall',
        2022,
        'Williams',
        '201',
        'F10'
    ), (
        'PHY102',
        '1',
        'Spring',
        2023,
        'Williams',
        '202',
        'T10'
    ), (
        'BIO101',
        '1',
        'Spring',
        2023,
        'Votey',
        '301',
        'M10'
    ), (
        'BIO102',
        '1',
        'Fall',
        2022,
        'Votey',
        '302',
        'W10'
    ), (
        'MATH101',
        '1',
        'Fall',
        2022,
        'Waterman',
        '401',
        'F10'
    ), (
        'MATH102',
        '1',
        'Spring',
        2023,
        'Waterman',
        '402',
        'T10'
    );

INSERT INTO
    teaches (
        ID,
        course_id,
        sec_id,
        semester,
        year
    )
VALUES (
        'I001',
        'CS101',
        '1',
        'Fall',
        2022
    ), (
        'I002',
        'CS102',
        '1',
        'Fall',
        2022
    ), (
        'I003',
        'PHY101',
        '1',
        'Fall',
        2022
    ), (
        'I004',
        'PHY102',
        '1',
        'Spring',
        2023
    ), (
        'I005',
        'BIO101',
        '1',
        'Spring',
        2023
    ), (
        'I006',
        'BIO102',
        '1',
        'Fall',
        2022
    ), (
        'I007',
        'MATH101',
        '1',
        'Fall',
        2022
    ), (
        'I008',
        'MATH102',
        '1',
        'Spring',
        2023
    );

INSERT INTO
    student (s_id, name, dept_name, tot_cred)
VALUES (
        'S001',
        'John Doe',
        'Computer Science',
        120
    ), (
        'S002',
        'Jane Smith',
        'Physics',
        110
    ), (
        'S003',
        'Bob Johnson',
        'Biology',
        130
    ), (
        'S004',
        'Emma Williams',
        'Mathematics',
        125
    ), (
        'S005',
        'Michael Brown',
        'English',
        105
    ), (
        'S006',
        'Amy Davis',
        'Chemistry',
        120
    ), (
        'S007',
        'David Miller',
        'History',
        130
    ), (
        'S008',
        'Sara Wilson',
        'Political Science',
        135
    );

INSERT INTO
    takes (
        s_id,
        course_id,
        sec_id,
        semester,
        year,
        grade
    )
VALUES (
        'S001',
        'CS101',
        '1',
        'Fall',
        2022,
        85
    ), (
        'S002',
        'CS102',
        '1',
        'Fall',
        2022,
        90
    ), (
        'S003',
        'PHY101',
        '1',
        'Fall',
        2022,
        80
    ), (
        'S004',
        'PHY102',
        '1',
        'Spring',
        2023,
        95
    ), (
        'S005',
        'BIO101',
        '1',
        'Spring',
        2023,
        75
    ), (
        'S006',
        'BIO102',
        '1',
        'Fall',
        2022,
        85
    ), (
        'S007',
        'MATH101',
        '1',
        'Fall',
        2022,
        90
    ), (
        'S008',
        'MATH102',
        '1',
        'Spring',
        2023,
        80
    );

INSERT INTO advisor (s_id, ID)
VALUES ('S001', 'I001'), ('S002', 'I002'), ('S003', 'I003'), ('S004', 'I004');

----------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT * FROM department;

SELECT * FROM course;

SELECT * FROM instructor;

SELECT * FROM section;

SELECT * FROM teaches;

----------------------------------------------------------------------------------------------------------------------------------------------------------

-- 4 (a) Find the names of all instructors in History department

SELECT name FROM instructor WHERE dept_name='History';

----------------------------------------------------------------------------------------------------------------------------------------------------------

-- 4 (b) Find the instructor ID and department name of all instructors associated with a department with budget of greater than $75,000

SELECT ID, dept_name FROM instructor WHERE salary > 75000;

----------------------------------------------------------------------------------------------------------------------------------------------------------

-- 4(c) Find the names of all instructors in the Comp. Sci. department together with the course titles of all the courses that the instructors teach

SELECT name, title
FROM instructor
    NATURAL JOIN (teaches, course)
WHERE
    dept_name = 'Computer Science';

----------------------------------------------------------------------------------------------------------------------------------------------------------

-- 4(d) Find the names of all students who have taken the course title of “Introduction to Computer Science”.

SELECT name
FROM student
    NATURAL JOIN (takes, course)
WHERE
    title = 'Introduction to Computer Science';

----------------------------------------------------------------------------------------------------------------------------------------------------------

-- 4(e) For each department, find the maximum salary of instructors in that department. You may assume that every department has at least one instructor.

SELECT
    dept_name,
    MAX(salary) as Max_Salary
FROM instructor
GROUP BY dept_name;

----------------------------------------------------------------------------------------------------------------------------------------------------------

-- 4(f) Find the lowest, across all departments, of the per-department maximum salary computed by the preceding query.

SELECT MIN(Max_Salary)
FROM (
        SELECT
            dept_name,
            MAX(salary) as Max_Salary
        FROM instructor
        GROUP BY
            dept_name
    ) as M;

----------------------------------------------------------------------------------------------------------------------------------------------------------

-- 4(g) Find the ID and names of all students who do not have an advisor.

SELECT S.s_id
FROM student S
    LEFT JOIN advisor A ON S.s_id = A.s_id
WHERE A.s_id IS NULL;