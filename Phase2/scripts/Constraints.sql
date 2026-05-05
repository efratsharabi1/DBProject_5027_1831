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


/* ---------------------------------------------------------
   Constraint 3:
   Ensure call time is not null
   --------------------------------------------------------- */

ALTER TABLE CALL
ADD CONSTRAINT check_call_time_not_null
CHECK (Call_Time IS NOT NULL);
