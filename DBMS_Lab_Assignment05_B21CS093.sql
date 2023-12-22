


CREATE TABLE HOSPITAL
(
    HOSP_NAME VARCHAR2(50)  PRIMARY KEY,
    COUNTRY VARCHAR2(50),
    ADDRESS VARCHAR2(100)
);

CREATE TABLE MEDICINE
(
    REG_NO NUMBER PRIMARY KEY,
    MED_NAME VARCHAR2(20) NOT NULL,
    PRICE NUMBER(4, 3),
    EXP_DATE DATE
);

CREATE TABLE DOCTOR
(
    DOC_ID NUMBER PRIMARY KEY,
    DNAME VARCHAR2(30),
    GENDER CHAR(1),
    QUALIFICATION VARCHAR2(30),
    JOB_SPECIFICATION VARCHAR2(30),
    HOSP_NAME VARCHAR2(50),
    FOREIGN KEY (HOSP_NAME) REFERENCES HOSPITAL(HOSP_NAME)
);

CREATE TABLE NURSE
(
    NURSE_ID NUMBER PRIMARY KEY,
    NAME VARCHAR2(30),
    GENDER CHAR(1),
    DOC_ID NUMBER,
    HOSP_NAME VARCHAR2(50),
    FOREIGN KEY (DOC_ID) REFERENCES DOCTOR (DOC_ID),
    FOREIGN KEY (HOSP_NAME) REFERENCES HOSPITAL (HOSP_NAME)
);

CREATE TABLE RECEPTION
(
    REC_ID NUMBER   PRIMARY KEY,
    TEL_NO VARCHAR2(20) NOT NULL,
    EMAIL VARCHAR2(30),
    HOSP_NAME VARCHAR2(50),
    FOREIGN KEY (HOSP_NAME) REFERENCES HOSPITAL (HOSP_NAME)
);


CREATE TABLE PATIENT
(
    SSN NUMBER PRIMARY KEY,
    FNAME VARCHAR2(30),
    LNAME VARCHAR2(30),
    AGE INTEGER,
    GENDER CHAR(1),
    NURSE_ID NUMBER,
    REC_ID NUMBER(30),
    FOREIGN KEY (NURSE_ID) REFERENCES NURSE(NURSE_ID),
    FOREIGN KEY (REC_ID) REFERENCES RECEPTION(REC_ID)
);

CREATE TABLE APPOINTMENT
(
    APPOINT_NO NUMBER   PRIMARY KEY,
    APPOINT_DATE DATE   NOT NULL,
    APPOINT_TIME TIMESTAMP,
    REC_ID NUMBER,
    FOREIGN KEY (REC_ID) REFERENCES RECEPTION (REC_ID)
);

CREATE TABLE DIAGNOSIS
(
    DIAGNOS_NO NUMBER PRIMARY KEY,
    ISSUE_DATE DATE,
    TREATMENT VARCHAR2(50),
    REMARKS VARCHAR2(50),
    NURSE_ID NUMBER,
    DOC_ID NUMBER,
    FOREIGN KEY (NURSE_ID) REFERENCES NURSE (NURSE_ID),
    FOREIGN KEY (DOC_ID) REFERENCES DOCTOR (DOC_ID)
);

CREATE TABLE VISIT
(
    VISIT_DATE DATE,
    SSN NUMBER,
    HOSP_NAME VARCHAR2(50),
    FOREIGN KEY (SSN) REFERENCES PATIENT (SSN),
    FOREIGN KEY (HOSP_NAME) REFERENCES HOSPITAL (HOSP_NAME)
);

CREATE TABLE PURCHASE
(
    SSN NUMBER,
    REG_NO NUMBER,
    FOREIGN KEY (SSN) REFERENCES PATIENT (SSN),
    FOREIGN KEY (REG_NO) REFERENCES MEDICINE (REG_NO)
);

CREATE TABLE EXAMINE
(
    SSN NUMBER,
    DOC_ID NUMBER,
    FOREIGN KEY (SSN) REFERENCES PATIENT (SSN),
    FOREIGN KEY (DOC_ID) REFERENCES DOCTOR (DOC_ID)
);

CREATE TABLE MEDICINE_COUNTRY
(
    REG_NO NUMBER,
    MAN_COUNTRY VARCHAR2(50),
    FOREIGN KEY (REG_NO) REFERENCES MEDICINE (REG_NO)
);



-- Inserting data into Hospital

INSERT INTO HOSPITAL (HOSP_NAME, COUNTRY, ADDRESS) VALUES
('King Hamad University Hospital', 'Kingdom of Bahrain', 'Sheikh Isa bin Salman Bridge, Al Sayh, Busaiteen, Bahrain');

INSERT INTO HOSPITAL (HOSP_NAME, COUNTRY, ADDRESS) VALUES
('Mayo Clinic', 'United States', '4500 San Pablo Road, US');

INSERT INTO HOSPITAL (HOSP_NAME, COUNTRY, ADDRESS) VALUES
('Bahrain Defence Force Hospital', 'Kingdom of Bahrain', 'Waly Alahed Avenue, West Riffa, Bahrain');

INSERT INTO HOSPITAL (HOSP_NAME, COUNTRY, ADDRESS) VALUES
('Salamaniya Hospital', 'Kindgom of Bahrain', 'Salmaniya Medical Complex, Manama, Bahrain');

INSERT INTO HOSPITAL (HOSP_NAME, COUNTRY, ADDRESS) VALUES
('St Thomas'' Hospital London', 'United Kingdom', 'Westminster Bridge Rd, London');

INSERT INTO HOSPITAL (HOSP_NAME, COUNTRY, ADDRESS) VALUES 
('King Faisal Specialist Hospital Centre', 'Kingdom of Saudi Arabia', 'Al Mathar Ash Shamali, Riyadh 11564, Saudi Arabia');

INSERT INTO HOSPITAL (HOSP_NAME, COUNTRY, ADDRESS) VALUES
('Al-Hilal Hospital', 'Kingdom of Bahrain', 'Al-Hilal Hospital, Muharraq, Bahrain');

INSERT INTO HOSPITAL (HOSP_NAME, COUNTRY, ADDRESS) VALUES
('Emirates Hospital', 'United Arab Emirates', 'Jumeirah Beach Rd, Dubai, UAE');

INSERT INTO HOSPITAL (HOSP_NAME, COUNTRY, ADDRESS) VALUES
('American Mission Hospital', 'Kingdom of Bahrain', 'Sheikh Essa Road, Manama, Bahrain');

INSERT INTO HOSPITAL (HOSP_NAME, COUNTRY, ADDRESS) VALUES
('Dar Al Shifa Hospital', 'Kuwait', 'Beirut Street, Hawally, Kuwait');

SELECT * FROM HOSPITAL;

-- Insert into table Medicine


INSERT INTO MEDICINE (REG_NO, MED_NAME, PRICE, EXP_DATE) VALUES
(20, 'Adol Syrup', 0.300, TO_DATE('15/05/2023', 'DD/MM/YYYY'));

INSERT INTO MEDICINE (REG_NO, MED_NAME, PRICE, EXP_DATE) VALUES
(21, 'Amoxil Capsules', 0.700, TO_DATE('10/03/2023', 'DD/MM/YYYY'));

INSERT INTO MEDICINE (REG_NO, MED_NAME, PRICE, EXP_DATE) VALUES
(22, 'Aspirin', 1.000, TO_DATE('09/12/2023', 'DD/MM/YYYY'));

INSERT INTO MEDICINE (REG_NO, MED_NAME, PRICE, EXP_DATE) VALUES
(23, 'Bonjela Gel', 0.400, TO_DATE('23/09/2024', 'DD/MM/YYYY'));

INSERT INTO MEDICINE (REG_NO, MED_NAME, PRICE, EXP_DATE) VALUES
(24, 'Paracetamol', 1.200, TO_DATE('17/05/2024', 'DD/MM/YYYY'));

INSERT INTO MEDICINE (REG_NO, MED_NAME, PRICE, EXP_DATE) VALUES
(25, 'Atorvastatin', 1.500, TO_DATE('15/06/2023', 'DD/MM/YYYY'));

INSERT INTO MEDICINE (REG_NO, MED_NAME, PRICE, EXP_DATE) VALUES
(26, 'Coversyl', 1.000, TO_DATE('15/05/2023', 'DD/MM/YYYY'));

INSERT INTO MEDICINE (REG_NO, MED_NAME, PRICE, EXP_DATE) VALUES
(27, 'Diamicron', 0.900, TO_DATE('03/02/2024', 'DD/MM/YYYY'));

INSERT INTO MEDICINE (REG_NO, MED_NAME, PRICE, EXP_DATE) VALUES
(28, 'Lipitor', 1.400, TO_DATE('12/03/2025', 'DD/MM/YYYY'));

INSERT INTO MEDICINE (REG_NO, MED_NAME, PRICE, EXP_DATE) VALUES
(29, 'Glucophage', 1.700, TO_DATE('19/07/2024', 'DD/MM/YYYY'));

SELECT * FROM MEDICINE;

-- Insert into table Doctor

INSERT INTO DOCTOR (DOC_ID, DNAME, GENDER, QUALIFICATION, JOB_SPECIFICATION, HOSP_NAME) VALUES
(1, 'Abdullah', 'M', 'MBBS', 'Dermatologist', 'Bahrain Defence Force Hospital');

INSERT INTO DOCTOR (DOC_ID, DNAME, GENDER, QUALIFICATION, JOB_SPECIFICATION, HOSP_NAME) VALUES
(2, 'Ahmed', 'M', 'Board Certified', 'Ophthalmologist', 'King Hamad University Hospital');

INSERT INTO DOCTOR (DOC_ID, DNAME, GENDER, QUALIFICATION, JOB_SPECIFICATION, HOSP_NAME) VALUES
(3, 'Ameera', 'F', 'MD', 'Pediatrician', 'Salamaniya Hospital');

INSERT INTO DOCTOR (DOC_ID, DNAME, GENDER, QUALIFICATION, JOB_SPECIFICATION, HOSP_NAME) VALUES
(4, 'Ali', 'M', 'BPT', 'Physiotherapist', 'Al-Hilal Hospital');

INSERT INTO DOCTOR (DOC_ID, DNAME, GENDER, QUALIFICATION, JOB_SPECIFICATION, HOSP_NAME) VALUES
(5, 'Carolina', 'F', 'MS', 'Surgeon', 'Mayo Clinic');

INSERT INTO DOCTOR (DOC_ID, DNAME, GENDER, QUALIFICATION, JOB_SPECIFICATION, HOSP_NAME) VALUES
(6, 'Sarah', 'F', 'MD', 'Anatomy', 'Emirates Hospital');

INSERT INTO DOCTOR (DOC_ID, DNAME, GENDER, QUALIFICATION, JOB_SPECIFICATION, HOSP_NAME) VALUES
(7, 'Qasim', 'M', 'MD', 'Radiologist', 'King Hamad University Hospital');

INSERT INTO DOCTOR (DOC_ID, DNAME, GENDER, QUALIFICATION, JOB_SPECIFICATION, HOSP_NAME) VALUES
(8, 'Fatema', 'F', 'Residency', 'Anesthetist', 'Salamaniya Hospital');

INSERT INTO DOCTOR (DOC_ID, DNAME, GENDER, QUALIFICATION, JOB_SPECIFICATION, HOSP_NAME) VALUES
(9, 'Khalid', 'M', 'MBBS', 'Psychiatrist', 'American Mission Hospital');

INSERT INTO DOCTOR (DOC_ID, DNAME, GENDER, QUALIFICATION, JOB_SPECIFICATION, HOSP_NAME) VALUES
(10, 'Amal', 'F', 'D.M.', 'Nephrologist', 'King Hamad University Hospital');

SELECT * FROM DOCTOR;
-- Insert into Nurse

INSERT INTO NURSE (NURSE_ID, NAME, GENDER, DOC_ID, HOSP_NAME) VALUES
(1, 'Sanaa', 'F', 2, 'King Hamad University Hospital');

INSERT INTO NURSE (NURSE_ID, NAME, GENDER, DOC_ID, HOSP_NAME) VALUES
(2, 'Kathy', 'F', 7, 'King Hamad University Hospital');

INSERT INTO NURSE (NURSE_ID, NAME, GENDER, DOC_ID, HOSP_NAME) VALUES
(3, 'Mary', 'F', 5, 'Mayo Clinic');

INSERT INTO NURSE (NURSE_ID, NAME, GENDER, DOC_ID, HOSP_NAME) VALUES
(4, 'Ibrahim', 'M', 8, 'Salamaniya Hospital');

INSERT INTO NURSE (NURSE_ID, NAME, GENDER, DOC_ID, HOSP_NAME) VALUES
(5, 'Anaya', 'F', 3, 'Salamaniya Hospital');

INSERT INTO NURSE (NURSE_ID, NAME, GENDER, DOC_ID, HOSP_NAME) VALUES
(6, 'Asha', 'F', 9, 'American Mission Hospital');

INSERT INTO NURSE (NURSE_ID, NAME, GENDER, DOC_ID, HOSP_NAME) VALUES
(7, 'Zainab', 'F', 1, 'Bahrain Defence Force Hospital');

INSERT INTO NURSE (NURSE_ID, NAME, GENDER, DOC_ID, HOSP_NAME) VALUES
(8, 'Zeshan', 'M', 10, 'King Hamad University Hospital');

INSERT INTO NURSE (NURSE_ID, NAME, GENDER, DOC_ID, HOSP_NAME) VALUES
(9, 'Adam', 'M', 4, 'Al-Hilal Hospital');

INSERT INTO NURSE (NURSE_ID, NAME, GENDER, DOC_ID, HOSP_NAME) VALUES
(10, 'Hawra', 'F', 6, 'Emirates Hospital');

SELECT *FROM NURSE;

-- Insert into Reception

INSERT INTO RECEPTION (REC_ID, TEL_NO, EMAIL, HOSP_NAME) VALUES
(41, '39123456', 'khuh@gmail.com', 'King Hamad University Hospital');

INSERT INTO RECEPTION (REC_ID, TEL_NO, EMAIL, HOSP_NAME) VALUES
(42, '39123456', 'khuh@gmail.com', 'King Hamad University Hospital');

INSERT INTO RECEPTION (REC_ID, TEL_NO, EMAIL, HOSP_NAME) VALUES
(43, '39456780', 'mayoclinic@facebook.com', 'Mayo Clinic');

INSERT INTO RECEPTION (REC_ID, TEL_NO, EMAIL, HOSP_NAME) VALUES
(44, '33456780', 'emirateshospital@yahoo.com', 'Emirates Hospital');

INSERT INTO RECEPTION (REC_ID, TEL_NO, EMAIL, HOSP_NAME) VALUES
(45, '33123456', 'bdf@yahoo.com', 'Bahrain Defence Force Hospital');

INSERT INTO RECEPTION (REC_ID, TEL_NO, EMAIL, HOSP_NAME) VALUES
(46, '33678901', 'alhilal@facebook.com', 'Al-Hilal Hospital');

INSERT INTO RECEPTION (REC_ID, TEL_NO, EMAIL, HOSP_NAME) VALUES
(47, '39678901', 'daralshifa@gmail.com', 'Dar Al Shifa Hospital');

INSERT INTO RECEPTION (REC_ID, TEL_NO, EMAIL, HOSP_NAME) VALUES
(48, '33912045', 'st.thomashospital@gmail.com', 'St Thomas'' Hospital London');

INSERT INTO RECEPTION (REC_ID, TEL_NO, EMAIL, HOSP_NAME) VALUES
(49, '39912045', 'kingfaisalshrc@yahoo.com', 'King Faisal Specialist Hospital Centre');

INSERT INTO RECEPTION (REC_ID, TEL_NO, EMAIL, HOSP_NAME) VALUES
(50, '39678901', 'daralshifa@gmail.com', 'Dar Al Shifa Hospital');

SELECT *FROM RECEPTION;
-- Insert into Patient

INSERT INTO PATIENT (SSN, FNAME, LNAME, AGE, GENDER, NURSE_ID, REC_ID) VALUES
(100000001, 'Sara', 'Majeed', 27, 'F', 7, 46);

INSERT INTO PATIENT (SSN, FNAME, LNAME, AGE, GENDER, NURSE_ID, REC_ID) VALUES
(100000002, 'Ahmed', 'Jamaal', 59, 'M', 3, 43);

INSERT INTO PATIENT (SSN, FNAME, LNAME, AGE, GENDER, NURSE_ID, REC_ID) VALUES
(100000003, 'Abdulla', 'Hameed', 45, 'M', 9, 48);

INSERT INTO PATIENT (SSN, FNAME, LNAME, AGE, GENDER, NURSE_ID, REC_ID) VALUES
(100000004, 'Mariam', 'Muhammad', 40, 'F', 1, 41);

INSERT INTO PATIENT (SSN, FNAME, LNAME, AGE, GENDER, NURSE_ID, REC_ID) VALUES
(100000005, 'Fatema', 'Hasan', 64, 'F', 6, 47);

INSERT INTO PATIENT (SSN, FNAME, LNAME, AGE, GENDER, NURSE_ID, REC_ID) VALUES
(100000006, 'Zainab', 'Abdulla', 55, 'F', 2, 49);

INSERT INTO PATIENT (SSN, FNAME, LNAME, AGE, GENDER, NURSE_ID, REC_ID) VALUES
(100000007, 'Khalil', 'Ibrahim', 35, 'M', 8, 44);

INSERT INTO PATIENT (SSN, FNAME, LNAME, AGE, GENDER, NURSE_ID, REC_ID) VALUES
(100000008, 'Alyaa', 'Husain', 57, 'F', 5, 42);

INSERT INTO PATIENT (SSN, FNAME, LNAME, AGE, GENDER, NURSE_ID, REC_ID) VALUES
(100000009, 'Khalid', 'Ahmed', 60, 'M', 4, 50);

INSERT INTO PATIENT (SSN, FNAME, LNAME, AGE, GENDER, NURSE_ID, REC_ID) VALUES
(100000010, 'Jawad', 'Ali', 20, 'M', 10, 45);

SELECT *FROM PATIENT;

-- Insert into Appointment

INSERT INTO APPOINTMENT (APPOINT_NO, APPOINT_DATE, APPOINT_TIME, REC_ID) VALUES
(1, TO_DATE('3/5/2022', 'DD/MM/YYYY'), TO_TIMESTAMP('07:05:03', 'HH24:MI:SS'), 45);

INSERT INTO APPOINTMENT (APPOINT_NO, APPOINT_DATE, APPOINT_TIME, REC_ID) VALUES
(2, TO_DATE('17/3/2022', 'DD/MM/YYYY'), TO_TIMESTAMP('13:30:00', 'HH24:MI:SS'), 49);

INSERT INTO APPOINTMENT (APPOINT_NO, APPOINT_DATE, APPOINT_TIME, REC_ID) VALUES
(3, TO_DATE('22/12/2022', 'DD/MM/YYYY'), TO_TIMESTAMP('09:45:00', 'HH24:MI:SS'), 44);

INSERT INTO APPOINTMENT (APPOINT_NO, APPOINT_DATE, APPOINT_TIME, REC_ID) VALUES
(4, TO_DATE('9/7/2022', 'DD/MM/YYYY'), TO_TIMESTAMP('17:20:00', 'HH24:MI:SS'), 48);

INSERT INTO APPOINTMENT (APPOINT_NO, APPOINT_DATE, APPOINT_TIME, REC_ID) VALUES
(5, TO_DATE('3/5/2022', 'DD/MM/YYYY'), TO_TIMESTAMP('12:15:00', 'HH24:MI:SS'), 41);

INSERT INTO APPOINTMENT (APPOINT_NO, APPOINT_DATE, APPOINT_TIME, REC_ID) VALUES
(6, TO_DATE('20/11/2022', 'DD/MM/YYYY'), TO_TIMESTAMP('08:05:00', 'HH24:MI:SS'), 47);

INSERT INTO APPOINTMENT (APPOINT_NO, APPOINT_DATE, APPOINT_TIME, REC_ID) VALUES
(7, TO_DATE('12/7/2022', 'DD/MM/YYYY'), TO_TIMESTAMP('15:40:00', 'HH24:MI:SS'), 42);

INSERT INTO APPOINTMENT (APPOINT_NO, APPOINT_DATE, APPOINT_TIME, REC_ID) VALUES
(8, TO_DATE('1/4/2022', 'DD/MM/YYYY'), TO_TIMESTAMP('14:00:00', 'HH24:MI:SS'), 50);

INSERT INTO APPOINTMENT (APPOINT_NO, APPOINT_DATE, APPOINT_TIME, REC_ID) VALUES
(9, TO_DATE('30/8/2022', 'DD/MM/YYYY'), TO_TIMESTAMP('10:25:00', 'HH24:MI:SS'), 43);

INSERT INTO APPOINTMENT (APPOINT_NO, APPOINT_DATE, APPOINT_TIME, REC_ID) VALUES
(10, TO_DATE('15/6/2022', 'DD/MM/YYYY'), TO_TIMESTAMP('16:50:00', 'HH24:MI:SS'), 46);

SELECT *FROM APPOINTMENT;

-- Insert into Diagnosis

INSERT INTO DIAGNOSIS (DIAGNOS_NO, ISSUE_DATE, TREATMENT, REMARKS, NURSE_ID, DOC_ID) VALUES
(31, TO_DATE('4/6/2022', 'DD/MM/YYYY'), 'Physiotherapy', 'Once a month', 4, 8);

INSERT INTO DIAGNOSIS (DIAGNOS_NO, ISSUE_DATE, TREATMENT, REMARKS, NURSE_ID, DOC_ID) VALUES
(32, TO_DATE('29/5/2022', 'DD/MM/YYYY'), 'Aromatherapy', 'Twice a week', 7, 1);

INSERT INTO DIAGNOSIS (DIAGNOS_NO, ISSUE_DATE, TREATMENT, REMARKS, NURSE_ID, DOC_ID) VALUES
(33, TO_DATE('18/6/2022', 'DD/MM/YYYY'), 'Cyrotherapy', 'Twice a month', 5, 3);

INSERT INTO DIAGNOSIS (DIAGNOS_NO, ISSUE_DATE, TREATMENT, REMARKS, NURSE_ID, DOC_ID) VALUES
(34, TO_DATE('7/7/2022', 'DD/MM/YYYY'), 'Phototherapy', 'Once a month', 10, 6);

INSERT INTO DIAGNOSIS (DIAGNOS_NO, ISSUE_DATE, TREATMENT, REMARKS, NURSE_ID, DOC_ID) VALUES
(35, TO_DATE('13/8/2022', 'DD/MM/YYYY'), 'Radiotherapy', 'Once in 3 months', 2, 7);

INSERT INTO DIAGNOSIS (DIAGNOS_NO, ISSUE_DATE, TREATMENT, REMARKS, NURSE_ID, DOC_ID) VALUES
(36, TO_DATE('3/12/2022', 'DD/MM/YYYY'), 'Immunotherapy', 'Once a month', 6, 9);

INSERT INTO DIAGNOSIS (DIAGNOS_NO, ISSUE_DATE, TREATMENT, REMARKS, NURSE_ID, DOC_ID) VALUES
(37, TO_DATE('4/7/2022', 'DD/MM/YYYY'), 'Monotherapy', 'Once a month', 1, 2);

INSERT INTO DIAGNOSIS (DIAGNOS_NO, ISSUE_DATE, TREATMENT, REMARKS, NURSE_ID, DOC_ID) VALUES
(38, TO_DATE('4/6/2022', 'DD/MM/YYYY'), 'Pharmacotherapy', 'Once a month', 8, 10);

INSERT INTO DIAGNOSIS (DIAGNOS_NO, ISSUE_DATE, TREATMENT, REMARKS, NURSE_ID, DOC_ID) VALUES
(39, TO_DATE('19/7/2022', 'DD/MM/YYYY'), 'Oxygen therapy', 'Once a week', 3, 5);

INSERT INTO DIAGNOSIS (DIAGNOS_NO, ISSUE_DATE, TREATMENT, REMARKS, NURSE_ID, DOC_ID) VALUES
(40, TO_DATE('25/6/2022', 'DD/MM/YYYY'), 'Gene therapy', 'Once a month', 9, 4);

SELECT *FROM DIAGNOSIS;
--Insert into Visit

INSERT INTO VISIT (VISIT_DATE, SSN, HOSP_NAME) VALUES
(TO_DATE('10/10/2021', 'DD/MM/YYYY'), 100000009, 'Dar Al Shifa Hospital');

INSERT INTO VISIT (VISIT_DATE, SSN, HOSP_NAME) VALUES
(TO_DATE('15/05/2020', 'DD/MM/YYYY'), 100000005, 'Dar Al Shifa Hospital');

INSERT INTO VISIT (VISIT_DATE, SSN, HOSP_NAME) VALUES
(TO_DATE('30/01/2022', 'DD/MM/YYYY'), 100000006, 'King Faisal Specialist Hospital Centre');

INSERT INTO VISIT (VISIT_DATE, SSN, HOSP_NAME) VALUES
(TO_DATE('04/06/2019', 'DD/MM/YYYY'), 100000002, 'Mayo Clinic');

INSERT INTO VISIT (VISIT_DATE, SSN, HOSP_NAME) VALUES
(TO_DATE('24/12/2020', 'DD/MM/YYYY'), 100000010, 'Bahrain Defence Force Hospital');

INSERT INTO VISIT (VISIT_DATE, SSN, HOSP_NAME) VALUES
(TO_DATE('11/11/2020', 'DD/MM/YYYY'), 100000004, 'King Hamad University Hospital');

INSERT INTO VISIT (VISIT_DATE, SSN, HOSP_NAME) VALUES
(TO_DATE('06/02/2021', 'DD/MM/YYYY'), 100000001, 'Al-Hilal Hospital');

INSERT INTO VISIT (VISIT_DATE, SSN, HOSP_NAME) VALUES
(TO_DATE('21/04/2022', 'DD/MM/YYYY'), 100000003, 'St Thomas'' Hospital London');

INSERT INTO VISIT (VISIT_DATE, SSN, HOSP_NAME) VALUES
(TO_DATE('19/04/2022', 'DD/MM/YYYY'), 100000007, 'Emirates Hospital');

INSERT INTO VISIT (VISIT_DATE, SSN, HOSP_NAME) VALUES
(TO_DATE('07/02/2021', 'DD/MM/YYYY'), 100000008, 'King Hamad University Hospital');


-- Insert into Purchase

INSERT INTO PURCHASE (SSN, REG_NO) VALUES (100000007, 020);
INSERT INTO PURCHASE (SSN, REG_NO) VALUES (null, 023);
INSERT INTO PURCHASE (SSN, REG_NO) VALUES (100000004, 028);
INSERT INTO PURCHASE (SSN, REG_NO) VALUES (100000009, 025);
INSERT INTO PURCHASE (SSN, REG_NO) VALUES (100000003, 021);
INSERT INTO PURCHASE (SSN, REG_NO) VALUES (100000006, 029);
INSERT INTO PURCHASE (SSN, REG_NO) VALUES (100000008, 022);
INSERT INTO PURCHASE (SSN, REG_NO) VALUES (100000002, 027);
INSERT INTO PURCHASE (SSN, REG_NO) VALUES (100000007, 024);
INSERT INTO PURCHASE (SSN, REG_NO) VALUES (null, 026);

-- Insert into Examine

INSERT INTO EXAMINE (SSN, DOC_ID) VALUES (100000004,1);
INSERT INTO EXAMINE (SSN, DOC_ID) VALUES (100000006,2);
INSERT INTO EXAMINE (SSN, DOC_ID) VALUES (100000002,3);
INSERT INTO EXAMINE (SSN, DOC_ID) VALUES (100000009,4);
INSERT INTO EXAMINE (SSN, DOC_ID) VALUES (100000008,5);
INSERT INTO EXAMINE (SSN, DOC_ID) VALUES (100000005,6);
INSERT INTO EXAMINE (SSN, DOC_ID) VALUES (100000001,7);
INSERT INTO EXAMINE (SSN, DOC_ID) VALUES (100000007,8);
INSERT INTO EXAMINE (SSN, DOC_ID) VALUES (100000003,9);
INSERT INTO EXAMINE (SSN, DOC_ID) VALUES (100000010,10);

-- Insert into MEDICINE_COUNTRY

INSERT INTO MEDICINE_COUNTRY (MAN_COUNTRY, REG_NO) VALUES ('United States', 20);
INSERT INTO MEDICINE_COUNTRY (MAN_COUNTRY, REG_NO) VALUES ('Australia', 21);
INSERT INTO MEDICINE_COUNTRY (MAN_COUNTRY, REG_NO) VALUES ('United States', 22);
INSERT INTO MEDICINE_COUNTRY (MAN_COUNTRY, REG_NO) VALUES ('Germany', 23);
INSERT INTO MEDICINE_COUNTRY (MAN_COUNTRY, REG_NO) VALUES ('United Kingdom', 24);
INSERT INTO MEDICINE_COUNTRY (MAN_COUNTRY, REG_NO) VALUES ('United Kingdom', 25);
INSERT INTO MEDICINE_COUNTRY (MAN_COUNTRY, REG_NO) VALUES ('Kingdom of Saudi Arabia', 26);
INSERT INTO MEDICINE_COUNTRY (MAN_COUNTRY, REG_NO) VALUES ('Germany', 27);
INSERT INTO MEDICINE_COUNTRY (MAN_COUNTRY, REG_NO) VALUES ('Switzerland', 28);
INSERT INTO MEDICINE_COUNTRY (MAN_COUNTRY, REG_NO) VALUES ('Germany', 29);


-- PL/SQL Queries

-- 1. Merge the Tables “EXAMINE” and “VISIT” with “DIAGNOSIS” to reduce redundancy. (Hint: Match Doc_ID, SSN and VISIT_DATE/ISSUE_DATE).


CREATE TABLE CONSULTATION
(
    CONSULTATION_NO NUMBER PRIMARY KEY,
    VISIT_DATE DATE,
    SSN NUMBER,
    DOC_ID NUMBER,
    TREATMENT VARCHAR2(80),
    REMARKS VARCHAR2(80)
);

INSERT INTO CONSULTATION (CONSULTATION_NO, SSN, DOC_ID, TREATMENT, REMARKS)
SELECT ROWNUM, E.SSN, E.DOC_ID, D.TREATMENT, D.REMARKS
FROM EXAMINE E
JOIN DIAGNOSIS D ON E.SSN = D.SSN AND E.DOC_ID = D.DOC_ID;

-- Merge data from VISIT
INSERT INTO CONSULTATION (CONSULTATION_NO, VISIT_DATE, SSN, DOC_ID)
SELECT ROWNUM, V.VISIT_DATE, V.SSN, E.DOC_ID
FROM VISIT V
JOIN EXAMINE E ON V.SSN = E.SSN;

Select * from CONSULTATION;

--2
DECLARE
  CURSOR SeniorCitizenPatients IS
    SELECT P.FNAME, P.LNAME, D.DNAME, N.NAME, DG.TREATMENT
    FROM PATIENT P
    JOIN DOCTOR D ON P.NURSE_ID = D.DOC_ID
    JOIN NURSE N ON P.NURSE_ID = N.NURSE_ID
    JOIN DIAGNOSIS DG ON P.NURSE_ID = DG.NURSE_ID
    WHERE P.AGE > 55;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Senior Citizen Patients:');
  FOR PatientData IN SeniorCitizenPatients LOOP
    DBMS_OUTPUT.PUT_LINE('Patient Name: ' || PatientData.FNAME || ' ' || PatientData.LNAME);
    DBMS_OUTPUT.PUT_LINE('Doctor Name: ' || PatientData.DNAME);
    DBMS_OUTPUT.PUT_LINE('Nurse Name: ' || PatientData.NAME);
    DBMS_OUTPUT.PUT_LINE('Recommended Treatment: ' || PatientData.TREATMENT);
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
  END LOOP;
END;
/

SELECT * FROM PATIENT;


-- 3. Write a PL/SQL code to find the last names of patients who were under the care of female nurses at the “Mayo Clinic”.
CREATE OR REPLACE PROCEDURE PATIENTS_UNDER_FEMALE_NURSES AS
BEGIN
    FOR rec IN (
        SELECT DISTINCT p.LNAME
        FROM PATIENT p
        JOIN NURSE n ON p.NURSE_ID = n.NURSE_ID
        JOIN RECEPTION r ON n.HOSP_NAME = r.HOSP_NAME
        WHERE n.GENDER = 'F' AND r.HOSP_NAME = 'Mayo Clinic'
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Last Name of Patient: ' || rec.LNAME);
    END LOOP;
END;
/

SET SERVEROUTPUT ON;

EXEC PATIENTS_UNDER_FEMALE_NURSES;

-- 4.Write a PL/SQL code to find the name of the hospital having the highest number of “BPT”.

CREATE OR REPLACE PROCEDURE HOSPITAL_WITH_HIGHEST_BPT AS
    v_max_count NUMBER;
    v_hospital_name VARCHAR2(30);
BEGIN
    SELECT COUNT(DOC_ID), HOSP_NAME
    INTO v_max_count, v_hospital_name
    FROM DOCTOR 
    WHERE HOSP_NAME=(
        SELECT d.HOSP_NAME 
        FROM DOCTOR d
        WHERE d.QUALIFICATION = 'BPT'
    )
    GROUP BY hosp_name;
    
    DBMS_OUTPUT.PUT_LINE('Hospital with Highest Number of "BPT" Doctors:');
    DBMS_OUTPUT.PUT_LINE('Hospital Name: ' || v_hospital_name);
    DBMS_OUTPUT.PUT_LINE('Number of "BPT" Doctors: ' || v_max_count);
END;
/

SET SERVEROUTPUT ON;

EXEC HOSPITAL_WITH_HIGHEST_BPT;



-- 5.Create a procedure to check the validity of email IDs
CREATE OR REPLACE PROCEDURE VALID_EMAIL_CHECK AS
    v_email VARCHAR2(100);
BEGIN
   
    FOR email_rec IN (SELECT DISTINCT EMAIL FROM RECEPTION) LOOP
        v_email := email_rec.EMAIL;
        
        
        IF REGEXP_LIKE(v_email, '(@gmail\.com|@yahoo\.com|@outlook\.com|@iCloud\.com)$', 'i') THEN
            
            DBMS_OUTPUT.PUT_LINE('Valid Email: ' || v_email);
            IF REGEXP_LIKE(v_email, '^[\w\.-]+@[a-z0-9]+([._-][a-z0-9]+)*$', 'i') THEN
                DBMS_OUTPUT.PUT_LINE('Valid Email: ' || v_email);
            END IF;
        END IF;
    END LOOP;
END;
/

SET SERVEROUTPUT ON;

EXEC VALID_EMAIL_CHECK;


--6. Create a PL/SQL block to count patients who have visited Dr. "Ali"
DECLARE
    v_doctor_name VARCHAR2(30) := 'Ali';
    v_patient_count NUMBER;
BEGIN

    SELECT COUNT(DISTINCT P.SSN)
    INTO v_patient_count
    FROM PATIENT P
    JOIN EXAMINE E ON P.SSN = E.SSN
    JOIN DOCTOR D ON E.DOC_ID = D.DOC_ID
    WHERE D.DNAME = v_doctor_name;
    

    DBMS_OUTPUT.PUT_LINE('Number of patients visited Dr. ' || v_doctor_name || ': ' || v_patient_count);
END;
/

SET SERVEROUTPUT ON;

BEGIN
    NULL;
END;
/

-- 7. 
DECLARE
    v_hospital_name VARCHAR2(80);
    v_new_doc_id VARCHAR2(80);
BEGIN
    -- Looping through each doctor record
    FOR doctor_rec IN (SELECT DOC_ID, HOSP_NAME FROM DOCTOR)
    LOOP
       
        v_hospital_name := SUBSTR(REGEXP_REPLACE(doctor_rec.HOSP_NAME, '[^a-zA-Z]', ''), 1, 4);

       
        v_new_doc_id := RPAD(v_hospital_name, 4, ' ') || '_' || LPAD(doctor_rec.DOC_ID, 4, '0');

     
        UPDATE DOCTOR
        SET DOC_ID = v_new_doc_id
        WHERE DOC_ID = doctor_rec.DOC_ID;

       
        UPDATE NURSE
        SET DOC_ID = v_new_doc_id
        WHERE DOC_ID = doctor_rec.DOC_ID;

        UPDATE EXAMINE
        SET DOC_ID = v_new_doc_id
        WHERE DOC_ID = doctor_rec.DOC_ID;

        
        COMMIT;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Doc_IDs have been updated.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/



--8 

CREATE OR REPLACE PROCEDURE CalculateMedicineExpenditure(p_ssn NUMBER) IS
    v_total_expenditure NUMBER := 0;

BEGIN
   
    SELECT SUM(M.PRICE)
    INTO v_total_expenditure
    FROM PURCHASE P
    JOIN MEDICINE M ON P.REG_NO = M.REG_NO
    WHERE P.SSN = p_ssn;

   
    DBMS_OUTPUT.PUT_LINE('Total expenditure on medicines for SSN ' || p_ssn || ': ' || v_total_expenditure);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No data found for SSN ' || p_ssn);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END CalculateMedicineExpenditure;
/


BEGIN
    CalculateMedicineExpenditure(100000002);
END;
/

--9
DECLARE
    CURSOR female_patients_cur IS
        SELECT P.FNAME, P.LNAME, P.AGE, P.NURSE_ID
        FROM PATIENT P
        JOIN APPOINTMENT A ON P.REC_ID = A.REC_ID
        WHERE P.GENDER = 'F' AND TO_CHAR(A.APPOINT_DATE, 'MM') > '07';
BEGIN
    FOR female_patient_rec IN female_patients_cur
    LOOP
        DBMS_OUTPUT.PUT_LINE('First Name: ' || female_patient_rec.FNAME ||
            ', Last Name: ' || female_patient_rec.LNAME ||
            ', Age: ' || female_patient_rec.AGE ||
            ', Nurse ID: ' || female_patient_rec.NURSE_ID);
    END LOOP; -- Added the missing LOOP here
END;
/


-- 10.

DECLARE
    CURSOR doctor_cursor IS
        SELECT DISTINCT DOC_ID
        FROM DOCTOR;

    doctor_id NUMBER;
BEGIN
    FOR doctor_rec IN doctor_cursor
    LOOP
        doctor_id := doctor_rec.DOC_ID;
        DBMS_OUTPUT.PUT_LINE('Doctor ID: ' || doctor_id);

        FOR medicine_country_rec IN (SELECT MC.MAN_COUNTRY, COUNT(*) AS PRESCRIPTION_COUNT
                                     FROM MEDICINE_COUNTRY MC
                                     JOIN PURCHASE P ON MC.REG_NO = P.REG_NO
                                     JOIN EXAMINE E ON P.SSN = E.SSN
                                     WHERE E.DOC_ID = doctor_id
                                     GROUP BY MC.MAN_COUNTRY
                                     ORDER BY PRESCRIPTION_COUNT DESC)
        LOOP
            DBMS_OUTPUT.PUT_LINE('    Medicine Country: ' || medicine_country_rec.MAN_COUNTRY ||
                ', Prescription Count: ' || medicine_country_rec.PRESCRIPTION_COUNT);
            EXIT; -- Exit the loop after the first (most prescribed) medicine country
        END LOOP;
    END LOOP;
END;
/

--11.

CREATE OR REPLACE TRIGGER doctor_details_trigger
AFTER INSERT OR UPDATE ON DOCTOR
FOR EACH ROW
DECLARE
BEGIN
    DBMS_OUTPUT.PUT_LINE('Doctor Details -');
    DBMS_OUTPUT.PUT_LINE('Doctor ID: ' || :new.DOC_ID);
    DBMS_OUTPUT.PUT_LINE('Name: ' || :new.DNAME);
    DBMS_OUTPUT.PUT_LINE('Gender: ' || :new.GENDER);
    DBMS_OUTPUT.PUT_LINE('Qualification: ' || :new.QUALIFICATION);
    DBMS_OUTPUT.PUT_LINE('Job Specification: ' || :new.JOB_SPECIFICATION);
    DBMS_OUTPUT.PUT_LINE('Hospital Name: ' || :new.HOSP_NAME);
    DBMS_OUTPUT.PUT_LINE('Timestamp: ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'));
END;
/

SET SERVEROUTPUT ON;

--12.

INSERT INTO MEDICINE (REG_NO, MED_NAME, PRICE, EXP_DATE)
VALUES (30, 'Diazepam', 2.500, TO_DATE('2023-12-31', 'YYYY-MM-DD'));

INSERT INTO MEDICINE (REG_NO, MED_NAME, PRICE, EXP_DATE)
VALUES (31, 'Lorazepam', 2.800, TO_DATE('2023-12-31', 'YYYY-MM-DD'));

-- PL/SQL code to insert new records in Medicine_Country for medicines not listed with 'Unknown' as Man_Country
DECLARE
    v_med_name MEDICINE.MED_NAME%TYPE;
    v_man_country MEDICINE_COUNTRY.MAN_COUNTRY%TYPE := 'Unknown';
    v_med_count NUMBER := 0;
BEGIN
    -- Open a cursor to fetch medicine names not in Medicine_Country
    FOR med_rec IN (SELECT DISTINCT MED_NAME FROM MEDICINE WHERE MED_NAME NOT IN (SELECT MED_NAME FROM MEDICINE_COUNTRY))
    LOOP
        -- Insert the new record in Medicine_Country
        INSERT INTO MEDICINE_COUNTRY (REG_NO, MAN_COUNTRY)
        SELECT REG_NO, v_man_country
        FROM MEDICINE
        WHERE MED_NAME = med_rec.MED_NAME;
        v_med_count := v_med_count + 1;
    END LOOP;

    -- Output the number of new records inserted
    DBMS_OUTPUT.PUT_LINE(v_med_count || ' new records inserted into Medicine_Country.');
END;
/