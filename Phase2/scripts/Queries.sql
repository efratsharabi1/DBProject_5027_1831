/* =========================================================
   Phase 2 - Queries.sql
   Volunteers Organization Database - Yedidim
   ========================================================= */


/* =========================================================
   PART 1: SELECT QUERIES (4 queries in 2 versions)
   ========================================================= */


/* -------------------- Query 1A -------------------- */
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


/* -------------------- Query 1B -------------------- */
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


/* -------------------- Query 2A -------------------- */
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


/* -------------------- Query 2B -------------------- */
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


/* -------------------- Query 3A -------------------- */
SELECT
    EXTRACT(YEAR FROM c.Call_Date) AS Call_Year,
    EXTRACT(MONTH FROM c.Call_Date) AS Call_Month,
    t.Type_Name,
    c.Status,
    COUNT(c.Call_ID) AS Total_Calls
FROM CALL c
JOIN TYPE t
    ON c.Type_ID = t.Type_ID
GROUP BY
    EXTRACT(YEAR FROM c.Call_Date),
    EXTRACT(MONTH FROM c.Call_Date),
    t.Type_Name,
    c.Status
ORDER BY
    Call_Year,
    Call_Month,
    Total_Calls DESC;


/* -------------------- Query 3B -------------------- */
SELECT
    q.Call_Year,
    q.Call_Month,
    t.Type_Name,
    q.Status,
    q.Total_Calls
FROM (
    SELECT
        EXTRACT(YEAR FROM Call_Date) AS Call_Year,
        EXTRACT(MONTH FROM Call_Date) AS Call_Month,
        Type_ID,
        Status,
        COUNT(Call_ID) AS Total_Calls
    FROM CALL
    GROUP BY
        EXTRACT(YEAR FROM Call_Date),
        EXTRACT(MONTH FROM Call_Date),
        Type_ID,
        Status
) q
JOIN TYPE t
    ON q.Type_ID = t.Type_ID
ORDER BY
    q.Call_Year,
    q.Call_Month,
    q.Total_Calls DESC;


/* -------------------- Query 4A -------------------- */
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


/* -------------------- Query 4B -------------------- */
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



/* =========================================================
   PART 2: ADDITIONAL SELECT QUERIES
   ========================================================= */


/* -------------------- Query 5 -------------------- */
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


/* -------------------- Query 6 -------------------- */
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


/* -------------------- Query 7 -------------------- */
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


/* -------------------- Query 8 -------------------- */
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

/* =========================================================
   PART 3: UPDATE QUERIES
   ========================================================= */


/* ---------------------------------------------------------
   Update 1:
   Close a specific open call
   --------------------------------------------------------- */

SELECT *
FROM CALL
WHERE Call_ID = 1;

UPDATE CALL
SET Status = 'Closed'
WHERE Call_ID = 1
  AND Status = 'Open';

SELECT *
FROM CALL
WHERE Call_ID = 1;

/* ---------------------------------------------------------
   Update 2:
   Deactivate 5 volunteers with the lowest activity
   --------------------------------------------------------- */

SELECT
    v.Volunteer_ID,
    v.First_Name,
    v.Last_Name,
    v.Is_Active,
    COUNT(vc.Call_ID) AS Total_Calls
FROM VOLUNTEER v
LEFT JOIN VOLUNTEER_CALL vc
    ON v.Volunteer_ID = vc.Volunteer_ID
WHERE v.Is_Active = 'Y'
GROUP BY
    v.Volunteer_ID,
    v.First_Name,
    v.Last_Name,
    v.Is_Active
ORDER BY Total_Calls ASC
LIMIT 5;

UPDATE VOLUNTEER
SET Is_Active = 'N'
WHERE Volunteer_ID IN (
    SELECT Volunteer_ID
    FROM (
        SELECT
            v.Volunteer_ID,
            COUNT(vc.Call_ID) AS Total_Calls
        FROM VOLUNTEER v
        LEFT JOIN VOLUNTEER_CALL vc
            ON v.Volunteer_ID = vc.Volunteer_ID
        WHERE v.Is_Active = 'Y'
        GROUP BY v.Volunteer_ID
        ORDER BY Total_Calls ASC
        LIMIT 5
    ) AS low_activity_volunteers
);

SELECT
    v.Volunteer_ID,
    v.First_Name,
    v.Last_Name,
    v.Is_Active,
    COUNT(vc.Call_ID) AS Total_Calls
FROM VOLUNTEER v
LEFT JOIN VOLUNTEER_CALL vc
    ON v.Volunteer_ID = vc.Volunteer_ID
WHERE v.Is_Active = 'N'
GROUP BY
    v.Volunteer_ID,
    v.First_Name,
    v.Last_Name,
    v.Is_Active
ORDER BY Total_Calls ASC
LIMIT 5;

/* ---------------------------------------------------------
   Update 3:
   Increase training capacity for full trainings
   --------------------------------------------------------- */

SELECT
    tr.Training_ID,
    tr.Training_Name,
    tr.Max_Participant,
    COUNT(vt.Volunteer_ID) AS Registered_Volunteers
FROM TRAINING tr
JOIN VOLUNTEER_TRAINING vt
    ON tr.Training_ID = vt.Training_ID
GROUP BY
    tr.Training_ID,
    tr.Training_Name,
    tr.Max_Participant
HAVING COUNT(vt.Volunteer_ID) >= tr.Max_Participant;

UPDATE TRAINING tr
SET Max_Participant = Max_Participant + 5
WHERE tr.Training_ID IN (
    SELECT tr2.Training_ID
    FROM TRAINING tr2
    JOIN VOLUNTEER_TRAINING vt
        ON tr2.Training_ID = vt.Training_ID
    GROUP BY
        tr2.Training_ID,
        tr2.Max_Participant
    HAVING COUNT(vt.Volunteer_ID) >= tr2.Max_Participant
);

SELECT
    tr.Training_ID,
    tr.Training_Name,
    tr.Max_Participant,
    COUNT(vt.Volunteer_ID) AS Registered_Volunteers
FROM TRAINING tr
JOIN VOLUNTEER_TRAINING vt
    ON tr.Training_ID = vt.Training_ID
GROUP BY
    tr.Training_ID,
    tr.Training_Name,
    tr.Max_Participant
ORDER BY tr.Training_ID;


/* =========================================================
   PART 4: DELETE QUERIES
   ========================================================= */

/* ---------------------------------------------------------
   Delete 1:
   Delete volunteer-skill records of inactive volunteers
   --------------------------------------------------------- */


SELECT
    vs.Volunteer_ID,
    v.First_Name,
    v.Last_Name,
    v.Is_Active,
    vs.Skill_ID
FROM VOLUNTEER_SKILL vs
JOIN VOLUNTEER v
    ON vs.Volunteer_ID = v.Volunteer_ID
WHERE v.Is_Active = 'N';


DELETE FROM VOLUNTEER_SKILL vs
USING VOLUNTEER v
WHERE vs.Volunteer_ID = v.Volunteer_ID
  AND v.Is_Active = 'N';


SELECT
    vs.Volunteer_ID,
    v.First_Name,
    v.Last_Name,
    v.Is_Active,
    vs.Skill_ID
FROM VOLUNTEER_SKILL vs
JOIN VOLUNTEER v
    ON vs.Volunteer_ID = v.Volunteer_ID
WHERE v.Is_Active = 'N';



/* ---------------------------------------------------------
   Delete 2:
   Delete volunteer-training records for inactive volunteers
   --------------------------------------------------------- */

SELECT
    vt.*
FROM VOLUNTEER_TRAINING vt
JOIN VOLUNTEER v
    ON vt.Volunteer_ID = v.Volunteer_ID
WHERE v.Is_Active = 'N';

DELETE FROM VOLUNTEER_TRAINING vt
USING VOLUNTEER v
WHERE vt.Volunteer_ID = v.Volunteer_ID
  AND v.Is_Active = 'N';

SELECT
    vt.*
FROM VOLUNTEER_TRAINING vt
JOIN VOLUNTEER v
    ON vt.Volunteer_ID = v.Volunteer_ID
WHERE v.Is_Active = 'N';

/* ---------------------------------------------------------
   Delete 3:
   Delete volunteer-call records of inactive volunteers
   --------------------------------------------------------- */

SELECT
    vc.Volunteer_ID,
    v.First_Name,
    v.Last_Name,
    v.Is_Active,
    vc.Call_ID
FROM VOLUNTEER_CALL vc
JOIN VOLUNTEER v
    ON vc.Volunteer_ID = v.Volunteer_ID
WHERE v.Is_Active = 'N';


DELETE FROM VOLUNTEER_CALL vc
USING VOLUNTEER v
WHERE vc.Volunteer_ID = v.Volunteer_ID
  AND v.Is_Active = 'N';


SELECT
    vc.Volunteer_ID,
    v.First_Name,
    v.Last_Name,
    v.Is_Active,
    vc.Call_ID
FROM VOLUNTEER_CALL vc
JOIN VOLUNTEER v
    ON vc.Volunteer_ID = v.Volunteer_ID
WHERE v.Is_Active = 'N';
