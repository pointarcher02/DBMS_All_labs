
-- Q1----------------------------------------------------------------------------

CREATE database ASTHANA;
USE ASTHANA;

CREATE TABLE Salesman (salesman_id int primary key, name varchar(255) not null, address_city varchar(255) not null, coverage_city varchar(255) not null, commission DECIMAL(10, 2) NOT NULL);
-- Now populating the table by inserting dummy values
INSERT INTO Salesman (salesman_id, name, address_city, coverage_city, commission)
VALUES
	(1, 'Shashank Asthana', 'Lucknow', 'Pune', 0.10),
    (2, 'Shreshth Vatsal Sharma', 'Aligarh', 'Gurugram', 0.12),
    (3, 'Anurag Verma', 'Bengaluru', 'Chennai', 0.11),
    (4, 'Manan Srivastava', 'Chennai', 'Bengaluru', 0.09),
    (5, 'G Mukund', 'Kolkata', 'Howrah', 0.08),
    (6, 'Naman Gupta', 'Hyderabad', 'Sikanderabad', 0.10),
    (7, 'Mayank', 'Pune', 'Mumbai', 0.12),
    (8, 'Sharonya Jain', 'Ahmedabad', 'Gandhinagar', 0.11),
    (9, 'Pranav Pant', 'Jaipur', 'Ajmer', 0.09),
    (10, 'Samaksh Verma', 'Lucknow', 'Kanpur', 0.08);

SELECT *
FROM Salesman;


-- a.Display commission rates of Mumbai and Chennai.

SELECT commission
FROM Salesman
WHERE coverage_city IN ('Mumbai', 'Chennai');

-- b. Display salesman_id and name of all salespeople who work in the same city as their address.

SELECT salesman_id, name
FROM Salesman
WHERE address_city = coverage_city;

-- c. Display salesman_id and name of all salespeople who have different addresses and coverage cities.

SELECT salesman_id, name
FROM Salesman
WHERE address_city <> coverage_city;

-- d. Display the highest commission rate of all salespeople working in Mumbai.
SELECT MAX(commission) AS highest_commission
FROM Salesman
WHERE coverage_city = 'Mumbai';

-- e. Display the coverage_city with the highest commission rate.

SELECT coverage_city
FROM Salesman
WHERE commission= (SELECT MAX(commission) FROM Salesman);

-- f.Display the average commission rate for all cities.

SELECT AVG(commission) 
FROM Salesman;

-- g. Find the coverage_city where the commission rate is the same for all salespeople.

SELECT coverage_city
FROM Salesman
GROUP BY coverage_city
HAVING COUNT(DISTINCT commission)=1;

-- h. Find the commission rate that is common across all coverage cities.
SELECT commission
FROM Salesman
GROUP BY commission
HAVING COUNT(DISTINCT coverage_city)=(SELECT COUNT(DISTINCT coverage_city) FROM Salesman);

-- i. Display all details of the salesperson who has worked for all cities.
SELECT *
FROM Salesman
WHERE salesman_id IN(SELECT salesman_id FROM Salesman GROUP BY salesman_id HAVING COUNT(DISTINCT coverage_city)=(SELECT COUNT(DISTINCT coverage_city) FROM Salesman));

-- j. Add two new columns, ‘date_of_employment’ and ‘date_of_release,’ to the table to record the date of employment for all employees and the date of release if the salesperson has left the company.

ALTER TABLE Salesman
ADD date_of_employment DATE,
ADD date_of_release DATE;

-- also adding dummy values to it so that table is complete

UPDATE Salesman
SET date_of_employment = '2022-01-22', date_of_release=null
WHERE salesman_id IN (1,3,5);

UPDATE Salesman
SET date_of_employment = '2019-05-12', date_of_release='2023-03-11'
WHERE salesman_id IN (2,4);







-- Q2-----------------------------------------------------------

CREATE DATABASE uni;
use uni;

CREATE TABLE classroom( building varchar(255), room_number int,capacity int, primary key (building,room_number));
CREATE TABLE department(dept_name VARCHAR(255) PRIMARY KEY,building VARCHAR(255),budget DECIMAL(10, 2),FOREIGN KEY (building) REFERENCES classroom(building));
CREATE TABLE instructor(ID int primary key,instructor_name varchar(255),dept_name varchar(255),salary DECIMAL(10, 2),FOREIGN KEY (dept_name) REFERENCES department(dept_name));
CREATE TABLE course (course_id int primary key,title varchar(255),dept_name varchar(255),credit int,FOREIGN KEY (dept_name) REFERENCES department(dept_name));
CREATE TABLE section(course_id int, sec_id int, semester varchar(255), year int, building varchar(255),room_number int, time_slot_id int, primary key (course_id, sec_id, semester, year),FOREIGN KEY (course_id) REFERENCES course(course_id),FOREIGN KEY (building, room_number) REFERENCES classroom(building, room_number));
CREATE TABLE teaches(ID int, course_id int,sec_id int, semester varchar(255),year int, primary key (ID, course_id, sec_id, semester, year),FOREIGN KEY (ID) REFERENCES instructor(ID),FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES section(course_id, sec_id, semester, year));

CREATE TABLE student (ID INT primary key,name VARCHAR(255),dept_name VARCHAR(255),total_credit INT,FOREIGN KEY (dept_name) REFERENCES department(dept_name));
CREATE TABLE takes (ID int,course_id int,sec_id int,semester varchar(255),year int,grade varchar(255),primary key (ID, course_id, sec_id, semester, year),FOREIGN KEY (ID) REFERENCES student(ID),FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES section(course_id, sec_id, semester, year));
CREATE TABLE advisor(s_ID int primary key, i_ID int,FOREIGN KEY (s_ID) REFERENCES student(ID),FOREIGN KEY (i_ID) REFERENCES instructor(ID));

CREATE TABLE time_slot (time_slot_id int primary key,day varchar(255),start_time TIME,end_time TIME);
CREATE TABLE grade_points (grade varchar(255) primary key,points DECIMAL(10, 2));
CREATE TABLE prereq(course_id int primary key,prereq_id int,FOREIGN KEY (course_id) REFERENCES course(course_id),FOREIGN KEY (prereq_id) REFERENCES course(course_id));

INSERT INTO classroom (building, room_number, capacity)
VALUES
    ('Main Building', 101, 50),
    ('Main Building', 102, 60),
    ('Science Block', 201, 40);
SELECT *
FROM classroom;
INSERT INTO department (dept_name, building, budget)
VALUES
    ('CSE', 'Main Building', 1000000.00),
    ('Mathematics', 'Science Block', 800000.00),
    ('Philosophy', 'Science Block', 750000.00);
SELECT *
FROM department;
INSERT INTO instructor (ID, instructor_name, dept_name,salary)
VALUES
	(101, 'Dr. Rajesh Kumar', 'CSE', 85000.00),
    (102, 'Prof. Priya Sharma', 'Mathematics', 75000.00),
    (103, 'Dr. Suresh Gupta', 'Philosophy', 78000.00);
SELECT *
FROM instructor;
INSERT INTO course (course_id, title, dept_name, credit)
VALUES
    (1, 'Introduction to Programming', 'CSE', 4),
    (2, 'Calculus I', 'Mathematics', 3),
    (3, 'Literature', 'Philosophy', 4);
SELECT *
FROM course;
INSERT INTO section (course_id, sec_id, semester, year,building,room_number, time_slot_id)
VALUES
    (1, 1, 'Fall', 2023, 'Main Building', 101, 1),
    (2, 1, 'Spring', 2023, 'Main Building', 102, 2),
    (3, 1, 'Fall', 2023, 'Science Block', 201, 3);
SELECT *
FROM section;
INSERT INTO teaches (ID, course_id, sec_id, semester, year)
VALUES
    (101, 1, 1, 'Fall', 2023),
    (102, 2, 1, 'Spring', 2023),
    (103, 3, 1, 'Fall', 2023);
SELECT *
FROM teaches;

INSERT INTO student (ID, name, dept_name, total_credit)
VALUES
    (12345, 'Amit Patel', 'CSE', 50),
    (202, 'Priya Sharma', 'Mathematics', 45),
    (203, 'Rahul Verma', 'Philosophy', 55);
SELECT *
FROM student;
INSERT INTO takes (ID, course_id, sec_id, semester, year, grade)
VALUES
    (12345, 1, 1, 'Fall', 2023, 'A+'),
    (202, 2, 1, 'Spring', 2023, 'B+'),
    (203, 3, 1, 'Fall', 2023, 'A-');
SELECT *
FROM takes;
INSERT INTO advisor (s_ID, i_ID)
VALUES
    (12345, 101),
    (202, 102),
    (203, 103);
SELECT *
FROM advisor;
INSERT INTO time_slot (time_slot_id, day, start_time, end_time)
VALUES
    (1, 'Monday', '09:00:00', '10:30:00'),
    (2, 'Tuesday', '10:00:00', '11:30:00'),
    (3, 'Wednesday', '13:30:00', '15:00:00');
SELECT *
FROM time_slot;
INSERT INTO grade_points (grade, points)
VALUES
    ('A+', 10.0),
    ('A', 9.0),
    ('A-', 8.5),
    ('B+', 8.0),
    ('B', 7.0),
    ('B-', 6.5),
    ('C', 6.0),
    ('F', 0.0);
SELECT *
FROM grade_points;
INSERT INTO prereq (course_id, prereq_id)
VALUES
    (2, 1),
    (3, 2);
SELECT *
FROM prereq;

-- now writing the queries

-- a. Find the total grade points earned by the student with ID '12345', across all courses taken by the student.

SELECT s.ID,s.name,SUM(gp.points * c.credit) AS total_grade_points
FROM student s
JOIN takes t ON s.ID=t.ID
JOIN course c ON t.course_id = c.course_id
JOIN grade_points gp ON t.grade = gp.grade
WHERE s.ID = '12345'
GROUP BY s.ID, s.name;

-- b. Find the grade point average (GPA) for the above student that is, the total grade points divided by the total credits for the associated courses.

SELECT s.ID, s.name, SUM(gp.points * c.credit) /SUM(c.credit) AS GPA
FROM student s
JOIN takes t ON s.ID = t.ID
JOIN course c ON t.course_id = c.course_id
JOIN grade_points gp ON t.grade = gp.grade
WHERE s.ID = '12345'
GROUP BY s.ID, s.name;

-- c. Find the ID and the grade-point average of each student for the CSE department.

SELECT s.ID, SUM(gp.points * c.credit)/SUM(c.credit) AS GPA
FROM student s
JOIN takes t ON s.ID = t.ID
JOIN course c ON t.course_id = c.course_id
JOIN grade_points gp ON t.grade = gp.grade
WHERE s.dept_name = 'CSE'
GROUP BY s.ID;

-- d. Find the ID, Name, and GPA for the topper of each department in the University.



WITH StudentGPA AS (
    SELECT s.ID, s.name, d.dept_name, SUM(gp.points * c.credit) / SUM(c.credit) AS GPA
    FROM student s
    JOIN takes t ON s.ID = t.ID
    JOIN course c ON t.course_id = c.course_id
    JOIN grade_points gp ON t.grade = gp.grade
    JOIN department d ON s.dept_name = d.dept_name
    GROUP BY s.ID, s.name, d.dept_name
)

SELECT sg.ID, sg.name, sg.dept_name, sg.GPA
FROM StudentGPA sg
JOIN (
    SELECT dept_name, MAX(GPA) AS max_GPA
    FROM StudentGPA
    GROUP BY dept_name
) maxGPA ON sg.dept_name = maxGPA.dept_name AND sg.GPA = maxGPA.max_GPA;

-- e. Find the names of those departments whose budget is higher than that of Philosophy. List them in alphabetic order.
SELECT dept_name
FROM department
WHERE budget > (SELECT budget FROM department WHERE dept_name = 'Philosophy')
ORDER BY dept_name;

-- f. Find the IDs of those students who have retaken at least three distinct courses at least once

SELECT t1.ID
FROM takes t1
INNER JOIN takes t2 ON  t1.ID=t2.ID AND t1.course_id <> t2.course_id AND t1.year <> t2.year
INNER JOIN takes t3 ON  t1.ID=t3.ID AND t1.course_id <> t3.course_id AND t1.year <> t3.year
WHERE t1.grade IS NOT NULL
GROUP BY t1.ID
HAVING COUNT(DISTINCT t1.course_id) >= 3;

-- g. Find the names and IDs of those instructors who teach every course taught in his or her department (i.e., every course that appears in the course relation with the instructor’s department name). Order results by name.

SELECT DISTINCT i.ID, i.instructor_name
FROM instructor i
WHERE NOT EXISTS (
    SELECT c.course_id
    FROM course c
    WHERE c.dept_name = i.dept_name
    AND c.course_id NOT IN (
        SELECT t.course_id
        FROM teaches t
        WHERE t.ID = i.ID
    )
)
ORDER BY i.instructor_name;

-- h. Find the names and IDs of those instructors along with the details of the courses they taught in Fall 2018, such that the total number of students getting A+ is more than 3 in those courses.

SELECT DISTINCT i.ID, i.instructor_name, c.course_id, c.title, c.credit
FROM instructor i
JOIN teaches t ON i.ID = t.ID
JOIN section s ON t.course_id = s.course_id AND t.sec_id = s.sec_id AND t.semester = s.semester AND t.year = s.year
JOIN course c ON s.course_id = c.course_id
JOIN takes tk ON s.course_id = tk.course_id AND s.sec_id = tk.sec_id AND s.semester = tk.semester AND s.year = tk.year
WHERE t.semester = 'Fall' AND t.year = 2018
GROUP BY i.ID, i.instructor_name, c.course_id, c.title, c.credit
HAVING SUM(CASE WHEN tk.grade = 'A+' THEN 1 ELSE 0 END) > 3;

-- i. Find the ID and name of each instructor who has never given an A grade in any course she or he has taught.

SELECT DISTINCT i.ID, i.instructor_name
FROM instructor i
WHERE NOT EXISTS (
    SELECT 1
    FROM teaches t
    JOIN section s ON t.course_id = s.course_id AND t.sec_id = s.sec_id AND t.semester = s.semester AND t.year = s.year
    JOIN takes tk ON s.course_id = tk.course_id AND s.sec_id = tk.sec_id AND s.semester = tk.semester AND s.year = tk.year
    WHERE t.ID = i.ID AND tk.grade = 'A');
    
-- j. Define the view student grades (ID, GPA), giving the grade-point average of each student. Make sure your view definition correctly handles the case of null values for the grade attribute of the takes relation.

CREATE VIEW student_grades AS
SELECT s.ID, s.name, COALESCE(SUM(gp.points * c.credit) / NULLIF(SUM(c.credit), 0), 0) AS GPA
FROM student s
LEFT JOIN takes t ON s.ID = t.ID
LEFT JOIN course c ON t.course_id = c.course_id
LEFT JOIN grade_points gp ON t.grade = gp.grade
GROUP BY s.ID, s.name;


-- Q3-------------------------------------------------------

SELECT DISTINCT t1.ID AS instructor_1, s1.course_id, s1.sec_id, s1.semester, s1.year,
       s1.building AS building_1, s1.room_number AS room_number_1, s1.time_slot_id AS time_slot_id_1,
       t2.ID AS instructor_2, s2.building AS building_2, s2.room_number AS room_number_2, s2.time_slot_id AS time_slot_id_2
FROM teaches t1
JOIN section s1 ON t1.course_id = s1.course_id AND t1.sec_id = s1.sec_id AND t1.semester = s1.semester AND t1.year = s1.year
JOIN teaches t2 ON t1.ID < t2.ID
JOIN section s2 ON t2.course_id = s2.course_id AND t2.sec_id = s2.sec_id AND t2.semester = s2.semester AND t2.year = s2.year
WHERE s1.semester = s2.semester
  AND s1.year = s2.year
  AND s1.time_slot_id = s2.time_slot_id
  AND (
        (s1.building = s2.building AND s1.room_number != s2.room_number)
        OR
        (s1.building != s2.building)
      );
      










