/* =========================================================
   Phase 2 - RollbackCommit.sql
   Volunteers Organization Database - Yedidim
   ========================================================= */


/* =========================================================
   ROLLBACK EXAMPLE
   ========================================================= */

SELECT
    Volunteer_ID,
    First_Name,
    Last_Name,
    City,
    Is_Active
FROM VOLUNTEER
WHERE Volunteer_ID = 1;

BEGIN;

UPDATE VOLUNTEER
SET City = 'Jerusalem'
WHERE Volunteer_ID = 1;

SELECT
    Volunteer_ID,
    First_Name,
    Last_Name,
    City,
    Is_Active
FROM VOLUNTEER
WHERE Volunteer_ID = 1;

ROLLBACK;

SELECT
    Volunteer_ID,
    First_Name,
    Last_Name,
    City,
    Is_Active
FROM VOLUNTEER
WHERE Volunteer_ID = 1;


/* =========================================================
   COMMIT EXAMPLE
   ========================================================= */

SELECT
    Volunteer_ID,
    First_Name,
    Last_Name,
    City,
    Is_Active
FROM VOLUNTEER
WHERE Volunteer_ID = 2;

BEGIN;

UPDATE VOLUNTEER
SET City = 'Tel Aviv'
WHERE Volunteer_ID = 2;

SELECT
    Volunteer_ID,
    First_Name,
    Last_Name,
    City,
    Is_Active
FROM VOLUNTEER
WHERE Volunteer_ID = 2;

COMMIT;

SELECT
    Volunteer_ID,
    First_Name,
    Last_Name,
    City,
    Is_Active
FROM VOLUNTEER
WHERE Volunteer_ID = 2;
