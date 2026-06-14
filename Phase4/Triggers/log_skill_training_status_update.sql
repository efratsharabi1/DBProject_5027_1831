CREATE OR REPLACE FUNCTION log_skill_training_status_update()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    RAISE NOTICE
    'Training status for skill % changed from % to %',
    NEW.skill_name,
    OLD.training_status,
    NEW.training_status;

    RETURN NEW;
END;
$$;



CREATE TRIGGER trg_skill_training_status_update
AFTER UPDATE OF training_status
ON skill
FOR EACH ROW
EXECUTE FUNCTION log_skill_training_status_update();
