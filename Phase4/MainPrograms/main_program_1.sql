DO $$
DECLARE

    calls_cursor REFCURSOR;

    call_rec RECORD;

BEGIN

    -- קריאה לפונקציה
    calls_cursor := find_calls_without_volunteers();

    LOOP

        FETCH calls_cursor INTO call_rec;

        EXIT WHEN NOT FOUND;

        RAISE NOTICE
        'Assigning volunteer to call %',
        call_rec.call_id;

        -- קריאה לפרוצדורה
        CALL assign_best_volunteer_to_call(
            call_rec.call_id
        );

    END LOOP;

    CLOSE calls_cursor;

    RAISE NOTICE
    'All calls without volunteers were processed successfully';

EXCEPTION

    WHEN OTHERS THEN

        RAISE NOTICE

        'Error in main program: %',

        SQLERRM;

END;
$$;
