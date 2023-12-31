CREATE DATABASE Hospital;
USE Hospital;

CREATE TABLE HOSPITAL
(
HOSP_NAME VARCHAR(50) PRIMARY KEY,
COUNTRY VARCHAR(30),
ADDRESS VARCHAR(100)
);

CREATE TABLE MEDICINE
(
REG_NO INT PRIMARY KEY,
MED_NAME VARCHAR(20) NOT NULL,
PRICE FLOAT,
EXP_DATE DATE
);

CREATE TABLE DOCTOR
(
DOC_ID INT PRIMARY KEY,
DNAME VARCHAR(30),
GENDER CHAR(1),
QUALIFICATION VARCHAR(30),
JOB_SPECIFICATION VARCHAR(30),
HOSP_NAME VARCHAR(30),
FOREIGN KEY (HOSP_NAME) REFERENCES HOSPITAL(HOSP_NAME)
);

CREATE TABLE NURSE
(
NURSE_ID INT PRIMARY KEY,
NAME VARCHAR(30),
GENDER CHAR(1),
DOC_ID INT,
HOSP_NAME VARCHAR(50),
FOREIGN KEY (DOC_ID) REFERENCES DOCTOR (DOC_ID),
FOREIGN KEY (HOSP_NAME) REFERENCES HOSPITAL (HOSP_NAME)
);

CREATE TABLE RECEPTION
(
REC_ID INT PRIMARY KEY,
TEL_NO VARCHAR(20) NOT NULL,
EMAIL VARCHAR(30),
HOSP_NAME VARCHAR(50),
FOREIGN KEY (HOSP_NAME) REFERENCES HOSPITAL (HOSP_NAME)
);


CREATE TABLE PATIENT
(
SSN INT PRIMARY KEY,
FNAME VARCHAR(30),
LNAME VARCHAR(30),
AGE INTEGER,
GENDER CHAR(1),
NURSE_ID INT,
REC_ID INT(30),
FOREIGN KEY (NURSE_ID) REFERENCES NURSE(NURSE_ID),
FOREIGN KEY (REC_ID) REFERENCES RECEPTION(REC_ID)
);


CREATE TABLE APPOINTMENT
(
APPOINT_NO INT PRIMARY KEY,
APPOINT_DATE DATE NOT NULL,
APPOINT_TIME VARCHAR(255),
REC_ID INT,
FOREIGN KEY (REC_ID) REFERENCES RECEPTION (REC_ID)
);


CREATE TABLE DIAGNOSIS
(
DIAGNOS_NO int PRIMARY KEY,
ISSUE_DATE DATE,
TREATMENT VARCHAR(30),
REMARKS VARCHAR(20),
NURSE_ID INT,
DOC_ID INT,
FOREIGN KEY (NURSE_ID) REFERENCES NURSE (NURSE_ID),
FOREIGN KEY (DOC_ID) REFERENCES DOCTOR (DOC_ID)
);


CREATE TABLE VISIT
(
VISIT_DATE DATE,
SSN INT,
HOSP_NAME VARCHAR(50),
FOREIGN KEY (SSN) REFERENCES PATIENT (SSN),
FOREIGN KEY (HOSP_NAME) REFERENCES HOSPITAL (HOSP_NAME)
);


CREATE TABLE PURCHASE
(
REG_NO INT,
SSN INT,
FOREIGN KEY (SSN) REFERENCES PATIENT (SSN),
FOREIGN KEY (REG_NO) REFERENCES MEDICINE (REG_NO)
);


CREATE TABLE EXAMINE
(
DOC_ID INT,
SSN INT,
FOREIGN KEY (SSN) REFERENCES PATIENT (SSN),
FOREIGN KEY (DOC_ID) REFERENCES DOCTOR (DOC_ID)
);

CREATE TABLE MEDICINE_COUNTRY
(
MAN_COUNTRY VARCHAR(25),
REG_NO INT,
FOREIGN KEY (REG_NO) REFERENCES MEDICINE (REG_NO)
);


INSERT INTO HOSPITAL VALUES ('King Hamad University Hospital', 'Kingdom of Bahrain', 'Sheikh Isa bin Salman Bridge, Al Sayh, Busaiteen, Bahrain');
INSERT INTO HOSPITAL VALUES ('Mayo Clinic', 'United States', '4500 San Pablo Road, US');
INSERT INTO HOSPITAL VALUES ('Bahrain Defence Force Hospital', 'Kingdom of Bahrain', 'Waly Alahed Avenue, West Riffa, Bahrain');
INSERT INTO HOSPITAL VALUES ('Salamaniya Hospital', 'Kindgom of Bahrain', 'Salmaniya Medical Complex, Manama, Bahrain');
INSERT INTO HOSPITAL VALUES ('St Thomas'' Hospital London', 'United Kingdom', 'Westminster Bridge Rd, London');
INSERT INTO HOSPITAL VALUES ('King Faisal Specialist Hospital & Research Centre', 'Kingdom of Saudi Arabia', 'Al Mathar Ash Shamali, Riyadh 11564, Saudi Arabia');
INSERT INTO HOSPITAL VALUES ('Al-Hilal Hospital', 'Kingdom of Bahrain', 'Al-Hilal Hospital, Muharraq, Bahrain');
INSERT INTO HOSPITAL VALUES ('Emirates Hospital', 'United Arab Emirates', 'Jumeirah Beach Rd, Dubai, UAE');
INSERT INTO HOSPITAL VALUES ('American Mission Hospital', 'Kingdom of Bahrain', 'Sheikh Essa Road, Manama, Bahrain');
INSERT INTO HOSPITAL VALUES ('Dar Al Shifa Hospital', 'Kuwait', 'Beirut Street, Hawally, Kuwait');

SELECT * FROM Hospital;


INSERT INTO MEDICINE VALUES (020, 'Adol Syrup', 0.300, '2023-05-15');
INSERT INTO MEDICINE VALUES (021, 'Amoxil Capsules', 0.700, '2023-03-10');
INSERT INTO MEDICINE VALUES (022, 'Aspirin', 1.000, '2023-12-09');
INSERT INTO MEDICINE VALUES (023, 'Bonjela Gel', 0.400, '2024-09-23');
INSERT INTO MEDICINE VALUES (024, 'Paracetamol', 1.200, '2024-05-17');
INSERT INTO MEDICINE VALUES (025, 'Atorvastatin', 1.500, '2023-06-15');
INSERT INTO MEDICINE VALUES (026, 'Coversyl', 1.000, '2023-05-15');
INSERT INTO MEDICINE VALUES (027, 'Diamicron', 0.900, '2024-02-03');
INSERT INTO MEDICINE VALUES (028, 'Lipitor', 1.400, '2025-03-12');
INSERT INTO MEDICINE VALUES (029, 'Glucophage', 1.700, '2024-07-19');

SELECT * FROM medicine;


INSERT INTO DOCTOR VALUES (1, 'Abdullah', 'M', 'MBBS', 'Dermatologist', 'Bahrain Defence Force Hospital');
INSERT INTO DOCTOR VALUES (2, 'Ahmed', 'M', 'Board Certified', 'Opthalmologist', 'King Hamad University Hospital');
INSERT INTO DOCTOR VALUES (3, 'Ameera', 'F', 'MD', 'Pediatrician', 'Salamaniya Hospital');
INSERT INTO DOCTOR VALUES (4, 'Ali', 'M', 'BPT', 'Physiotherapist', 'Al-Hilal Hospital');
INSERT INTO DOCTOR VALUES (5, 'Carolina', 'F', 'MS', 'Surgeon', 'Mayo Clinic');
INSERT INTO DOCTOR VALUES (6, 'Sarah', 'F', 'MD', 'Anatomy', 'Emirates Hospital');
INSERT INTO DOCTOR VALUES (7, 'Qasim', 'M', 'MD', 'Radiologist', 'King Hamad University Hospital');
INSERT INTO DOCTOR VALUES (8, 'Fatema', 'F', 'Residency', 'Anesthologist', 'Salamaniya Hospital');
INSERT INTO DOCTOR VALUES (9, 'Khalid', 'M', 'MBBS', 'Psychiatrist', 'American Mission Hospital');
INSERT INTO DOCTOR VALUES (10, 'Amal', 'F', 'D.M.', 'Nephrologist', 'King Hamad University Hospital');

SELECT * FROM doctor
ORDER BY doc_id;


INSERT INTO NURSE VALUES (01, 'Sanaa', 'F', 2, 'King Hamad University Hospital');
INSERT INTO NURSE VALUES (02, 'Kathy', 'F', 7, 'King Hamad University Hospital');
INSERT INTO NURSE VALUES (03, 'Mary', 'F', 5, 'Mayo Clinic');
INSERT INTO NURSE VALUES (04, 'Ibrahim', 'M', 8, 'Salamaniya Hospital');
INSERT INTO NURSE VALUES (05, 'Anaya', 'F', 3, 'Salamaniya Hospital');
INSERT INTO NURSE VALUES (06, 'Asha', 'F', 9, 'American Mission Hospital');
INSERT INTO NURSE VALUES (07, 'Zainab', 'F', 1, 'Bahrain Defence Force Hospital');
INSERT INTO NURSE VALUES (08, 'Zeshan', 'M', 10, 'King Hamad University Hospital');
INSERT INTO NURSE VALUES (09, 'Adam', 'M', 4, 'Al-Hilal Hospital');
INSERT INTO NURSE VALUES (10, 'Hawra', 'F', 6, 'Emirates Hospital');

SELECT * FROM nurse;


INSERT INTO RECEPTION VALUES (041, 39123456, 'khuh@gmail.com', 'King Hamad University Hospital');
INSERT INTO RECEPTION VALUES (042, 39123456, 'khuh@gmail.com', 'King Hamad University Hospital');
INSERT INTO RECEPTION VALUES (043, 39456780, 'mayoclinic@facebook.com', 'Mayo Clinic');
INSERT INTO RECEPTION VALUES (044, 33456780, 'emirateshospital@yahoo.com', 'Emirates Hospital');
INSERT INTO RECEPTION VALUES (045, 33123456, 'bdf@yahoo.com', 'Bahrain Defence Force Hospital');
INSERT INTO RECEPTION VALUES (046, 33678901, 'alhilal@facebook.com', 'Al-Hilal Hospital');
INSERT INTO RECEPTION VALUES (047, 39678901, 'daralshifa@gmail.com', 'Dar Al Shifa Hospital');
INSERT INTO RECEPTION VALUES (048, 33912045, 'st.thomashospital@gmail.com', 'St Thomas'' Hospital London');
INSERT INTO RECEPTION VALUES (049, 39912045, 'kingfaisalshrc@yahoo.com', 'King Faisal Specialist Hospital & Research Centre');
INSERT INTO RECEPTION VALUES (050, 39678901, 'daralshifa@gmail.com', 'Dar Al Shifa Hospital');

SELECT * FROM reception;


INSERT INTO PATIENT VALUES (100000001, 'Sara', 'Majeed', 27, 'F', 07, 046);
INSERT INTO PATIENT VALUES (100000002, 'Ahmed', 'Jamaal', 59, 'M', 03, 043);
INSERT INTO PATIENT VALUES (100000003, 'Abdulla', 'Hameed', 45, 'M', 09, 048);
INSERT INTO PATIENT VALUES (100000004, 'Mariam', 'Muhammad', 40, 'F', 01, 041);
INSERT INTO PATIENT VALUES (100000005, 'Fatema', 'Hasan', 64, 'F', 06, 047);
INSERT INTO PATIENT VALUES (100000006, 'Zainab', 'Abdulla', 55, 'F', 02, 049);
INSERT INTO PATIENT VALUES (100000007, 'Khalil', 'Ibrahim', 35, 'M', 08, 044);
INSERT INTO PATIENT VALUES (100000008, 'Alyaa', 'Husain', 57, 'F', 05, 042);
INSERT INTO PATIENT VALUES (100000009, 'Khalid', 'Ahmed', 60, 'M', 04, 050);
INSERT INTO PATIENT VALUES (100000010, 'Jawad', 'Ali', 20, 'M', 10, 045);

SELECT * FROM patient;  


INSERT INTO APPOINTMENT VALUES (0001, '2022-05-03', '07:05:03', 045);
INSERT INTO APPOINTMENT VALUES (0002, '2022-03-17','13:30:00', 049);
INSERT INTO APPOINTMENT VALUES (0003, '2022-12-22', '09:45:00', 044);
INSERT INTO APPOINTMENT VALUES (0004, '2022-07-09', '17:20:00', 048);
INSERT INTO APPOINTMENT VALUES (0005, '2022-05-03', '12:15:00', 041);
INSERT INTO APPOINTMENT VALUES (0006, '2022-11-20', '08:05:00', 047);
INSERT INTO APPOINTMENT VALUES (0007, '2022-07-12', '15:40:00', 042);
INSERT INTO APPOINTMENT VALUES (0008, '2022-04-01', '14:00:00', 050);
INSERT INTO APPOINTMENT VALUES (0009, '2022-08-30', '10:25:00', 043);
INSERT INTO APPOINTMENT VALUES (0010, '2022-06-15', '16:50:00', 046);

SELECT * FROM appointment;


INSERT INTO VISIT VALUES ('2021-10-10', 100000009, 'Dar Al Shifa Hospital');
INSERT INTO VISIT VALUES ('2020-05-15', 100000005, 'Dar Al Shifa Hospital');
INSERT INTO VISIT VALUES ('2022-01-30', 100000006, 'King Faisal Specialist Hospital & Research Centre');
INSERT INTO VISIT VALUES ('2019-06-04', 100000002, 'Mayo Clinic');
INSERT INTO VISIT VALUES ('2020-12-24', 100000010, 'Bahrain Defence Force Hospital');
INSERT INTO VISIT VALUES ('2020-11-11', 100000004, 'King Hamad University Hospital');
INSERT INTO VISIT VALUES ('2021-02-06', 100000001, 'Al-Hilal Hospital');
INSERT INTO VISIT VALUES ('2022-04-21', 100000003, 'St Thomas'' Hospital London');
INSERT INTO VISIT VALUES ('2022-04-19', 100000007, 'Emirates Hospital');
INSERT INTO VISIT VALUES ('2021-02-07', 100000008, 'King Hamad University Hospital');

SELECT * FROM visit;

INSERT INTO DIAGNOSIS VALUES (31, '2022-6-4', 'Physiotherapy', 'Once a month', 04, 8);
INSERT INTO DIAGNOSIS VALUES (34, '2022-7-7', 'Phototherapy', 'Once a month', 10, 6);
INSERT INTO DIAGNOSIS VALUES (37, '2022-7-4', 'Monotherapy', 'Once a month', 01, 2);
INSERT INTO DIAGNOSIS VALUES (38, '2022-6-4', 'Pharmacotherapy', 'Once a month', 08, 10);
INSERT INTO DIAGNOSIS VALUES (39, '2022-07-19', 'Oxygen therapy', 'Once a week', 03, 5);
INSERT INTO DIAGNOSIS VALUES (40, '2022-6-25', 'Gene therapy', 'Once a month', 09, 4);
INSERT INTO DIAGNOSIS VALUES (32, '2022-5-29', 'Aromatherapy', 'Twice a week', 07, 1);
INSERT INTO DIAGNOSIS VALUES (33, '2022-6-18', 'Cyrotherapy', 'Twice a month', 05, 3);
INSERT INTO DIAGNOSIS VALUES (35, '2022-8-13', 'Radiotherapy', 'Once in 3 months', 02, 7);
INSERT INTO DIAGNOSIS VALUES (36, '2022-12-3', 'Immunotherapy', 'Once a month', 06, 9);

SELECT * FROM diagnosis;


INSERT INTO PURCHASE VALUES (020, 100000007);
INSERT INTO PURCHASE VALUES (023, NULL);
INSERT INTO PURCHASE VALUES (028, 100000004);
INSERT INTO PURCHASE VALUES (025, 100000009);
INSERT INTO PURCHASE VALUES (021, 100000003);
INSERT INTO PURCHASE VALUES (029, 100000006);
INSERT INTO PURCHASE VALUES (022, 100000008);
INSERT INTO PURCHASE VALUES (027, 100000002);
INSERT INTO PURCHASE VALUES (024, 100000007);
INSERT INTO PURCHASE VALUES (026, NULL);

SELECT * FROM purchase;


INSERT INTO EXAMINE VALUES (01, 100000004);
INSERT INTO EXAMINE VALUES (02, 100000006);
INSERT INTO EXAMINE VALUES (03, 100000002);
INSERT INTO EXAMINE VALUES (04, 100000009);
INSERT INTO EXAMINE VALUES (05, 100000008);
INSERT INTO EXAMINE VALUES (06, 100000005);
INSERT INTO EXAMINE VALUES (07, 100000001);
INSERT INTO EXAMINE VALUES (08, 100000007);
INSERT INTO EXAMINE VALUES (09, 100000003);
INSERT INTO EXAMINE VALUES (10, 100000010);

SELECT * FROM examine;


INSERT INTO MEDICINE_COUNTRY VALUES ('United States', 020);
INSERT INTO MEDICINE_COUNTRY VALUES ('Australia', 021);
INSERT INTO MEDICINE_COUNTRY VALUES ('United States', 022);
INSERT INTO MEDICINE_COUNTRY VALUES ('Germany', 023);
INSERT INTO MEDICINE_COUNTRY VALUES ('United Kingdom', 024);
INSERT INTO MEDICINE_COUNTRY VALUES ('United Kingdom', 025);
INSERT INTO MEDICINE_COUNTRY VALUES ('Kingdom of Saudi Arabia', 026);
INSERT INTO MEDICINE_COUNTRY VALUES ('Germany', 027);
INSERT INTO MEDICINE_COUNTRY VALUES ('Switzerland', 028);
INSERT INTO MEDICINE_COUNTRY VALUES ('Germany', 029);

SELECT * FROM medicine_country;


