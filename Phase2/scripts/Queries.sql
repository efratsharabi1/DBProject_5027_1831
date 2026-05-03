/* =========================================================
   Phase 2 - Queries.sql
   Volunteers Organization Database - Yedidim
   ========================================================= */


/* =========================================================
   PART 1: SELECT QUERIES
   4 queries written in two different ways
   ========================================================= */


/* ---------------------------------------------------------
   Query 1A:
   Active volunteers with difficult skills - using JOIN
   --------------------------------------------------------- */

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


/* ---------------------------------------------------------
   Query 1B:
   Active volunteers with difficult skills - using EXISTS
   --------------------------------------------------------- */

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

/* ---------------------------------------------------------
   Query 2A:
   Number of calls handled by each active volunteer - using JOIN
   --------------------------------------------------------- */

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


/* ---------------------------------------------------------
   Query 2B:
   Number of calls handled by each active volunteer - using subquery
   --------------------------------------------------------- */

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

/* ---------------------------------------------------------
   Query 3A:
   Number of calls by year and month - using GROUP BY
   --------------------------------------------------------- */

SELECT
    EXTRACT(YEAR FROM c.Call_Date) AS Call_Year,
    EXTRACT(MONTH FROM c.Call_Date) AS Call_Month,
    t.Type_Name,
    c.Status,
    COUNT(c.Call_ID) AS Total_Calls
FROM "CALL" c
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


/* ---------------------------------------------------------
   Query 3B:
   Number of calls by year and month - using subquery
   --------------------------------------------------------- */

SELECT
    q.Call_Year,
    q.Call_Month,
    q.Type_Name,
    q.Status,
    q.Total_Calls
FROM (
    SELECT
        EXTRACT(YEAR FROM c.Call_Date) AS Call_Year,
        EXTRACT(MONTH FROM c.Call_Date) AS Call_Month,
        t.Type_Name,
        c.Status,
        COUNT(c.Call_ID) AS Total_Calls
    FROM "CALL" c
    JOIN TYPE t
        ON c.Type_ID = t.Type_ID
    GROUP BY
        EXTRACT(YEAR FROM c.Call_Date),
        EXTRACT(MONTH FROM c.Call_Date),
        t.Type_Name,
        c.Status
) q
ORDER BY
    q.Call_Year,
    q.Call_Month,
    q.Total_Calls DESC;
