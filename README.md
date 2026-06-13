COMPANY: CODTECH IT SOLUTIONS

NAME: SOLOMON SHYAM RAJ

INTERN ID: CTIS9521

DURATION: 6 WEEKS

MENTOR: NEELA SANTOSH

# Task 3 — Database Migration (Hospital Management System)
Overview
The goal of this task is to perform a complete database migration from one database to another using MySQL Workbench. A Hospital Management System database is used as the source, and all its data is migrated to a new improved database with better structure, stronger constraints, and better data validation rules. The entire migration is done step by step to make sure no data is lost and everything matches perfectly between the source and the target database.

What This Task Does
The task is divided into six clear steps. Each step has a specific purpose and together they complete the full migration process from start to finish.

Step 1 — Create the Source Database
The first step creates the original hospital database called hospital_db in MySQL Workbench. This database contains five tables that store all the important information of a hospital. The tables are created in a specific order because some tables depend on others. For example, the Doctors table is created before the Departments table because Departments needs to know which doctor is the head of each department.
The five tables are Doctors, Departments, Patients, Appointments, and Medical Records. Each table has its own columns with appropriate data types. For example, salary is stored as DECIMAL to handle decimal numbers, dates are stored as DATE type, and phone numbers are stored as VARCHAR since they are not used for calculations.

Step 2 — Insert Sample Data
Once the tables are created, sample data is inserted into all five tables. Five doctors are added with their specializations, experience, and salaries. Five departments are created and each department is linked to its head doctor. Six patients are added with their personal details including blood group and address. Six appointments are recorded showing which patient visited which doctor on which date. Five medical records are created showing the diagnosis, treatment, prescription, and bill amount for each completed appointment.
This sample data makes the migration realistic and meaningful because there is actual data to move from one database to another.

Step 3 — Record Row Counts Before Migration
Before moving any data, the total number of rows in each table is counted and saved. This is a very important step because after the migration is complete, these numbers will be compared again to make sure nothing was lost during the process. The total comes to 27 rows across all five tables. If the count after migration also shows 27 rows, it confirms the migration was successful.

<img width="226" height="117" alt="image" src="https://github.com/user-attachments/assets/b009f449-7c93-42f9-ac29-9b63df81d83f" />


Step 4 — Create the Target Database with Improved Schema
A new database called hospital_db_new is created. This is the destination where all the data will be moved. The tables in this new database are not just copies of the original — they are improved versions with stronger rules and better data protection.
The improvements made in the new schema include adding CHECK constraints to make sure salaries and bill amounts cannot be negative, adding ON DELETE CASCADE so that related records are automatically removed when a parent record is deleted, adding ON DELETE SET NULL so that if a head doctor is removed the department still exists but the head doctor field becomes empty, and making more columns NOT NULL to prevent incomplete data from being saved. These improvements make the new database more reliable and safer than the original.

Step 5 — Migrate the Data
This is the actual migration step. Data is moved from hospital_db to hospital_db_new using the INSERT INTO SELECT method. This is the standard MySQL Workbench way of copying data from one database to another without needing any terminal commands. Each table is migrated one by one in the correct order to respect foreign key relationships. Doctors are migrated first, then Departments, then Patients, then Appointments, and finally Medical Records.

Step 6 — Post Migration Verification
After the migration is complete, eight verification checks are run to confirm that everything migrated correctly and no data was lost or corrupted.
The first check counts the rows in all five tables and compares them with the pre-migration counts is zero. 
The second check looks for orphaned appointments — appointments that have no matching patient or doctor is zero. 
The third check looks for orphaned medical records — records with no matching appointment is zero.
The fourth check looks for NULL values in important columns like patient name and doctor name is zero.
The fifth check confirms there are no negative salary values is zero. 
The sixth check confirms there are no negative bill amounts is zero.
The seventh check adds up all bill amounts and confirms the total matches the source database exactly at 9800 rupees.

<img width="113" height="49" alt="image" src="https://github.com/user-attachments/assets/f0c60633-efcc-401d-922d-baa134c7db82" />


The eighth check picks the first three patients and compares them with the source to confirm the data is identical.

<img width="397" height="102" alt="image" src="https://github.com/user-attachments/assets/a111771a-cb99-48f8-878c-b6f60839bee2" />


All eight checks are expected to return zero errors, confirming a clean and complete migration.

