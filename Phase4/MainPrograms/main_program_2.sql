DO $$
DECLARE
    -- Cursor returned from the function
    skills_cursor REFCURSOR;

    -- Record for storing each skill
    skill_rec RECORD;

BEGIN
    -- Get the top required skills
    skills_cursor := find_top_required_skills();

    LOOP
        FETCH skills_cursor INTO skill_rec;

        EXIT WHEN NOT FOUND;

        -- Print current skill details
        RAISE NOTICE
        'Processing skill % | Required % times',
        skill_rec.skill_name,
        skill_rec.times_required;

        -- Create training if the skill is missing among volunteers
        CALL generate_training_for_missing_skills(
            skill_rec.skill_id
        );

    END LOOP;

    CLOSE skills_cursor;

    -- Print success message
    RAISE NOTICE
    'All required skills were processed successfully';

EXCEPTION
    WHEN OTHERS THEN
        -- Print error message
        RAISE NOTICE
        'Error in main program 2: %',
        SQLERRM;

END;
$$;
