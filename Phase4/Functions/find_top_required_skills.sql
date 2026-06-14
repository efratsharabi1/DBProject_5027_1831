CREATE OR REPLACE FUNCTION find_top_required_skills()
RETURNS REFCURSOR
LANGUAGE plpgsql
AS $$
DECLARE

    skills_cursor REFCURSOR := 'top_skills_cursor';

BEGIN

    OPEN skills_cursor FOR

        SELECT
            s.skill_id,
            s.skill_name,
            COUNT(*) AS times_required

        FROM requires_skill rs

        JOIN skill s
            ON rs.skill_id = s.skill_id

        GROUP BY
            s.skill_id,
            s.skill_name

        ORDER BY
            times_required DESC

        LIMIT 3;

    RETURN skills_cursor;

EXCEPTION

    WHEN OTHERS THEN

        RAISE NOTICE
        'Error in find_top_required_skills: %',
        SQLERRM;

        RETURN NULL;

END;
$$;
