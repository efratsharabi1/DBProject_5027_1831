-- =========================================
-- Views.sql
-- Phase C - Views and Queries
-- =========================================


-- =====================================================
-- View 1: Original Department Perspective
-- Volunteer activity, availability, and assigned calls
-- =====================================================

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


-- Query 1 on View 1:
-- Display active volunteers together with their availability details and any assigned calls

SELECT *
FROM volunteer_activity_view
WHERE Is_Active = 'Y'
ORDER BY Last_Name, First_Name;


-- Query 2 on View 1:
-- Count the number of calls handled by each volunteer

SELECT
    Volunteer_ID,
    First_Name,
    Last_Name,
    COUNT(Call_ID) AS total_calls
FROM volunteer_activity_view
GROUP BY Volunteer_ID, First_Name, Last_Name
ORDER BY total_calls DESC;




-- =====================================================
-- View 2: New Department Perspective
-- Caller, call, status, type, and location details
-- =====================================================

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


-- Query 1 on View 2:
-- Count the number of calls for each priority level

SELECT
    priority_level,
    COUNT(call_id) AS total_calls
FROM caller_call_location_view
GROUP BY priority_level
ORDER BY total_calls DESC;


-- Query 2 on View 2:
-- Display callers that are not connected to any call in the integrated database

SELECT
    caller_id,
    caller_name,
    phone_number,
    special_features
FROM caller_call_location_view
WHERE call_id IS NULL
ORDER BY caller_name
LIMIT 10;