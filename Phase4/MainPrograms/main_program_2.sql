DO $$

DECLARE

    skills_cursor REFCURSOR;

    skill_rec RECORD;

BEGIN

    skills_cursor :=

    find_top_required_skills();

    LOOP

        FETCH skills_cursor

        INTO skill_rec;

        EXIT WHEN NOT FOUND;

        RAISE NOTICE

        'Processing skill % | Required % times',

        skill_rec.skill_name,

        skill_rec.times_required;

        CALL

        generate_training_for_missing_skills(

        skill_rec.skill_id

        );

    END LOOP;

    CLOSE skills_cursor;

    RAISE NOTICE

    'All required skills were processed successfully';

EXCEPTION

    WHEN OTHERS THEN

        RAISE NOTICE

        'Error in main program 2: %',

        SQLERRM;

END;
$$;
