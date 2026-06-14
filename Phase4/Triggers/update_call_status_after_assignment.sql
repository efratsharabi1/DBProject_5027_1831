CREATE OR REPLACE FUNCTION update_call_status_after_assignment()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    -- Update the call status after a volunteer is assigned
    UPDATE call
    SET status_id = 2
    WHERE call_id = NEW.call_id;

    -- Print a message showing that the trigger was activated
    RAISE NOTICE
    'Call % assigned to volunteer %. Status changed from Pending to In Progress',
    NEW.call_id,
    NEW.volunteer_id;

    RETURN NEW;
END;
$$;



-- Create the trigger on volunteer_call after each new assignment
CREATE TRIGGER trg_update_call_status_after_assignment
AFTER INSERT
ON volunteer_call
FOR EACH ROW
EXECUTE FUNCTION update_call_status_after_assignment();
