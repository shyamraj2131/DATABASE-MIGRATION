
CREATE DATABASE IF NOT EXISTS hospital_db;
USE hospital_db;

-- ------------------------------------------------------------
-- Doctors
-- (Created first because Departments depends on it)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Doctors (
    Doctor_ID       INT PRIMARY KEY AUTO_INCREMENT,
    Full_Name       VARCHAR(100) NOT NULL,
    Specialization  VARCHAR(100) NOT NULL,
    Phone           VARCHAR(15)  UNIQUE NOT NULL,
    Email           VARCHAR(100),
    Experience_Yrs  INT,
    Salary          DECIMAL(10,2)
);

-- ------------------------------------------------------------
-- Departments
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Departments (
    Department_ID   INT PRIMARY KEY AUTO_INCREMENT,
    Dept_Name       VARCHAR(100) NOT NULL UNIQUE,
    Head_Doctor_ID  INT,
    Location        VARCHAR(100),
    FOREIGN KEY (Head_Doctor_ID) REFERENCES Doctors(Doctor_ID)
);

-- ------------------------------------------------------------
-- Patients
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Patients (
    Patient_ID      INT PRIMARY KEY AUTO_INCREMENT,
    Full_Name       VARCHAR(100) NOT NULL,
    Date_of_Birth   DATE NOT NULL,
    Gender          VARCHAR(10),
    Phone           VARCHAR(15) UNIQUE NOT NULL,
    Email           VARCHAR(100),
    Blood_Group     VARCHAR(5),
    Address         VARCHAR(200),
    Registered_On   DATE DEFAULT (CURRENT_DATE)
);

-- ------------------------------------------------------------
-- Appointments
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Appointments (
    Appointment_ID  INT PRIMARY KEY AUTO_INCREMENT,
    Patient_ID      INT NOT NULL,
    Doctor_ID       INT NOT NULL,
    Dept_ID         INT NOT NULL,
    Appt_Date       DATE NOT NULL,
    Appt_Time       TIME NOT NULL,
    Status          VARCHAR(20) DEFAULT 'Scheduled',
    Notes           VARCHAR(300),
    FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID),
    FOREIGN KEY (Doctor_ID)  REFERENCES Doctors(Doctor_ID),
    FOREIGN KEY (Dept_ID)    REFERENCES Departments(Department_ID)
);

-- ------------------------------------------------------------
-- Medical_Records
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Medical_Records (
    Record_ID       INT PRIMARY KEY AUTO_INCREMENT,
    Appointment_ID  INT NOT NULL,
    Patient_ID      INT NOT NULL,
    Doctor_ID       INT NOT NULL,
    Diagnosis       VARCHAR(300) NOT NULL,
    Treatment       VARCHAR(300),
    Prescription    VARCHAR(300),
    Bill_Amount     DECIMAL(10,2) DEFAULT 0.00,
    Record_Date     DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (Appointment_ID) REFERENCES Appointments(Appointment_ID),
    FOREIGN KEY (Patient_ID)     REFERENCES Patients(Patient_ID),
    FOREIGN KEY (Doctor_ID)      REFERENCES Doctors(Doctor_ID)
);


-- ============================================================
-- INSERT SAMPLE DATA
-- ============================================================

-- Insert Doctors
INSERT INTO Doctors (Full_Name, Specialization, Phone, Email, Experience_Yrs, Salary) VALUES
('Dr. Rajesh Kumar',  'Cardiology',       '9876543210', 'rajesh@hospital.com',  15, 150000.00),
('Dr. Priya Sharma',  'Neurology',        '9876543211', 'priya@hospital.com',   10, 130000.00),
('Dr. Anil Mehta',    'Orthopedics',      '9876543212', 'anil@hospital.com',    12, 120000.00),
('Dr. Sunita Rao',    'Pediatrics',       '9876543213', 'sunita@hospital.com',   8, 110000.00),
('Dr. Vikram Singh',  'General Medicine', '9876543214', 'vikram@hospital.com',   5,  90000.00);

-- Insert Departments
INSERT INTO Departments (Dept_Name, Head_Doctor_ID, Location) VALUES
('Cardiology',        1, 'Block A, Floor 2'),
('Neurology',         2, 'Block B, Floor 3'),
('Orthopedics',       3, 'Block A, Floor 1'),
('Pediatrics',        4, 'Block C, Floor 1'),
('General Medicine',  5, 'Block D, Floor 1');

-- Insert Patients
INSERT INTO Patients (Full_Name, Date_of_Birth, Gender, Phone, Email, Blood_Group, Address) VALUES
('Amit Verma',    '1990-04-15', 'Male',   '8800001111', 'amit@mail.com',    'O+',  'Chennai'),
('Deepa Nair',    '1985-07-22', 'Female', '8800002222', 'deepa@mail.com',   'A+',  'Hyderabad'),
('Ravi Shankar',  '2000-11-10', 'Male',   '8800003333', 'ravi@mail.com',    'B+',  'Bangalore'),
('Meena Pillai',  '1975-03-05', 'Female', '8800004444', 'meena@mail.com',   'AB+', 'Mumbai'),
('Karthik Raja',  '1995-09-18', 'Male',   '8800005555', 'karthik@mail.com', 'O-',  'Chennai'),
('Lakshmi Devi',  '1988-12-30', 'Female', '8800006666', 'lakshmi@mail.com', 'A-',  'Hyderabad');

-- Insert Appointments
INSERT INTO Appointments (Patient_ID, Doctor_ID, Dept_ID, Appt_Date, Appt_Time, Status, Notes) VALUES
(1, 1, 1, '2024-03-01', '09:00:00', 'Completed', 'Chest pain complaint'),
(2, 2, 2, '2024-03-02', '10:30:00', 'Completed', 'Severe headache'),
(3, 3, 3, '2024-03-03', '11:00:00', 'Completed', 'Knee injury'),
(4, 4, 4, '2024-03-04', '09:30:00', 'Completed', 'Child fever checkup'),
(5, 5, 5, '2024-03-05', '14:00:00', 'Completed', 'Routine checkup'),
(6, 1, 1, '2024-03-06', '15:00:00', 'Scheduled', 'Follow-up visit');

-- Insert Medical Records
INSERT INTO Medical_Records (Appointment_ID, Patient_ID, Doctor_ID, Diagnosis, Treatment, Prescription, Bill_Amount) VALUES
(1, 1, 1, 'Mild Angina',           'Medication & Rest',   'Aspirin 75mg, Atorvastatin', 2500.00),
(2, 2, 2, 'Migraine',              'Pain Management',     'Sumatriptan 50mg',           1800.00),
(3, 3, 3, 'Ligament Tear',         'Physiotherapy',       'Ibuprofen 400mg',            3500.00),
(4, 4, 4, 'Viral Fever',           'Hydration & Rest',    'Paracetamol 250mg',          1200.00),
(5, 5, 5, 'General Health Check',  'No Treatment Needed', 'Multivitamins',               800.00);


-- ============================================================
-- PRE-MIGRATION ROW COUNTS
-- Save these numbers — they will be checked after migration
-- ============================================================

SELECT 'Patients'        AS Table_Name, COUNT(*) AS Row_Count FROM Patients
UNION ALL
SELECT 'Doctors',         COUNT(*) FROM Doctors
UNION ALL
SELECT 'Departments',     COUNT(*) FROM Departments
UNION ALL
SELECT 'Appointments',    COUNT(*) FROM Appointments
UNION ALL
SELECT 'Medical_Records', COUNT(*) FROM Medical_Records;


-- ============================================================
-- CREATE MIGRATION TARGET DATABASE (hospital_db_new)
-- ============================================================

CREATE DATABASE IF NOT EXISTS hospital_db_new;
USE hospital_db_new;

-- ------------------------------------------------------------
-- Recreate all tables in new database
-- with improved structure (migration improvements)
-- ------------------------------------------------------------

-- Changes made during migration:
-- 1. Added CHECK constraints for data validation
-- 2. Added ON DELETE CASCADE to all foreign keys
-- 3. Renamed columns for clarity where needed
-- 4. Added NOT NULL to more critical columns
-- 5. Added DEFAULT values where missing

CREATE TABLE IF NOT EXISTS Doctors (
    Doctor_ID       INT PRIMARY KEY AUTO_INCREMENT,
    Full_Name       VARCHAR(100) NOT NULL,
    Specialization  VARCHAR(100) NOT NULL,
    Phone           VARCHAR(15)  UNIQUE NOT NULL,
    Email           VARCHAR(100) NOT NULL,
    Experience_Yrs  INT CHECK (Experience_Yrs >= 0),
    Salary          DECIMAL(10,2) CHECK (Salary >= 0)
);

CREATE TABLE IF NOT EXISTS Departments (
    Department_ID   INT PRIMARY KEY AUTO_INCREMENT,
    Dept_Name       VARCHAR(100) NOT NULL UNIQUE,
    Head_Doctor_ID  INT,
    Location        VARCHAR(100) NOT NULL,
    FOREIGN KEY (Head_Doctor_ID)
        REFERENCES Doctors(Doctor_ID)
        ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS Patients (
    Patient_ID      INT PRIMARY KEY AUTO_INCREMENT,
    Full_Name       VARCHAR(100) NOT NULL,
    Date_of_Birth   DATE NOT NULL,
    Gender          VARCHAR(10) NOT NULL,
    Phone           VARCHAR(15) UNIQUE NOT NULL,
    Email           VARCHAR(100),
    Blood_Group     VARCHAR(5) NOT NULL,
    Address         VARCHAR(200) NOT NULL,
    Registered_On   DATE DEFAULT (CURRENT_DATE)
);

CREATE TABLE IF NOT EXISTS Appointments (
    Appointment_ID  INT PRIMARY KEY AUTO_INCREMENT,
    Patient_ID      INT NOT NULL,
    Doctor_ID       INT NOT NULL,
    Dept_ID         INT NOT NULL,
    Appt_Date       DATE NOT NULL,
    Appt_Time       TIME NOT NULL,
    Status          VARCHAR(20) DEFAULT 'Scheduled',
    Notes           VARCHAR(300),
    FOREIGN KEY (Patient_ID)
        REFERENCES Patients(Patient_ID)
        ON DELETE CASCADE,
    FOREIGN KEY (Doctor_ID)
        REFERENCES Doctors(Doctor_ID)
        ON DELETE CASCADE,
    FOREIGN KEY (Dept_ID)
        REFERENCES Departments(Department_ID)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Medical_Records (
    Record_ID       INT PRIMARY KEY AUTO_INCREMENT,
    Appointment_ID  INT NOT NULL,
    Patient_ID      INT NOT NULL,
    Doctor_ID       INT NOT NULL,
    Diagnosis       VARCHAR(300) NOT NULL,
    Treatment       VARCHAR(300) NOT NULL,
    Prescription    VARCHAR(300),
    Bill_Amount     DECIMAL(10,2) DEFAULT 0.00 CHECK (Bill_Amount >= 0),
    Record_Date     DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (Appointment_ID)
        REFERENCES Appointments(Appointment_ID)
        ON DELETE CASCADE,
    FOREIGN KEY (Patient_ID)
        REFERENCES Patients(Patient_ID)
        ON DELETE CASCADE,
    FOREIGN KEY (Doctor_ID)
        REFERENCES Doctors(Doctor_ID)
        ON DELETE CASCADE
);

-- ============================================================
-- MIGRATE DATA FROM hospital_db TO hospital_db_new
-- Using INSERT INTO ... SELECT (MySQL migration method)
-- ============================================================

-- Migrate Doctors
INSERT INTO hospital_db_new.Doctors
SELECT * FROM hospital_db.Doctors;

-- Migrate Departments
INSERT INTO hospital_db_new.Departments
SELECT * FROM hospital_db.Departments;

-- Migrate Patients
INSERT INTO hospital_db_new.Patients
SELECT * FROM hospital_db.Patients;

-- Migrate Appointments
INSERT INTO hospital_db_new.Appointments
SELECT * FROM hospital_db.Appointments;

-- Migrate Medical_Records
INSERT INTO hospital_db_new.Medical_Records
SELECT * FROM hospital_db.Medical_Records;


-- ============================================================
-- POST-MIGRATION VERIFICATION
-- ============================================================

USE hospital_db_new;

SELECT 'Patients'        AS Table_Name, COUNT(*) AS Row_Count FROM Patients
UNION ALL
SELECT 'Doctors',         COUNT(*) FROM Doctors
UNION ALL
SELECT 'Departments',     COUNT(*) FROM Departments
UNION ALL
SELECT 'Appointments',    COUNT(*) FROM Appointments
UNION ALL
SELECT 'Medical_Records', COUNT(*) FROM Medical_Records;

SELECT COUNT(*) AS Orphaned_Appointments
FROM Appointments a
WHERE NOT EXISTS (SELECT 1 FROM Patients p WHERE p.Patient_ID = a.Patient_ID)
   OR NOT EXISTS (SELECT 1 FROM Doctors  d WHERE d.Doctor_ID  = a.Doctor_ID);


SELECT COUNT(*) AS Orphaned_Records
FROM Medical_Records m
WHERE NOT EXISTS (SELECT 1 FROM Appointments a WHERE a.Appointment_ID = m.Appointment_ID);

SELECT
    COUNT(*) AS Null_Patient_Names
FROM Patients
WHERE Full_Name IS NULL;

SELECT
    COUNT(*) AS Null_Doctor_Names
FROM Doctors
WHERE Full_Name IS NULL;

SELECT COUNT(*) AS Invalid_Salaries
FROM Doctors
WHERE Salary < 0;


SELECT COUNT(*) AS Invalid_Bills
FROM Medical_Records
WHERE Bill_Amount < 0;


SELECT SUM(Bill_Amount) AS Total_Bills FROM Medical_Records;

SELECT Patient_ID, Full_Name, Gender, Blood_Group, Address
FROM Patients
ORDER BY Patient_ID
LIMIT 3;


