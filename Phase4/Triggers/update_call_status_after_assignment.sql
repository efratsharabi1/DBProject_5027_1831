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
