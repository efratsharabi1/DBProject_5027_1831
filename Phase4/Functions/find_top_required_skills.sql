CREATE OR REPLACE FUNCTION find_top_required_skills()
RETURNS REFCURSOR
LANGUAGE plpgsql
AS $$
DECLARE
    -- Cursor for storing the top required skills
    skills_cursor REFCURSOR := 'top_skills_cursor';
BEGIN
    -- Open cursor with the three most required skills
    OPEN skills_cursor FOR
        SELECT
            s.skill_id,
            s.skill_name,
            COUNT(c.call_id) AS times_required
        FROM call c
        -- Match each call type with its required skills
        JOIN requires_skill rs
            ON c.type_id = rs.type_id
        -- Get skill details
        JOIN skill s
            ON rs.skill_id = s.skill_id
        GROUP BY
            s.skill_id,
            s.skill_name
        -- Sort from most required to least required
        ORDER BY
            times_required DESC
        LIMIT 3;

    -- Return the cursor
    RETURN skills_cursor;

EXCEPTION
    WHEN OTHERS THEN
        -- Print error message if something fails
        RAISE NOTICE 'Error in find_top_required_skills: %', SQLERRM;
        RETURN NULL;
END;
$$;
