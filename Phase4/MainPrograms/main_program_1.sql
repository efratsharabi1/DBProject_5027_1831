DO $$
DECLARE
    -- Cursor returned from the function
    calls_cursor REFCURSOR;

    -- Record for storing each call details
    call_rec RECORD;

BEGIN

    -- Get all calls without assigned volunteers
    calls_cursor := find_calls_without_volunteers();

    LOOP

        FETCH calls_cursor INTO call_rec;

        EXIT WHEN NOT FOUND;

        -- Print the current call information
        RAISE NOTICE
        'Processing call % | Description: % | Priority: % | Type: %',
            call_rec.call_id,
            call_rec.call_description,
            call_rec.priority_level,
            call_rec.type_name;

        -- Call the procedure that assigns the best volunteer
        CALL assign_best_volunteer_to_call(
            call_rec.call_id
        );

    END LOOP;

    CLOSE calls_cursor;

    -- Print success message
    RAISE NOTICE
    'All calls without volunteers were processed successfully';

EXCEPTION

    WHEN OTHERS THEN

        -- Print error message
        RAISE NOTICE
        'Error in main program: %',
        SQLERRM;

END;
$$;
