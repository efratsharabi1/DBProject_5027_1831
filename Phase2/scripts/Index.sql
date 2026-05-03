/* =========================================================
   Phase 2 - Index.sql
   ========================================================= */


/* ---------------------------------------------------------
   Index 1:
   Index on VOLUNTEER_CALL.Volunteer_ID
   --------------------------------------------------------- */

-- Before index
EXPLAIN ANALYZE
SELECT *
FROM VOLUNTEER_CALL
WHERE Volunteer_ID = 5;

-- Create index
CREATE INDEX idx_volunteer_call_volunteer_id
ON VOLUNTEER_CALL (Volunteer_ID);

-- After index
EXPLAIN ANALYZE
SELECT *
FROM VOLUNTEER_CALL
WHERE Volunteer_ID = 5;


/* ---------------------------------------------------------
   Index 2:
   Index on CALL.Type_ID
   --------------------------------------------------------- */

-- Before index
EXPLAIN ANALYZE
SELECT *
FROM CALL
WHERE Type_ID = 1;

-- Create index
CREATE INDEX idx_call_type_id
ON CALL (Type_ID);

-- After index
EXPLAIN ANALYZE
SELECT *
FROM CALL
WHERE Type_ID = 1;


/* ---------------------------------------------------------
   Index 3:
   Index on VOLUNTEER.Is_Active
   --------------------------------------------------------- */

-- Before index
EXPLAIN ANALYZE
SELECT *
FROM VOLUNTEER
WHERE Is_Active = 'Y';

-- Create index
CREATE INDEX idx_volunteer_is_active
ON VOLUNTEER (Is_Active);

-- After index
EXPLAIN ANALYZE
SELECT *
FROM VOLUNTEER
WHERE Is_Active = 'Y';
