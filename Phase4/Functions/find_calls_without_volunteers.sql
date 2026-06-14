CREATE OR REPLACE FUNCTION find_calls_without_volunteers()
RETURNS REFCURSOR
LANGUAGE plpgsql
AS $$
DECLARE

    -- Cursor that will store all calls without assigned volunteers
    calls_cursor REFCURSOR := 'calls_without_volunteers_cursor';

BEGIN

    -- Open the cursor and retrieve all calls
    -- that do not have a volunteer assigned
    OPEN calls_cursor FOR

        SELECT
            c.call_id,
            c.call_description,
            c.call_date,
            c.call_time,
            c.priority_level,
            ct.type_name

        FROM call c

        -- Join with c_type to get the call type name
        JOIN c_type ct
            ON c.type_id = ct.type_id

        -- Return only calls that are not assigned
        WHERE NOT EXISTS
        (
            SELECT 1
            FROM volunteer_call vc
            WHERE vc.call_id = c.call_id
        )

        -- Sort by priority and date
        ORDER BY
            c.priority_level DESC,
            c.call_date;

    -- Return the cursor
    RETURN calls_cursor;

EXCEPTION

    WHEN OTHERS THEN

        -- Print an error message if something goes wrong
        RAISE NOTICE
        'Error in find_calls_without_volunteers: %',
        SQLERRM;

        RETURN NULL;

END;
$$;
