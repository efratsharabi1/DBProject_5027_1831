/* =========================================================
   Phase 2 - Constraints.sql
   ========================================================= */


/* ---------------------------------------------------------
   Constraint 1:
   Limit training duration
   --------------------------------------------------------- */

ALTER TABLE TRAINING
ADD CONSTRAINT check_training_duration
CHECK (Duration_Hours <= 10);

-- Test invalid data for Constraint 1
INSERT INTO TRAINING
(
    Training_ID,
    Training_Name,
    Description_,
    Max_Participant,
    Duration_Hours
)
VALUES
(
    999,
    'BadTraining',
    'Invalid duration',
    20,
    11
);


/* ---------------------------------------------------------
   Constraint 2:
   Ensure phone number is positive
   --------------------------------------------------------- */

ALTER TABLE VOLUNTEER
ADD CONSTRAINT check_phone_positive
CHECK (Phone > 0);

-- Test invalid data for Constraint 2
INSERT INTO VOLUNTEER
(
    Volunteer_ID,
    First_Name,
    Last_Name,
    Phone,
    Birthday,
    Email,
    City,
    recruitment_date,
    Is_Active
)
VALUES
(
    1000,
    'Test',
    'BadPhone',
    -5,
    '2000-01-01',
    'test_bad_phone@gmail.com',
    'Jerusalem',
    '2020-01-01',
    'Y'
);


/* ---------------------------------------------------------
   Constraint 3:
   Ensure call time is not null
   --------------------------------------------------------- */

ALTER TABLE CALL
ADD CONSTRAINT check_call_time_not_null
CHECK (Call_Time IS NOT NULL);

-- Test invalid data for Constraint 3
INSERT INTO "CALL"
(
    Call_ID,
    Longitude,
    Call_Time,
    Status,
    Phone,
    Call_Date,
    Latitude,
    Description,
    Type_ID
)
VALUES
(
    999,
    35.21,
    NULL,
    'Open',
    505123456,
    CURRENT_DATE,
    31,
    'Invalid call time',
    1
);
