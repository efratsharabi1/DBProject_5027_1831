CREATE OR REPLACE FUNCTION update_call_status_after_assignment()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE call
    SET status_id = 2
    WHERE call_id = NEW.call_id;

    RAISE NOTICE 'Call % status updated to 2 after assigning volunteer %',
        NEW.call_id,
        NEW.volunteer_id;

    RETURN NEW;
END;
$$;


DROP TRIGGER IF EXISTS trg_update_call_status_after_assignment ON volunteer_call;

CREATE TRIGGER trg_update_call_status_after_assignment
AFTER INSERT
ON volunteer_call
FOR EACH ROW
EXECUTE FUNCTION update_call_status_after_assignment();
