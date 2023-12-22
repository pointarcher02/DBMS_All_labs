-- FIRST CREATING THE SCHEMA OF THE TABLES

CREATE TABLE classroom (
    building VARCHAR(255),
    room_number INT,
    capacity INT,
    PRIMARY KEY (building, room_number)
);

CREATE TABLE department (
    dept_name VARCHAR(255),
    building VARCHAR(255),
    budget DECIMAL(10, 2),
    PRIMARY KEY (dept_name)
);

CREATE TABLE instructor (
    ID INT,
    name VARCHAR(255),
    dept_name VARCHAR(255),
    salary DECIMAL(10, 2),
    PRIMARY KEY (ID),
    FOREIGN KEY (dept_name) REFERENCES department(dept_name)
);

CREATE TABLE course (
    course_id VARCHAR(255),
    title VARCHAR(255),
    dept_name VARCHAR(255),
    credit INT,
    PRIMARY KEY (course_id),
    FOREIGN KEY (dept_name) REFERENCES department(dept_name)
);

CREATE TABLE section (
    course_id VARCHAR(255),
    sec_id INT,
    semester VARCHAR(255),
    year INT,
    building VARCHAR(255),
    room_number INT,
    time_slot_id INT,
    PRIMARY KEY (course_id, sec_id, semester, year),
    FOREIGN KEY (course_id) REFERENCES course(course_id)
);

CREATE TABLE teaches (
    ID INT,
    course_id VARCHAR(255),
    sec_id INT,
    semester VARCHAR(255),
    year INT,
    PRIMARY KEY (ID, course_id, sec_id, semester, year),
    FOREIGN KEY (ID) REFERENCES instructor(ID),
    FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES section(course_id, sec_id, semester, year)
);

CREATE TABLE student (
    ID INT,
    name VARCHAR(255),
    dept_name VARCHAR(255),
    total_credit INT,
    PRIMARY KEY (ID),
    FOREIGN KEY (dept_name) REFERENCES department(dept_name)
);

CREATE TABLE takes (
    ID INT,
    course_id VARCHAR(255),
    sec_id INT,
    semester VARCHAR(255),
    year INT,
    grade VARCHAR(2),
    PRIMARY KEY (ID, course_id, sec_id, semester, year),
    FOREIGN KEY (ID) REFERENCES student(ID),
    FOREIGN KEY (course_id, sec_id, semester, year) REFERENCES section(course_id, sec_id, semester, year)
);
DROP TABLE takes;

CREATE TABLE advisor (
    s_ID INT,
    i_ID INT,
    PRIMARY KEY (s_ID),
    FOREIGN KEY (s_ID) REFERENCES student(ID),
    FOREIGN KEY (i_ID) REFERENCES instructor(ID)
);

CREATE TABLE time_slot (
    time_slot_id INT,
    day VARCHAR(255),
    start_time DATE,
    end_time DATE,
    PRIMARY KEY (time_slot_id)
);

CREATE TABLE prereq (
    course_id VARCHAR(255),
    prereq_id VARCHAR(255),
    PRIMARY KEY (course_id, prereq_id),
    FOREIGN KEY (course_id) REFERENCES course(course_id),
    FOREIGN KEY (prereq_id) REFERENCES course(course_id)
);

-- NOW POPULATING THE TABLES

INSERT INTO classroom (building, room_number, capacity) VALUES ('Building A', 101, 30);
INSERT INTO classroom (building, room_number, capacity) VALUES ('Building B', 201, 40);
INSERT INTO classroom (building, room_number, capacity) VALUES ('Building C', 301, 25);
INSERT INTO classroom (building, room_number, capacity) VALUES ('Building A', 102, 35);
INSERT INTO classroom (building, room_number, capacity) VALUES ('Building B', 202, 45);
INSERT INTO classroom (building, room_number, capacity) VALUES ('Building C', 302, 20);

SELECT *FROM classroom;

INSERT INTO department (dept_name, building, budget) VALUES ('Computer Science', 'Building X', 100000);
INSERT INTO department (dept_name, building, budget) VALUES ('Mathematics', 'Building Y', 80000);
INSERT INTO department (dept_name, building, budget) VALUES ('Physics', 'Building Z', 70000);
INSERT INTO department (dept_name, building, budget) VALUES ('Chemistry', 'Building Z', 60000);
INSERT INTO department (dept_name, building, budget) VALUES ('Biology', 'Building W', 75000);
INSERT INTO department (dept_name, building, budget) VALUES ('Economics', 'Building V', 90000);

SELECT *FROM department;

INSERT INTO instructor (ID, name, dept_name, salary) VALUES (101, 'Prof. Suchetana Chakraborty', 'Computer Science', 200000);
INSERT INTO instructor (ID, name, dept_name, salary) VALUES (102, 'Prof. Gaurav ', 'Mathematics', 250000);
INSERT INTO instructor (ID, name, dept_name, salary) VALUES (103, 'Prof. Kumar', 'Physics', 180000);
INSERT INTO instructor (ID, name, dept_name, salary) VALUES (104, 'Prof. Banerjee', 'Biology', 320000);
INSERT INTO instructor (ID, name, dept_name, salary) VALUES (105, 'Prof. Narayan', 'Chemistry', 170000);
INSERT INTO instructor (ID, name, dept_name, salary) VALUES (106, 'Prof. Philip', 'Economics', 100000);

SELECT *FROM instructor;

INSERT INTO course (course_id, title, dept_name, credit) VALUES ('CS101', 'Introduction to Computer Science', 'Computer Science', 3);
INSERT INTO course (course_id, title, dept_name, credit) VALUES ('MATH101', 'Calculus I', 'Mathematics', 4);
INSERT INTO course (course_id, title, dept_name, credit) VALUES ('PHY101', 'Physics I', 'Physics', 4);
INSERT INTO course (course_id, title, dept_name, credit) VALUES ('BIO101', 'Biology I', 'Biology', 3);
INSERT INTO course (course_id, title, dept_name, credit) VALUES ('CHEM101', 'Chemistry I', 'Chemistry', 3);
INSERT INTO course (course_id, title, dept_name, credit) VALUES ('HIST101', 'Indian Economics', 'Economics', 3);

SELECT *FROM course;

INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id) VALUES ('CS101', 1, 'Fall', 2023, 'Building A', 101, 1);
INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id) VALUES ('MATH101', 1, 'Fall', 2023, 'Building B', 201, 2);
INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id) VALUES ('PHY101', 1, 'Fall', 2023, 'Building C', 301, 3);
INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id) VALUES ('BIO101', 1, 'Fall', 2023, 'Building A', 102, 4);
INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id) VALUES ('CHEM101', 1, 'Fall', 2023, 'Building B', 202, 5);
INSERT INTO section (course_id, sec_id, semester, year, building, room_number, time_slot_id) VALUES ('HIST101', 1, 'Fall', 2023, 'Building C', 302, 6);

SELECT *FROM SECTION;

INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES (101, 'CS101', 1, 'Fall', 2023);
INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES (102, 'MATH101', 1, 'Fall', 2023);
INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES (103, 'PHY101', 1, 'Fall', 2023);
INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES (104, 'BIO101', 1, 'Fall', 2023);
INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES (105, 'CHEM101', 1, 'Fall', 2023);
INSERT INTO teaches (ID, course_id, sec_id, semester, year) VALUES (106, 'HIST101', 1, 'Fall', 2023);
    
SELECT * FROM TEACHES;

INSERT INTO student (ID, name, dept_name, total_credit) VALUES (201, 'Samuel', 'Computer Science', 0);
INSERT INTO student (ID, name, dept_name, total_credit) VALUES (202, 'Shashank Asthana', 'Mathematics', 0);
INSERT INTO student (ID, name, dept_name, total_credit) VALUES (203, 'SVS', 'Physics', 0);
INSERT INTO student (ID, name, dept_name, total_credit) VALUES (204, 'Manan Choti', 'Biology', 0);
INSERT INTO student (ID, name, dept_name, total_credit) VALUES (205, 'SJ', 'Chemistry', 0);
INSERT INTO student (ID, name, dept_name, total_credit) VALUES (206, 'Yash', 'Economics', 0);

SELECT * FROM student;
    
INSERT INTO takes (ID, course_id, sec_id, semester, year, grade) VALUES (201, 'CS101', 1, 'Fall', 2023, 'A');
INSERT INTO takes (ID, course_id, sec_id, semester, year, grade) VALUES (202, 'MATH101', 1, 'Fall', 2023, 'B');
INSERT INTO takes (ID, course_id, sec_id, semester, year, grade) VALUES (203, 'PHY101', 1, 'Fall', 2023, 'C');
INSERT INTO takes (ID, course_id, sec_id, semester, year, grade) VALUES (204, 'BIO101', 1, 'Fall', 2023, 'A');
INSERT INTO takes (ID, course_id, sec_id, semester, year, grade) VALUES (205, 'CHEM101', 1, 'Fall', 2023, 'B');
INSERT INTO takes (ID, course_id, sec_id, semester, year, grade) VALUES (206, 'HIST101', 1, 'Fall', 2023, 'C');

SELECT * FROM takes;

INSERT INTO advisor (s_ID, i_ID) VALUES (201, 101);
INSERT INTO advisor (s_ID, i_ID) VALUES (202, 102);
INSERT INTO advisor (s_ID, i_ID) VALUES (203, 103);
INSERT INTO advisor (s_ID, i_ID) VALUES (204, 104);
INSERT INTO advisor (s_ID, i_ID) VALUES (205, 105);

SELECT * FROM advisor;

INSERT INTO time_slot (time_slot_id, day, start_time, end_time) VALUES (1, 'Monday', TO_DATE('08:00:00', 'HH24:MI:SS'), TO_DATE('09:30:00', 'HH24:MI:SS'));

INSERT INTO time_slot (time_slot_id, day, start_time, end_time)
VALUES (2, 'Tuesday', TO_DATE('09:00:00', 'HH24:MI:SS'), TO_DATE('10:30:00', 'HH24:MI:SS'));


INSERT INTO time_slot (time_slot_id, day, start_time, end_time)
VALUES (3, 'Wednesday', TO_DATE('10:00:00', 'HH24:MI:SS'), TO_DATE('11:30:00', 'HH24:MI:SS'));


INSERT INTO time_slot (time_slot_id, day, start_time, end_time)
VALUES (4, 'Thursday', TO_DATE('11:00:00', 'HH24:MI:SS'), TO_DATE('12:30:00', 'HH24:MI:SS'));


INSERT INTO time_slot (time_slot_id, day, start_time, end_time)
VALUES (5, 'Friday', TO_DATE('13:00:00', 'HH24:MI:SS'), TO_DATE('14:30:00', 'HH24:MI:SS'));


INSERT INTO time_slot (time_slot_id, day, start_time, end_time)
VALUES (6, 'Saturday', TO_DATE('14:00:00', 'HH24:MI:SS'), TO_DATE('15:30:00', 'HH24:MI:SS'));

SELECT * FROM time_slot;

INSERT INTO prereq (course_id, prereq_id) VALUES ('CS101', 'MATH101');
INSERT INTO prereq (course_id, prereq_id) VALUES ('PHY101', 'MATH101');
INSERT INTO prereq (course_id, prereq_id) VALUES ('BIO101', 'CHEM101');
INSERT INTO prereq (course_id, prereq_id) VALUES ('CHEM101', 'PHY101');
INSERT INTO prereq (course_id, prereq_id) VALUES ('HIST101', 'BIO101');
INSERT INTO prereq (course_id, prereq_id) VALUES ('MATH101', 'HIST101');

SELECT *FROM prereq;
-- QUERY NUMBER 1

CREATE TABLE output_table1 (
    fibonacci_num NUMBER(10)
);

DECLARE
    fib_seq NUMBER(10);
    n NUMBER(2) := 6;
    prev1 NUMBER := 1;
    prev2 NUMBER := 0;

BEGIN
   
    INSERT INTO output_table1 (fibonacci_num) VALUES (0);
    INSERT INTO output_table1 (fibonacci_num) VALUES (1);

    
    FOR i IN 3..n LOOP
        fib_seq := prev1 + prev2;
        INSERT INTO output_table1 (fibonacci_num) VALUES (fib_seq);
        prev2 := prev1;
        prev1 := fib_seq;
    END LOOP;
END;
/

SELECT * FROM output_table1;
    
    
-- QUERY NUMBER 2

CREATE TABLE output_table2 (
    course_id VARCHAR2(255),
    prereq_id VARCHAR2(255)
);

DECLARE
    v_prereq_id VARCHAR2(255);
    v_course_id VARCHAR2(255);
    
    CURSOR prereq_cursor IS
        SELECT course_id, prereq_id FROM prereq
        WHERE prereq_id IN ('1011', '1032', '2310');
BEGIN
    FOR prereq_rec IN prereq_cursor LOOP
        v_course_id := prereq_rec.course_id;
        v_prereq_id := prereq_rec.prereq_id;

      
        INSERT INTO output_table2 (course_id, prereq_id)
        VALUES (v_course_id, v_prereq_id);
    END LOOP;
END;
/

SELECT *FROM output_table2;

-- QUERY NUMBER 3

CREATE TABLE instructor_count_table (
    dept_name VARCHAR2(255),
    instructor_count NUMBER(3)
);

DECLARE
    v_dept_name VARCHAR2(255);
    v_instructor_count NUMBER(3);
    
    CURSOR dept_cursor IS
        SELECT DISTINCT dept_name FROM instructor;
BEGIN
    OPEN dept_cursor;
    LOOP
        FETCH dept_cursor INTO v_dept_name;
        EXIT WHEN dept_cursor%NOTFOUND;

        
        SELECT COUNT(*) INTO v_instructor_count
        FROM instructor
        WHERE dept_name = v_dept_name;

        
        INSERT INTO instructor_count_table (dept_name, instructor_count)
        VALUES (v_dept_name, v_instructor_count);
    END LOOP;
    CLOSE dept_cursor;
END;
/

SELECT *FROM instructor_count_table;

    
-- Query Number 4

CREATE TABLE dummytable (
    department_name VARCHAR2(255),
    average_salary NUMBER(10, 2)
);

DECLARE
    v_dept_name VARCHAR2(255);
    v_avg_salary NUMBER(10, 2);
    
    CURSOR dept_cursor IS
        SELECT DISTINCT dept_name FROM instructor;
BEGIN
    OPEN dept_cursor;
    LOOP
        FETCH dept_cursor INTO v_dept_name;
        EXIT WHEN dept_cursor%NOTFOUND;

        
        SELECT AVG(salary) INTO v_avg_salary
        FROM instructor
        WHERE dept_name = v_dept_name;

        -- Display department name and average salary
        DBMS_OUTPUT.PUT_LINE('Department: ' || v_dept_name || ', Average Salary: ' || v_avg_salary);

        
        INSERT INTO dummytable (department_name, average_salary)
        VALUES (v_dept_name, v_avg_salary);
    END LOOP;
    CLOSE dept_cursor;
END;
/

SELECT * FROM dummytable;



-- QUERY NUMBER 5

UPDATE takes
SET grade = 'C'
WHERE course_id = 'MATH101' AND grade = 'B';

SELECT *FROM takes;

-- Query Number 6

UPDATE department
SET budget = budget * 1.20
WHERE dept_name IN ('Computer Science', 'Mathematics');

SELECT *FROM department;

-- Query Number 7
CREATE TABLE output_table6 AS
SELECT DISTINCT t.course_id
FROM takes t
JOIN student s ON t.ID = s.ID
GROUP BY t.course_id
HAVING COUNT(DISTINCT s.dept_name) >= 1;

SELECT *FROM output_table6;

DROP table output_table;

-- Query Number 8

CREATE TABLE output_table5 (
    course_id VARCHAR2(255),
    grade VARCHAR2(2),
    credit NUMBER(2)
);

DECLARE
    TYPE grade_credit_rec IS RECORD (
        grade VARCHAR2(2),
        credit NUMBER(2)
    );

    v_student_id NUMBER(5) := 201; 
    v_last_semester NUMBER(4) := 2023; 
    v_current_semester NUMBER(4) := 2023; 

    CURSOR course_cursor IS
        SELECT DISTINCT t.course_id, t.grade, c.credit
        FROM takes t
        JOIN course c ON t.course_id = c.course_id
        WHERE t.ID = v_student_id AND
              (t.year = v_last_semester OR t.year = v_current_semester);
BEGIN
    FOR course_rec IN course_cursor LOOP
      
        DBMS_OUTPUT.PUT_LINE('Course: ' || course_rec.course_id || ', Grade: ' || course_rec.grade || ', Credit: ' || course_rec.credit);
        
       
        INSERT INTO output_table5 (course_id, grade, credit)
        VALUES (course_rec.course_id, course_rec.grade, course_rec.credit);
    END LOOP;
END;
/
-- DROP TABLE output_table5;
SELECT *FROM output_table5;
    
-- Query Number 9

DECLARE
    v_instructor_name VARCHAR2(255) := 'Ram'; 
    v_instructor_id NUMBER(5);
BEGIN
    
    SELECT ID INTO v_instructor_id
    FROM instructor
    WHERE name = v_instructor_name;

    -- If instructor is found, it will display the ID
    DBMS_OUTPUT.PUT_LINE('Instructor ID: ' || v_instructor_id);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Handle the exception if instructor is not found
        DBMS_OUTPUT.PUT_LINE('Instructor not found in the database.');
END;
/


-- Query Number 10


CREATE TABLE output_table AS
SELECT t.course_id, t.semester, t.year
FROM takes t
JOIN teaches ON teaches.course_id=t.course_id
JOIN instructor i ON t.ID = teaches.ID
WHERE i.name = 'Prof. Suchetana Chakraborty'
    AND t.year >= EXTRACT(YEAR FROM SYSDATE) -3
GROUP BY t.course_id, t.semester, t.year
HAVING SUM(CASE WHEN t.grade = 'B' THEN 1 ELSE 0 END) / COUNT(*) > 0.05;



SELECT *FROM output_table;


   
    
    
    
    

    
    
    
    
    
    
    
    
    
    