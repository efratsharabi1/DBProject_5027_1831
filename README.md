# Volunteers Organization Database - Yedidim

## Efrat Sharabi
## Elishava Katzin
---

## Table of Contents

- [Phase 1: Design and Build the Database](#phase-1-design-and-build-the-database)
  - [Introduction](#introduction)
  - [System Screens (AI Studio)](#system-screens-ai-studio)
  - [ERD (Entity-Relationship Diagram)](#erd-entity-relationship-diagram)
  - [DSD (Data Structure Diagram)](#dsd-data-structure-diagram)
  - [Design Decisions](#design-decisions)
  - [SQL Scripts](#sql-scripts)
  - [Data](#data)
  - [Backup](#backup)

- [Phase 2: SQL And Constraints](#phase-2-SQL-And-Constraints)
---

# Phase 1: Design and Build the Database

## Introduction

This project presents a database system designed for managing volunteers in the **Yedidim organization**, which provides non-medical emergency roadside assistance.

The system is designed to efficiently manage:
- Volunteers and their personal details
- Emergency calls and their status
- Skills and categories of volunteers
- Training sessions and scheduling
- Availability of volunteers
- Relationships between volunteers and calls

---

## Purpose of the Database

The system aims to:

- Manage emergency calls such as:
  - Flat tire assistance
  - Locked vehicles
  - Elevator rescue
  - Child locked in a car
  - Home door lock issues
  - Search and rescue

- Assign volunteers based on:
  - Skills
  - Availability
  - Location

- Maintain structured relationships between:
  - Volunteers and their skills
  - Volunteers and emergency calls
  - Volunteers and training sessions

- Store critical data for efficient and fast response

---

## Potential Use Cases

- **Dispatch Center**  
  Assign volunteers to emergency calls quickly.

- **Volunteers**  
  View assigned calls and training sessions.

- **Management**  
  Track activity, response times, and volunteer performance.

- **System Administration**  
  Maintain accurate and structured data for operational efficiency.

---

## System Screens (AI Studio)

Below are the system screens designed using Google AI Studio:

<img width="1388" height="827" alt="image" src="https://github.com/user-attachments/assets/b9ecce92-8bab-40a7-9b74-ef314591de02" />
<img width="604" height="848" alt="image" src="https://github.com/user-attachments/assets/9b68f15a-937d-4b7d-8bc0-731177d31510" />
<img width="1349" height="803" alt="image" src="https://github.com/user-attachments/assets/d4c85841-7457-4715-9a29-daa0f6e51743" />
<img width="1413" height="764" alt="image" src="https://github.com/user-attachments/assets/23b7c7e2-cd78-4e8f-9d10-7b31df02fd31" />
<img width="733" height="774" alt="image" src="https://github.com/user-attachments/assets/0ab54641-f42b-4643-ae45-439f91115eab" />
<img width="1351" height="777" alt="image" src="https://github.com/user-attachments/assets/874dfc2f-15c2-483f-968b-b57a6a5c27c4" />

🔗 AI Studio Link:  
https://ai.studio/apps/e4a2e6ab-45ce-4670-983d-868dfc48ea7d
---

## ERD (Entity-Relationship Diagram)
<img width="1480" height="590" alt="image" src="https://github.com/user-attachments/assets/b241b520-a143-4ec9-817f-ee8ed91212c2" />

---

## DSD (Data Structure Diagram)
<img width="1139" height="636" alt="image" src="https://github.com/user-attachments/assets/56ad16e1-0053-48cb-bcf2-0f6f636b2db1" />

---

## Design Decisions

During the database design, several important decisions were made:

- Separation between **TYPE** (call types) and **CATEGORY** (skill categories)
- Use of **many-to-many relationships** via linking tables:
  - VOLUNTEER_SKILL
  - VOLUNTEER_CALL
  - VOLUNTEER_TRAINING
- Use of **CHECK constraints** to ensure valid data:
  - Status values (Open, Closed, InProgress)
  - Valid categories and types
  - Logical date constraints
- Use of **UNIQUE constraints** to prevent duplicates
- Use of **composite primary keys** where necessary

These decisions ensure:
- Data consistency
- Data integrity
- Efficient querying

---

## SQL Scripts

Provide the following SQL scripts:

- **Create Tables Script** – The SQL script for creating the database tables is available in the repository:  
📜 [View CreateTable.sql](Phase1/scripts/CreateTable.sql)

- **Insert Data Script** – The SQL script for inserting data into the database tables is available in the repository:  
📜 [View InsertTable.sql](Phase1/scripts/InsertTable.sql)

- **Drop Tables Script** – The SQL script for dropping all tables is available in the repository:  
📜 [View DropTable.sql](Phase1/scripts/DropTable.sql)

- **Select All Data Script** – The SQL script for selecting all data from the tables is available in the repository:  
📜 [View SelectAll.sql](Phase1/scripts/SelectAll.sql)

---

## Data

### 1. Mockaroo (CSV)

**Entering a data to call table**

- call id scope 1-500 📄 View [call_MOCK_DATA.csv](Phase1/mockData/call_MOCK_DATA.csv)
- Type_ID values in scope 1-6
- Status values: Open / Closed / InProgress
- Call_Time generated in format HH:mm
- Description values limited to valid length
<img width="1600" height="618" alt="image" src="https://github.com/user-attachments/assets/209f4814-08e3-4f0f-9d9b-de01ae3e23f2" />
<img width="782" height="358" alt="image" src="https://github.com/user-attachments/assets/ec46be0a-ce38-4fb9-9b11-0cc4cf652bec" />
<img width="1324" height="676" alt="image" src="https://github.com/user-attachments/assets/39e4cb70-a91b-4e1d-9a62-25630217aa47" />


**Entering a data to skill table**

- skill id scope 1-10 📄 View [skill_MOCK_DATA.csv](Phase1/mockData/skill_MOCK_DATA.csv)
- Difficulty_Level values between 1-5
- Requires_Certificate values Y/N
<img width="1497" height="534" alt="image" src="https://github.com/user-attachments/assets/ce125177-5084-4811-a70f-18638f510e02" />
<img width="771" height="341" alt="image" src="https://github.com/user-attachments/assets/170cca3b-702a-4bd9-90a1-187e239f4145" />
<img width="916" height="442" alt="image" src="https://github.com/user-attachments/assets/e3de391b-128e-4113-afee-cd23df88cb3a" />


**Entering a data to volunteer table**

- volunteer id scope 1-100 📄 View [volunteer_MOCK_DATA.csv](Phase1/mockData/volunteer_MOCK_DATA.csv)
- Phone values generated uniquely
- Email values generated uniquely
- Birthday values before current date
- recruitment_date values after Birthday and before current date
- Is_Active values: Y / N
<img width="1643" height="614" alt="image" src="https://github.com/user-attachments/assets/a63eee39-939e-4abe-8f98-8744525f8a9a" />
<img width="812" height="347" alt="image" src="https://github.com/user-attachments/assets/189b4601-2979-4595-ac23-e08f6a7d2eb4" />
<img width="1493" height="654" alt="image" src="https://github.com/user-attachments/assets/0fdd69a6-3a12-4731-85d1-966a0ca950a6" />

---

### 2. Python

**Entering a data to relationship tables using Python**

Python was used to insert a large amount of valid data into relationship tables using the `psycopg2` library.

- Data was inserted into:
  - `VOLUNTEER_SKILL`
  - `VOLUNTEER_CALL`
  - `VOLUNTEER_TRAINING`

- Random values were generated only from existing IDs in the database:
  - Volunteer_ID values in scope 1-20
  - Skill_ID values in scope 1-15
  - Call_ID values in scope 1-20
  - Training_ID values in scope 1-15

- The script inserted data while preserving:
  - Primary Key constraints
  - Foreign Key constraints

- Duplicate combinations were prevented using:
  - `ON CONFLICT DO NOTHING`

- The inserted data was generated by the file: 📄 View [generate_relationships.py](Phase1/Python/generate_relationships.py)

<img width="141" height="101" alt="image" src="https://github.com/user-attachments/assets/13bc9b32-897d-47ab-ae6b-627ca176db4f" />
<img width="163" height="132" alt="image" src="https://github.com/user-attachments/assets/968d87c6-f310-44af-8858-9ba3c397319d" />
<img width="139" height="100" alt="image" src="https://github.com/user-attachments/assets/b467491c-edd0-4722-8fe9-1137226492e5" />

---

### 3. Manual SQL Insert

**Entering a data manually into selected tables**

- Data was inserted manually into the following tables:
  - `TYPE`
  - `CATAGORY`
  - `TRAINING`
  - `AVAILABILITY`
  - `SCHEDULED`
  - `SKILL_CATEGORY`

- SQL insert script used: 📄 View [insertTables.sql](Phase1/scripts/InsertTable.sql)

- Tables were filled according to constraints:
  - valid foreign keys
  - valid time ranges
  - predefined values where required

- The manual method demonstrates correct SQL usage and full control over the data
<img width="164" height="102" alt="image" src="https://github.com/user-attachments/assets/58d95be6-9ca5-435a-9bdc-0d43226b960d" />
<img width="150" height="103" alt="image" src="https://github.com/user-attachments/assets/54959937-ee38-4daa-a489-10d9c361659e" />


---

## Backup

A full backup of the database was created using pgAdmin.

Backup files are stored with date and time.
<img width="895" height="706" alt="image" src="https://github.com/user-attachments/assets/37e564b4-efba-46ef-a8bd-ad7506443fb1" />
<img width="1179" height="693" alt="image" src="https://github.com/user-attachments/assets/969ec63d-0470-490c-87bd-9f65bfcbcf7e" />

---

# Phase 2: SQL And Constraints
