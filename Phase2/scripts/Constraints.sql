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
