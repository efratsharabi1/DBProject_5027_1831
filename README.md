# Volunteers Organization Database - Yedidim

## Efrat Sharabi
## Elishava Shnur
---

## Table of Contents

- [Phase 1: Design and Build the Database](#phase-1-design-and-build-the-database)
  - [Introduction](#introduction)
  - [System Screens (AI Studio)](#system-screens-ai-studio)
  - [ERD (Entity-Relationship Diagram)](#erd-entity-relationship-diagram)
  - [DSD (Data Structure Diagram)](#dsd-data-structure-diagram)
  - [Design Decisions](#design-decisions)
  - [SQL Scripts](#sql-scripts)
  - [Data Generation](#data-generation)
  - [Backup](#backup)

- [Phase 2: Integration](#phase-2-integration)
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
📜 [View createTables.sql](createTables.sql)

- **Insert Data Script** – The SQL script for inserting data into the database tables is available in the repository:  
📜 [View insertTables.sql](insertTables.sql)

- **Drop Tables Script** – The SQL script for dropping all tables is available in the repository:  
📜 [View dropTables.sql](dropTables.sql)

- **Select All Data Script** – The SQL script for selecting all data from the tables is available in the repository:  
📜 [View selectAll.sql](selectAll.sql)

---

## Data Generation

Three different methods were used to populate the database:

---

### 1. Manual Insert (SQL)

Data was inserted manually using SQL commands.

📸 [צילום מסך של INSERT ידני]

---

### 2. Mockaroo (CSV / SQL)

Mockaroo was used to generate large datasets:
- CALL table (20,000 rows)
- Additional tables (500+ rows)

📸 [צילום מסך של Mockaroo]

---

### 3. CSV Import

CSV files were imported into the database using pgAdmin.

📸 [צילום מסך של Import]

---

### Data Volume Requirements

- Each table contains at least **500 records**
- Two tables contain at least **20,000 records**

---

## Backup

A full backup of the database was created using pgAdmin.

Backup files are stored with date and time.

📸 [צילום מסך של Backup]

📸 [צילום מסך של Restore]

---

# Phase 2: Integration
