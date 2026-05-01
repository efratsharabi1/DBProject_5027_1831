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
