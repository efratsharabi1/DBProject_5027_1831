CREATE OR REPLACE PROCEDURE update_call_priorities()
LANGUAGE plpgsql
AS $$
DECLARE

    call_cursor CURSOR FOR

        SELECT
            c.call_id,
            c.priority_level,
            c.type_id
        FROM call c;

    call_rec RECORD;

    required_skills_count INT;

BEGIN

    OPEN call_cursor;

    LOOP

        FETCH call_cursor INTO call_rec;

        EXIT WHEN NOT FOUND;

        SELECT COUNT(*)
        INTO required_skills_count
        FROM requires_skill
        WHERE type_id = call_rec.type_id;

        IF required_skills_count >= 3
           AND call_rec.priority_level < 5
        THEN

            UPDATE call

            SET priority_level =
                priority_level + 1

            WHERE call_id =
                  call_rec.call_id;

            RAISE NOTICE
            'Call % priority updated from % to %',
            call_rec.call_id,
            call_rec.priority_level,
            call_rec.priority_level + 1;

        ELSE

            RAISE NOTICE
            'Call % was not updated',
            call_rec.call_id;

        END IF;

    END LOOP;

    CLOSE call_cursor;

EXCEPTION

    WHEN OTHERS THEN

        RAISE NOTICE
        'Error in update_call_priorities: %',
        SQLERRM;

        CLOSE call_cursor;

END;
$$;