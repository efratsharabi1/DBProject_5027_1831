# Volunteers Organization Database - Yedidim

## Efrat Sharabi
## Elishava Shnur
[השם שלך]  
[שם נוסף אם יש]  
---

## Table of Contents
- Phase 1: Design and Build the Database
  - Introduction
  - System Screens (AI Studio)
  - ERD (Entity-Relationship Diagram)
  - DSD (Data Structure Diagram)
  - Design Decisions
  - SQL Scripts
  - Data Generation
  - Backup

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

📸 [הכניסי כאן צילומי מסך]

🔗 AI Studio Link:  
[הכניסי כאן לינק]

---

## ERD (Entity-Relationship Diagram)
<img width="1480" height="590" alt="image" src="https://github.com/user-attachments/assets/b241b520-a143-4ec9-817f-ee8ed91212c2" />

---

## DSD (Data Structure Diagram)

📸 [הכניסי תמונת DSD]

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

### Create Tables Script
📜 View: `createTables.sql`

### Insert Data Script
📜 View: `insertTables.sql`

### Drop Tables Script
📜 View: `dropTables.sql`

### Select All Script
📜 View: `selectAll.sql`

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

(To be completed in the next phase)
