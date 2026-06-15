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
  - [Backup (phase 1)](#backup-(phase-1))

- [Phase 2: SQL And Constraints](#phase-2-SQL-And-Constraints)
  - [Queries](#queries)
  - [Update Queries](#update-queries)
  - [Delete Queries](#delete-queries)
  - [Rollback and Commit](#rollback-and-commit)
  - [Constraints](#constraints)
  - [Indexes](#indexes)
  - [Backup (phase 2)](#backup-(phase-2))

- [Phase 3: Integration and Views](#phase-3-integration-and-views)
  - [Our System ERD](#our-system-erd)
  - [Second Team ERD](#second-team-erd)
  - [Integrated ERD](#integrated-erd)
  - [Integration Design Decisions](#integration-design-decisions)
  - [Integrate SQL](#integrate-SQL)
  - [View SQL](#View-SQL)
  - [Backup (phase 3)](#backup-(phase-3))

- [Phase 4: PL/pgSQL Programs](#phase-4-PL/pgSQL-Programs)
  - [Main Program 1](#Main-Program-1)
  - [Main Program 2](#Main-Program-2)
  - [Backup (phase 4)](#backup-(phase-4))
    
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

## Backup (phase 1)

A full backup of the database was created using pgAdmin.

Backup files are stored with date and time.
<img width="895" height="706" alt="image" src="https://github.com/user-attachments/assets/37e564b4-efba-46ef-a8bd-ad7506443fb1" />
<img width="1179" height="693" alt="image" src="https://github.com/user-attachments/assets/969ec63d-0470-490c-87bd-9f65bfcbcf7e" />

---

# Phase 2: SQL And Constraints

## Queries

### Query 1 – Active Volunteers With High Difficulty Skills

#### Description

This query returns all active volunteers who have at least one skill with the highest difficulty level (5).

The purpose of this query is to help the dispatch center identify highly skilled volunteers who are suitable for handling complex emergency cases.

---

#### Query 1A – Using JOIN

```sql
SELECT DISTINCT
    v.Volunteer_ID,
    v.First_Name,
    v.Last_Name,
    v.Phone,
    v.City
FROM VOLUNTEER v
JOIN VOLUNTEER_SKILL vs
    ON v.Volunteer_ID = vs.Volunteer_ID
JOIN SKILL s
    ON vs.Skill_ID = s.Skill_ID
WHERE v.Is_Active = 'Y'
  AND s.Difficulty_Level = 5
ORDER BY v.Last_Name, v.First_Name;
```

**Execution Screenshot:**  
<img src="Phase2/screenshots/query1a_run.png" width="700"/>

**Result Screenshot:**  
![Query 1A Result](Phase2/screenshots/query1a_result.png)

---

#### Query 1B – Using EXISTS

```sql
SELECT
    v.Volunteer_ID,
    v.First_Name,
    v.Last_Name,
    v.Phone,
    v.City
FROM VOLUNTEER v
WHERE v.Is_Active = 'Y'
  AND EXISTS (
      SELECT 1
      FROM VOLUNTEER_SKILL vs
      JOIN SKILL s
          ON vs.Skill_ID = s.Skill_ID
      WHERE vs.Volunteer_ID = v.Volunteer_ID
        AND s.Difficulty_Level = 5
  )
ORDER BY v.Last_Name, v.First_Name;
```

**Execution Screenshot:**  
<img src="Phase2/screenshots/query1b_run.png" width="700"/>

**Result Screenshot:**  
<img src="Phase2/screenshots/query1b_result.png" width="700"/>

---

#### Efficiency Explanation

Both queries return the same result.

The `JOIN` query combines multiple tables and may produce duplicate rows, which requires using `DISTINCT`.

The `EXISTS` query only checks whether a matching record exists, and stops searching as soon as one is found.

Therefore, the `EXISTS` query is more efficient in this case.
---

### Query 2 – Number of Calls Per Active Volunteer

#### Description

This query returns the number of calls handled by each active volunteer.

The purpose of this query is to allow the management to track volunteer activity and evaluate performance based on the number of calls handled.

---

#### Query 2A – Using JOIN and GROUP BY

```sql
SELECT
    v.Volunteer_ID,
    v.First_Name,
    v.Last_Name,
    v.City,
    COUNT(vc.Call_ID) AS Total_Calls
FROM VOLUNTEER v
JOIN VOLUNTEER_CALL vc
    ON v.Volunteer_ID = vc.Volunteer_ID
WHERE v.Is_Active = 'Y'
GROUP BY
    v.Volunteer_ID,
    v.First_Name,
    v.Last_Name,
    v.City
ORDER BY Total_Calls DESC;
```

**Execution Screenshot:**  
<img src="Phase2/screenshots/query2a_run.png" width="700"/>

**Result Screenshot:**  
<img src="Phase2/screenshots/query2a_result.png" width="700"/>

---

#### Query 2B – Using Subquery

```sql
SELECT
    v.Volunteer_ID,
    v.First_Name,
    v.Last_Name,
    v.City,
    (
        SELECT COUNT(*)
        FROM VOLUNTEER_CALL vc
        WHERE vc.Volunteer_ID = v.Volunteer_ID
    ) AS Total_Calls
FROM VOLUNTEER v
WHERE v.Is_Active = 'Y'
  AND (
        SELECT COUNT(*)
        FROM VOLUNTEER_CALL vc
        WHERE vc.Volunteer_ID = v.Volunteer_ID
      ) > 0
ORDER BY Total_Calls DESC;
```

**Execution Screenshot:**  
<img src="Phase2/screenshots/query2b_run.png" width="700"/>

**Result Screenshot:**  
<img src="Phase2/screenshots/query2b_result.png" width="700"/>

---

#### Efficiency Explanation

Both queries return the number of calls handled by each active volunteer.

The JOIN with GROUP BY query is usually more efficient because it joins the tables once and aggregates the results in a single operation.

The subquery version may execute the COUNT operation separately for each volunteer, and the same subquery appears more than once, which can increase execution time.

Therefore, the JOIN and GROUP BY approach is more efficient in this case.

---

### Query 3 – Calls Analysis by Month, Type and Status

#### Description

This query analyzes the number of calls by year and month, grouped by call type and status.

The purpose of this query is to help the organization identify trends over time, such as busy periods, common types of calls, and the distribution of call statuses.

---

#### Query 3A – Using GROUP BY

```sql
SELECT
    EXTRACT(YEAR FROM c.Call_Date) AS Year,
    EXTRACT(MONTH FROM c.Call_Date) AS Month,
    t.Type_Name,
    c.Status,
    COUNT(c.Call_ID) AS Total_Calls
FROM call c
JOIN TYPE t
    ON c.Type_ID = t.Type_ID
GROUP BY
    EXTRACT(YEAR FROM c.Call_Date),
    EXTRACT(MONTH FROM c.Call_Date),
    t.Type_Name,
    c.Status
ORDER BY
    Year,
    Month,
    Total_Calls DESC;
```

**Execution Screenshot:**  
<img src="Phase2/screenshots/query3a_run.png" width="700"/>

**Result Screenshot:**  
<img src="Phase2/screenshots/query3a_result.png" width="700"/>

---

#### Query 3B – Using Subquery

```sql
SELECT
    q.Year,
    q.Month,
    q.Type_Name,
    q.Status,
    q.Total_Calls
FROM (
    SELECT
        EXTRACT(YEAR FROM c.Call_Date) AS Year,
        EXTRACT(MONTH FROM c.Call_Date) AS Month,
        t.Type_Name,
        c.Status,
        COUNT(c.Call_ID) AS Total_Calls
    FROM call c
    JOIN TYPE t
        ON c.Type_ID = t.Type_ID
    GROUP BY
        EXTRACT(YEAR FROM c.Call_Date),
        EXTRACT(MONTH FROM c.Call_Date),
        t.Type_Name,
        c.Status
) q
ORDER BY
    q.Year,
    q.Month,
    q.Total_Calls DESC;
```

**Execution Screenshot:**  
<img src="Phase2/screenshots/query3b_run.png" width="700"/>

**Result Screenshot:**  
<img src="Phase2/screenshots/query3b_result.png" width="700"/>

---

#### Efficiency Explanation

Both queries return the same analysis of calls grouped by year, month, type, and status.

The GROUP BY query performs the aggregation directly and is therefore more efficient.

The subquery version wraps the same logic inside another query, which adds unnecessary overhead without improving performance.

Therefore, the GROUP BY approach is more efficient in this case.

---

### Query 4 – Active Volunteers With Certified Skills

#### Description

This query returns all active volunteers who have at least one skill that requires a certificate.

The purpose of this query is to identify qualified volunteers who are allowed to perform tasks that require official certification.

---

#### Query 4A – Using JOIN

```sql
SELECT DISTINCT
    v.Volunteer_ID,
    v.First_Name,
    v.Last_Name,
    v.Phone,
    v.City
FROM VOLUNTEER v
JOIN VOLUNTEER_SKILL vs
    ON v.Volunteer_ID = vs.Volunteer_ID
JOIN SKILL s
    ON vs.Skill_ID = s.Skill_ID
WHERE v.Is_Active = 'Y'
  AND s.Requires_Certificate = 'Y'
ORDER BY v.Last_Name, v.First_Name;
```

**Execution Screenshot:**  
<img src="Phase2/screenshots/query4a_run.png" width="700"/>

**Result Screenshot:**  
<img src="Phase2/screenshots/query4a_result.png" width="700"/>

---

#### Query 4B – Using EXISTS

```sql
SELECT
    v.Volunteer_ID,
    v.First_Name,
    v.Last_Name,
    v.Phone,
    v.City
FROM VOLUNTEER v
WHERE v.Is_Active = 'Y'
  AND EXISTS (
      SELECT 1
      FROM VOLUNTEER_SKILL vs
      JOIN SKILL s
          ON vs.Skill_ID = s.Skill_ID
      WHERE vs.Volunteer_ID = v.Volunteer_ID
        AND s.Requires_Certificate = 'Y'
  )
ORDER BY v.Last_Name, v.First_Name;
```

**Execution Screenshot:**  
<img src="Phase2/screenshots/query4b_run.png" width="700"/>

**Result Screenshot:**  
<img src="Phase2/screenshots/query4b_result.png" width="700"/>

---

#### Efficiency Explanation

Both queries return the same result: active volunteers who have at least one skill that requires a certificate.

The JOIN query combines multiple tables and may produce duplicate rows, which requires using DISTINCT.

The EXISTS query checks only whether a matching record exists, and stops searching as soon as one is found.

Therefore, the EXISTS query is more efficient in this case.
---

### Query 5 – Open Calls With Date Breakdown

#### Description

This query returns all open calls in the system, including the call type and a breakdown of the call date into year, month, and day.

The purpose of this query is to help the dispatch center monitor open emergency calls and handle them according to the most recent call date and time.

---

#### Query 5 – Open Calls

```sql
SELECT
    c.Call_ID,
    c.Phone,
    c.Call_Date,
    EXTRACT(YEAR FROM c.Call_Date) AS Call_Year,
    EXTRACT(MONTH FROM c.Call_Date) AS Call_Month,
    EXTRACT(DAY FROM c.Call_Date) AS Call_Day,
    c.Call_Time,
    t.Type_Name,
    c.Status
FROM CALL c
JOIN TYPE t
    ON c.Type_ID = t.Type_ID
WHERE c.Status = 'Open'
ORDER BY c.Call_Date DESC, c.Call_Time DESC;
```

**Execution Screenshot:** <img src="Phase2/screenshots/query5_run.png" width="700"/>

**Result Screenshot:** <img src="Phase2/screenshots/query5_result.png" width="700"/>

---

### Query 6 – Trainings With Registered Volunteers

#### Description

This query returns all trainings with the number of registered volunteers and the number of remaining available places.

The purpose of this query is to help management track participation in trainings and identify which trainings still have available space.

---

#### Query 6 – Training Participation

```sql
SELECT
    tr.Training_ID,
    tr.Training_Name,
    tr.Duration_Hours,
    tr.Max_Participant,
    COUNT(vt.Volunteer_ID) AS Registered_Volunteers,
    tr.Max_Participant - COUNT(vt.Volunteer_ID) AS Free_Places
FROM TRAINING tr
LEFT JOIN VOLUNTEER_TRAINING vt
    ON tr.Training_ID = vt.Training_ID
GROUP BY
    tr.Training_ID,
    tr.Training_Name,
    tr.Duration_Hours,
    tr.Max_Participant
ORDER BY Registered_Volunteers DESC;
```

**Execution Screenshot:** <img src="Phase2/screenshots/query6_run.png" width="700"/>

**Result Screenshot:** <img src="Phase2/screenshots/query6_result.png" width="700"/>

---

### Query 7 – Calls Summary By Type And Status

#### Description

This query returns a summary of calls grouped by call type and status.

The purpose of this query is to provide a management report that shows how many calls exist for each type and status, such as Open, Closed, and InProgress.

---

#### Query 7 – Calls Summary

```sql
SELECT
    t.Type_ID,
    t.Type_Name,
    c.Status,
    COUNT(c.Call_ID) AS Total_Calls
FROM TYPE t
JOIN CALL c
    ON t.Type_ID = c.Type_ID
GROUP BY
    t.Type_ID,
    t.Type_Name,
    c.Status
ORDER BY
    t.Type_Name,
    c.Status;
```

**Execution Screenshot:** <img src="Phase2/screenshots/query7_run.png" width="700"/>

**Result Screenshot:** <img src="Phase2/screenshots/query7_result.png" width="700"/>

---

### Query 8 – Monthly Volunteer Activity

#### Description

This query returns the number of closed calls handled by each volunteer, grouped by year and month.

The purpose of this query is to help management track volunteer activity over time and evaluate monthly performance.

---

#### Query 8 – Monthly Volunteer Activity

```sql
SELECT
    v.Volunteer_ID,
    v.First_Name,
    v.Last_Name,
    v.City,
    EXTRACT(YEAR FROM c.Call_Date) AS Activity_Year,
    EXTRACT(MONTH FROM c.Call_Date) AS Activity_Month,
    COUNT(c.Call_ID) AS Total_Handled_Calls
FROM VOLUNTEER v
JOIN VOLUNTEER_CALL vc
    ON v.Volunteer_ID = vc.Volunteer_ID
JOIN CALL c
    ON vc.Call_ID = c.Call_ID
WHERE c.Status = 'Closed'
GROUP BY
    v.Volunteer_ID,
    v.First_Name,
    v.Last_Name,
    v.City,
    EXTRACT(YEAR FROM c.Call_Date),
    EXTRACT(MONTH FROM c.Call_Date)
ORDER BY
    Activity_Year DESC,
    Activity_Month DESC,
    Total_Handled_Calls DESC;
```

**Execution Screenshot:** <img src="Phase2/screenshots/query8_run.png" width="700"/>

**Result Screenshot:** <img src="Phase2/screenshots/query8_result.png" width="700"/>

---
---

## Update Queries

### Update 1 – Close a Specific Open Call

#### Description

This update changes the status of a specific open call to `Closed`.

The purpose of this update is to allow the dispatch center to mark an emergency call as completed after it was handled.

**Before Screenshot:** <img src="Phase2/screenshots/update1_before.png" width="700"/>

**Execution Screenshot:** <img src="Phase2/screenshots/update1_run.png" width="700"/>

**After Screenshot:** <img src="Phase2/screenshots/update1_after.png" width="700"/>

---

### Update 2 – Deactivate Volunteers With the Lowest Activity

#### Description

This update finds the 5 active volunteers with the lowest number of handled calls and changes their status to inactive.

The purpose of this update is to demonstrate a non-trivial update based on volunteer activity, using `LEFT JOIN`, `GROUP BY`, `ORDER BY`, `LIMIT`, and a subquery.

**Before Screenshot:** <img src="Phase2/screenshots/update2_before.png" width="700"/>

**Execution Screenshot:** <img src="Phase2/screenshots/update2_run.png" width="700"/>

**After Screenshot:** <img src="Phase2/screenshots/update2_after.png" width="700"/>

---

### Update 3 – Increase Training Capacity for Full Trainings

#### Description

This update increases the maximum number of participants by 5 for trainings that are already full.

The purpose of this update is to help management allow more volunteers to register for trainings with high demand.

**Before Screenshot:** <img src="Phase2/screenshots/update3_before.png" width="700"/>

**Execution Screenshot:** <img src="Phase2/screenshots/update3_run.png" width="700"/>

**After Screenshot:** <img src="Phase2/screenshots/update3_after.png" width="700"/>

---

## Delete Queries

### Delete 1 – Delete Skill Records of Inactive Volunteers

#### Description

This delete removes records from `VOLUNTEER_SKILL` for volunteers whose status is inactive.

The purpose of this delete is to remove skill assignments from volunteers who are no longer active in the system.

**Before Screenshot:** <img src="Phase2/screenshots/delete1_before.png" width="700"/>

**Execution Screenshot:** <img src="Phase2/screenshots/delete1_run.png" width="700"/>

**After Screenshot:** <img src="Phase2/screenshots/delete1_after.png" width="700"/>

---

### Delete 2 – Delete Training Records of Inactive Volunteers

#### Description

This delete removes records from `VOLUNTEER_TRAINING` for volunteers whose status is inactive.

The purpose of this delete is to remove inactive volunteers from training registration records.

**Before Screenshot:** <img src="Phase2/screenshots/delete2_before.png" width="700"/>

**Execution Screenshot:** <img src="Phase2/screenshots/delete2_run.png" width="700"/>

**After Screenshot:** <img src="Phase2/screenshots/delete2_after.png" width="700"/>

---

### Delete 3 – Delete Call Assignment Records of Inactive Volunteers

#### Description

This delete removes records from `VOLUNTEER_CALL` for volunteers whose status is inactive.

The purpose of this delete is to remove inactive volunteers from emergency call assignment records.

**Before Screenshot:** <img src="Phase2/screenshots/delete3_before.png" width="700"/>

**Execution Screenshot:** <img src="Phase2/screenshots/delete3_run.png" width="700"/>

**After Screenshot:** <img src="Phase2/screenshots/delete3_after.png" width="700"/>

---

---

## Rollback and Commit

### Rollback Example

#### Description

In this example, a transaction is started using `BEGIN`.  
The city of a volunteer is updated temporarily.  
After running `ROLLBACK`, the database returns to its original state and the update is cancelled.

**Before Screenshot:**  
<img src="Phase2/screenshots/rollback_before.png" width="700"/>

**After Update Screenshot:**  
<img src="Phase2/screenshots/rollback_update.png" width="700"/>

**After Rollback Screenshot:**  
<img src="Phase2/screenshots/rollback_after_rollback.png" width="700"/>

---

### Commit Example

#### Description

In this example, a transaction is started using `BEGIN`.  
The city of a volunteer is updated.  
After running `COMMIT`, the change is saved permanently in the database.

**Before Screenshot:**  
<img src="Phase2/screenshots/commit_before.png" width="700"/>

**After Update Screenshot:**  
<img src="Phase2/screenshots/commit_update.png" width="700"/>

**After Commit Screenshot:**  
<img src="Phase2/screenshots/commit_after_commit.png" width="700"/>

---

---

## Constraints

### Constraint 1 – Training Duration Limit

**Motivation:**
To ensure that training duration remains within a reasonable limit.

**Benefit:**
Prevents invalid or unrealistic data from being stored.

**Observation:**
The database rejected invalid input, proving the constraint is enforced.


#### Description

This constraint was added to the `TRAINING` table using `ALTER TABLE`.

The constraint ensures that the duration of a training cannot be more than 10 hours.

If an invalid training with `Duration_Hours` greater than 10 is inserted, the database rejects the insert and returns an error.

**Alter Table Screenshot:** <img src="Phase2/screenshots/constraint1_alter.png" width="700"/>

**Error Screenshot:** <img src="Phase2/screenshots/constraint1_error.png" width="700"/>

---

### Constraint 2 – Positive Volunteer Phone Number

**Motivation:**
To prevent invalid phone numbers.

**Benefit:**
Ensures data accuracy and validity.

**Observation:**
Negative values were rejected by the database.


#### Description

This constraint was added to the `VOLUNTEER` table using `ALTER TABLE`.

The constraint ensures that a volunteer phone number must be positive.

If an invalid volunteer with a negative phone number is inserted, the database rejects the insert and returns an error.

**Alter Table Screenshot:** <img src="Phase2/screenshots/constraint2_alter.png" width="700"/>

**Error Screenshot:** <img src="Phase2/screenshots/constraint2_error.png" width="700"/>

---

### Constraint 3 – Call Time Cannot Be Null

**Motivation:**
To ensure that every call has a valid time.

**Benefit:**
Prevents incomplete records.

**Observation:**
NULL values were rejected by the database.


#### Description

This constraint was added to the `CALL` table using `ALTER TABLE`.

The constraint ensures that every call must have a call time and that `Call_Time` cannot be `NULL`.

If an invalid call with `Call_Time = NULL` is inserted, the database rejects the insert and returns an error.

**Alter Table Screenshot:** <img src="Phase2/screenshots/constraint3_alter.png" width="700"/>

**Error Screenshot:** <img src="Phase2/screenshots/constraint3_error.png" width="700"/>

---

---

## Indexes

### Index 1 – VOLUNTEER_CALL Volunteer_ID

**Motivation:**
This column is frequently used in search conditions.

**Benefit:**
Improves query performance by reducing full table scans.

**Observation:**
Execution time improved, although the plan still shows sequential scan due to small table size.


#### Description

An index was created on the `Volunteer_ID` column in the `VOLUNTEER_CALL` table.

This index improves performance when searching for all calls handled by a specific volunteer.

**Before Index Screenshot:** <img src="Phase2/screenshots/index1_before.png" width="700"/>

**Create Index Screenshot:** <img src="Phase2/screenshots/index1_create.png" width="700"/>

**After Index Screenshot:** <img src="Phase2/screenshots/index1_after.png" width="700"/>

#### Explanation

Before adding the index, the database may need to scan the table in order to find matching records.
After adding the index, the database can locate records by `Volunteer_ID` more efficiently.

---

### Index 2 – CALL Type_ID

**Motivation:**
To optimize filtering by call type.

**Benefit:**
Can improve performance when the dataset is large.

**Observation:**
No significant improvement due to small table size.


#### Description

An index was created on the `Type_ID` column in the `CALL` table.

This index improves performance when filtering calls by call type.

**Before Index Screenshot:** <img src="Phase2/screenshots/index2_before.png" width="700"/>

**Create Index Screenshot:** <img src="Phase2/screenshots/index2_create.png" width="700"/>

**After Index Screenshot:** <img src="Phase2/screenshots/index2_after.png" width="700"/>

#### Explanation

Before adding the index, filtering calls by type may require scanning many rows.
After adding the index, the database can search by `Type_ID` faster, especially when the table contains many calls.

---

### Index 3 – VOLUNTEER Is_Active

**Motivation:**
To optimize filtering by active status.

**Benefit:**
Can help in filtering operations.

**Observation:**
No improvement because the column has low selectivity (few distinct values).


#### Description

An index was created on the `Is_Active` column in the `VOLUNTEER` table.

This index improves performance when filtering active or inactive volunteers.

**Before Index Screenshot:** <img src="Phase2/screenshots/index3_before.png" width="700"/>

**Create Index Screenshot:** <img src="Phase2/screenshots/index3_create.png" width="700"/>

**After Index Screenshot:** <img src="Phase2/screenshots/index3_after.png" width="700"/>

#### Explanation

Before adding the index, the database may scan the volunteer table to find active volunteers.
After adding the index, filtering by `Is_Active` can be performed more efficiently.

---

## Backup (phase 2)

<img width="898" height="727" alt="image" src="https://github.com/user-attachments/assets/2a89fb90-49e7-4d68-a3c4-e85d3de4ae91" />
<img width="912" height="531" alt="image" src="https://github.com/user-attachments/assets/1a7755d3-46bc-41c9-b718-2d1a2027787b" />


# Phase 3: Integration and Views

## Introduction

In this phase, database integration was performed between our system and another team's system.

The process included:
- Presenting the ERD of our original system
- Presenting the ERD of the second team’s system
- Performing integration between the two databases into one combined system

The integration process was based on reverse engineering from the database structure and creating a new integrated ERD.

---

## Our System ERD

![Our ERD](Phase1/ERDAndDSDFiles/ERD.png)

---

## Second Team ERD

![Second Team ERD](Phase3/ERDAndDSDFiles/NEW_ERD.png)

---

## Integrated ERD

![Integrated ERD](Phase3/ERDAndDSDFiles/IntegratedERD.png)

---

## Integration Design Decisions

📄 [View Integration Design Decisions](Phase3/scripts/integration_design_decisions.md)

---

## Integrate SQL

We performed an integration process between our original database system and the database system received from another team, creating one unified system based on the new integrated ERD. At the beginning of the process, we created a new database called `integratedDB` and restored both systems into it. The received system was restored under a separate schema called `received_system` in order to avoid conflicts with the original tables. After that, we started modifying the existing database according to the integrated ERD using the `Integrate.sql` file.

In the `Volunteer` table, we added the fields `has_equipment` and `availability_status` that originated from the received system. We also renamed the column `city` to `volunteer_address` in order to match the new ERD design. Existing volunteers were updated according to `volunteer_id`, and additional volunteers from the received system were inserted into the unified table. For attributes that did not exist in the received system, such as `birthday`, `email`, and `recruitment_date`, default values were assigned.

In the `Call` table, we removed the fields `latitude`, `longitude`, `phone`, and `status`, since they no longer appeared in the integrated ERD. We then added the new fields `image` and `priority_level`. Existing calls were updated using information from the received system, and new calls were inserted from the `request` table, including images and call types (`type_id`).

We also created a new `Location` table that included the fields `location_id`, `address`, `latitude`, `longitude`, and `location_notes`. Since the received system did not contain a single address field, the new address was created by concatenating `city`, `street`, and `house_number` into one text value. Afterwards, calls were connected to locations using the `location_id` foreign key.

Another entity that was created during the integration process was `Caller`, which was based on the `Family` table from the received system. During this process, fields such as `contactperson_id` and `contactperson_name` were transformed into `caller_id` and `caller_name`. Calls were later connected to callers through the `caller_id` foreign key.

For the `Status` entity, all statuses were imported directly from the received system rather than generating artificial values. We then added the `status_id` field to the `Call` table and connected each call to its appropriate status.

In addition, we renamed the table `type` to `c_type` and created a new relationship table called `requires_skill` in order to represent the many-to-many relationship between call types (`c_type`) and skills (`skill`). This relationship table includes the foreign keys `type_id` and `skill_id`.

Throughout the entire integration process, we used SQL operations such as `ALTER TABLE`, `INSERT INTO SELECT`, `UPDATE`, creation of foreign keys, and relationship tables, while preserving the existing data and extending the database structure according to the integrated ERD.

📄 [View Integrate sql](Phase3/scripts/Integrate.sql)

---

## View SQL
In this phase, two meaningful database views were created in order to represent the perspectives of the two original systems after the integration process.

The first view, `volunteer_activity_view`, represents the perspective of our original volunteer management system.  
This view combines information about volunteers, their availability, assigned calls, and call statuses into one unified structure.  
The view allows the organization to monitor volunteer activity, availability schedules, and emergency calls assigned to volunteers.

The second view, `caller_call_location_view`, represents the perspective of the received system.  
This view combines caller information, call details, call priority, call status, and location information into one integrated structure.  
The purpose of this view is to provide a centralized representation of callers and emergency calls together with their related locations and statuses.

Both views were created using `LEFT JOIN` operations in order to preserve information even when related records do not exist in all connected tables.

---

### View 1 – volunteer_activity_view

#### Description

This view displays volunteer information together with availability details, assigned calls, and call statuses.

The purpose of this view is to provide a unified representation of volunteer activity in the organization.

#### View SQL

```sql
CREATE OR REPLACE VIEW volunteer_activity_view AS
SELECT
    v.Volunteer_ID,
    v.First_Name,
    v.Last_Name,
    v.Phone,
    v.Email,
    v.Availability_status,
    v.Is_Active,
    a.Day_Of_Week,
    a.Start_Time,
    a.End_Time,
    a.Preferred_Region_,
    c.Call_ID,
    c.Call_Date,
    c.Call_Time,
    s.Status_label
FROM Volunteer v
LEFT JOIN Availability a
    ON v.Volunteer_ID = a.Volunteer_ID
LEFT JOIN Volunteer_Call vc
    ON v.Volunteer_ID = vc.Volunteer_ID
LEFT JOIN Call c
    ON vc.Call_ID = c.Call_ID
LEFT JOIN Status s
    ON c.Status_id = s.Status_id;
```

#### Select * From View

```sql
SELECT *
FROM volunteer_activity_view
LIMIT 10;
```

---

### Query 1 on View 1

#### Description

This query displays active volunteers together with their availability details and assigned calls.

The purpose of this query is to help the organization monitor active volunteers and track their emergency call activity.

```sql
SELECT *
FROM volunteer_activity_view
WHERE Is_Active = 'Y'
ORDER BY Last_Name, First_Name;
```

**Result Screenshot:**  
<img width="1480" height="626" alt="image" src="https://github.com/user-attachments/assets/4bba7383-8004-452e-9a93-d0027f2ae9e6" />

---

### Query 2 on View 1

#### Description

This query counts the number of calls handled by each volunteer.

The purpose of this query is to evaluate volunteer activity and workload distribution.

```sql
SELECT
    Volunteer_ID,
    First_Name,
    Last_Name,
    COUNT(Call_ID) AS total_calls
FROM volunteer_activity_view
GROUP BY Volunteer_ID, First_Name, Last_Name
ORDER BY total_calls DESC;
```

**Result Screenshot:**  
<img width="691" height="647" alt="image" src="https://github.com/user-attachments/assets/e118c786-11d0-4da2-80ae-c7dceed70a6b" />

---

### View 2 – caller_call_location_view

#### Description

This view displays caller information together with emergency call details, priority level, call status, and location information.

The purpose of this view is to provide a complete overview of callers and emergency requests in the integrated system.

#### View SQL

```sql
CREATE OR REPLACE VIEW caller_call_location_view AS
SELECT
    caller.caller_id,
    caller.caller_name,
    caller.phone_number,
    caller.special_features,
    c.call_id,
    c.call_description,
    c.priority_level,
    c.call_date,
    c.call_time,
    ct.type_name,
    s.status_label,
    l.location_id,
    l.address,
    l.latitude,
    l.longitude,
    l.location_notes
FROM caller
LEFT JOIN call c
    ON caller.caller_id = c.caller_id
LEFT JOIN c_type ct
    ON c.type_id = ct.type_id
LEFT JOIN status s
    ON c.status_id = s.status_id
LEFT JOIN location l
    ON c.location_id = l.location_id;
```

#### Select * From View

```sql
SELECT *
FROM caller_call_location_view
LIMIT 10;
```

### Query 1 on View 2

#### Description

This query counts the number of calls for each priority level.

The purpose of this query is to analyze the distribution of emergency calls according to urgency level.

```sql
SELECT
    priority_level,
    COUNT(call_id) AS total_calls
FROM caller_call_location_view
GROUP BY priority_level
ORDER BY total_calls DESC;
```

**Result Screenshot:**  
<img width="435" height="128" alt="image" src="https://github.com/user-attachments/assets/fcf075c8-635d-4805-b8fc-75b1e49c7327" />

---

### Query 2 on View 2

#### Description

This query displays callers that are not connected to any emergency call in the integrated database.

The purpose of this query is to identify caller records that currently do not have matching call records.

```sql
SELECT
    caller_id,
    caller_name,
    phone_number,
    special_features
FROM caller_call_location_view
WHERE call_id IS NULL
ORDER BY caller_name
LIMIT 10;
```

**Result Screenshot:**  
<img width="754" height="428" alt="image" src="https://github.com/user-attachments/assets/38820fb2-ce4a-4f9f-9253-3aa144b4b75b" />

---

📄 [View sql](Phase3/scripts/View.sql)

---

## Backup (phase 3)

<img width="894" height="708" alt="image" src="https://github.com/user-attachments/assets/63a73746-bdad-45e9-9108-eeeda9ed1440" />
<img width="898" height="515" alt="image" src="https://github.com/user-attachments/assets/2487d3fc-76ca-4f6f-92e7-b7e7ddbdfe70" />


# Phase 4: PL/pgSQL Programs

## Main Program 1

### Main Program Description
The purpose of the main program is to find all calls that do not have an assigned volunteer and automatically assign the most suitable volunteer to each one.

### Step 1 – Calling the `find_calls_without_volunteers` Function
At the beginning of the main program, the following function is called:

[find_calls_without_volunteers.sql](./Phase4/Functions/find_calls_without_volunteers.sql)

The function returns a `REF CURSOR` containing all calls that do not have an assigned volunteer in the `volunteer_call` table.
For each call, the function returns:

* Call ID (`call_id`)
* Call description (`call_description`)
* Call date
* Call time
* Priority level (`priority_level`)
* Call type (`type_name`)

<img width="1165" height="218" alt="image" src="https://github.com/user-attachments/assets/6415853f-f78b-475e-ac36-7c84327bc61b" />

### Step 2 – Iterating Through the Calls
The main program iterates (`LOOP`) through all calls returned by the function.
For each call, it prints:

* Call ID
* Call description
* Priority level
* Call type

For example:

```text
Processing call 1000001
Description: Medical help needed near Jerusalem Center
Priority: 5
Type: Flat Tire Assistance
```
### Step 3 – Calling the `assign_best_volunteer_to_call` Procedure
For each call, the main program calls the following procedure:

[assign_best_volunteer_to_call.sql](./Phase4/Procedures/assign_best_volunteer_to_call.sql)

The purpose of this procedure is to find the most suitable volunteer for the call.
The procedure iterates through all active volunteers and calculates a matching score for each one based on:
1. The number of skills that match the call requirements.
2. Whether the volunteer has the required equipment (`has_equipment`).
3. Whether the volunteer is available (`availability_status`).
4. The geographical distance between the volunteer and the call location, calculated using latitude and longitude (`latitude`, `longitude`).

The volunteer with the highest score is selected and assigned to the call.

### What Is Printed During the Procedure Execution?

<img width="1246" height="566" alt="image" src="https://github.com/user-attachments/assets/323d4c55-565c-41a1-be85-3d300e7e4b13" />

During the execution of the procedure, the following messages may be printed:

```text
Volunteer 3 currently leads with score 15
Volunteer 207143500 currently leads with score 20
Volunteer 330925502 currently leads with score 40
Volunteer 9001 currently leads with score 85
```

This means:
* Initially, volunteer 3 had the highest score.
* Later, another volunteer with a higher score was found.
* Finally, volunteer 9001 achieved a score of 85 and was selected as the best match.

At the end of the procedure, the following message is printed:

```text
Volunteer 9001 assigned to call 1000001 with score 85
```

This means that volunteer 9001 was assigned to call 1000001 with a matching score of 85.

### Step 4 – Trigger Activation

When the procedure assigns a volunteer to a call, it inserts a new record into the volunteer_call table.
As soon as the `INSERT` operation is performed on this table, the following trigger is automatically activated:

[update_call_status_after_assignment.sql](./Phase4/Triggers/update_call_status_after_assignment.sql)

The purpose of the trigger is to update the call status in the `call` table.
The trigger changes the status from Pending to In Progress.

We can see that the calls were successfully assigned to volunteers, and their status was automatically updated to "In Progress" by the trigger.
<img width="1096" height="212" alt="image" src="https://github.com/user-attachments/assets/3556a7b3-008c-41bf-a673-300f6c83141a" />

---

## Main Program 2

### Main Program Description
The purpose of the second main program is to identify the most required skills in emergency calls and automatically create new training programs for skills that have the fewest qualified volunteers.

Before running the main program, we can examine the `skill` and `training` tables to observe the initial state of the system.
The `skill` table contains all existing skills and their current training status, while the `training` table contains all existing training programs. At this stage, we can see which skills already have training programs and which ones do not.
These tables will later allow us to verify that the program successfully created new training programs and updated the relevant training statuses.

<img width="867" height="570" alt="image" src="https://github.com/user-attachments/assets/9582ab27-41e0-43be-a417-6c1fb65d4d11" />
<img width="557" height="582" alt="image" src="https://github.com/user-attachments/assets/09059bbe-6327-4d0c-823f-f35708db6b66" />

### Step 1 – Calling the `find_top_required_skills` Function
At the beginning of the main program, the following function is called:

[find_top_required_skills.sql](./Phase4/Functions/find_top_required_skills.sql)

The function returns a `REF CURSOR` containing the three most required skills in the system.
For each skill, the function returns:

* Skill ID (`skill_id`)
* Skill name (`skill_name`)
* Number of times the skill was required (`times_required`)

For example:

```text
Tire      | 10114
English   | 5065
French    | 4999
```

This means that Tire is the most required skill in emergency calls, followed by English and French.

<img width="518" height="176" alt="image" src="https://github.com/user-attachments/assets/3fa37466-312b-4209-977e-635fb4c3ff1a" />

### Step 2 – Iterating Through the Skills

The main program iterates (`LOOP`) through all skills returned by the function.
For each skill, it prints:

* Skill name
* Number of times the skill was required

For example:

```text
Processing skill Tire | Required 10114 times
Processing skill English | Required 5065 times
Processing skill French | Required 4999 times
```

### Step 3 – Calling the `generate_training_for_missing_skills` Procedure

For each skill, the main program calls the following procedure:

[generate_training_for_missing_skills.sql](./Phase4/Procedures/generate_training_for_missing_skills.sql)

The purpose of this procedure is to determine whether a new training program should be created.
The procedure performs the following steps:

1. Counts the number of volunteers who have the skill.
2. Ranks all skills according to the number of qualified volunteers.
3. Selects the two skills with the fewest volunteers.
4. Creates a new training program for these skills.
5. Updates the `training_status` field in the `skill` table from **Not Planned** to **Planned**.

### What Is Printed During the Procedure Execution?
During the execution of the procedure, the following messages may be printed:

```text
Processing skill Tire | Required 10114 times
Skill: Tire, Volunteers with this skill: 0
Training status for skill Tire changed from Not Planned to Planned
Training created for skill Tire

Processing skill English | Required 5065 times
Skill: English, Volunteers with this skill: 0
Training status for skill English changed from Not Planned to Planned
Training created for skill English

Processing skill French | Required 4999 times
Skill: French, Volunteers with this skill: 8
Skill French is not among the two least common skills.
No training needed.
```

This means:

* Tire and English are highly required skills but have no qualified volunteers.
* Therefore, new training programs are automatically created for these skills.
* French already has enough volunteers, so no training program is created.

<img width="792" height="341" alt="image" src="https://github.com/user-attachments/assets/d1bcae8f-1864-4415-8cdb-bd4c6598f7c3" />

### Step 4 – Trigger Activation

When the procedure creates a new training program, it updates the `training_status` field in the `skill` table.
As soon as the `UPDATE` operation is performed, the following trigger is automatically activated:

[trg_skill_training_status_update.sql](./Phase4/Triggers/trg_skill_training_status_update.sql)

The purpose of the trigger is to notify that the training status has changed.

For example:

```text
Training status for skill Tire changed from Not Planned to Planned
Training status for skill English changed from Not Planned to Planned
```

This confirms that the new training programs were successfully created and the training status of the relevant skills was automatically updated by the trigger.

### Verifying the Results

After running the main program, we can verify that:

1. New records were added to the `training` table.
2. The `training_status` field in the `skill` table was updated to `Planned`.

<img width="857" height="631" alt="image" src="https://github.com/user-attachments/assets/29b840f6-8403-40bb-9a7e-e8e8de9f7c54" />
<img width="573" height="551" alt="image" src="https://github.com/user-attachments/assets/893fb87f-b7d1-4545-aed5-591b89119b13" />

Therefore, we can conclude that the second main program successfully identified the most required skills, created new training programs, and automatically updated the system using an `AFTER UPDATE` trigger.

---
## Backup (phase 4)

<img width="877" height="695" alt="image" src="https://github.com/user-attachments/assets/1e088590-1b57-44db-b216-0398a8a03cc6" />



