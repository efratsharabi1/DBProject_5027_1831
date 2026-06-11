CREATE OR REPLACE FUNCTION find_best_volunteers_for_call(
    p_call_id INT
)
RETURNS REFCURSOR
LANGUAGE plpgsql
AS $$
DECLARE
    best_volunteers_cursor REFCURSOR := 'best_volunteers_cursor';
    v_call RECORD;
BEGIN

    -- בדיקה שהקריאה קיימת
    SELECT *
    INTO v_call
    FROM call
    WHERE call_id = p_call_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Call ID % does not exist', p_call_id;
    END IF;

    OPEN best_volunteers_cursor FOR

    SELECT
        v.volunteer_id,
        v.first_name,
        v.last_name,
        v.phone,
        v.email,

        COUNT(vs.skill_id) AS matching_skills,

        (
            CASE
                WHEN v.is_active = 'Y'
                THEN 20
                ELSE 0
            END

            +

            CASE
                WHEN v.has_equipment = TRUE
                THEN 20
                ELSE 0
            END

            +

            COUNT(vs.skill_id) * 10

        ) AS match_score

    FROM volunteer v

    LEFT JOIN volunteer_skill vs
        ON v.volunteer_id = vs.volunteer_id

    WHERE vs.skill_id IN
    (
        SELECT rs.skill_id
        FROM requires_skill rs
        WHERE rs.type_id = v_call.type_id
    )

    GROUP BY
        v.volunteer_id,
        v.first_name,
        v.last_name,
        v.phone,
        v.email,
        v.is_active,
        v.has_equipment

    ORDER BY match_score DESC,
             matching_skills DESC;

    RETURN best_volunteers_cursor;

EXCEPTION

    WHEN NO_DATA_FOUND THEN
        RAISE NOTICE 'No matching data found';
        RETURN NULL;

    WHEN OTHERS THEN
        RAISE NOTICE 'Error: %', SQLERRM;
        RETURN NULL;

END;
$$;