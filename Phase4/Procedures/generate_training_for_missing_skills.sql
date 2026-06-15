CREATE OR REPLACE PROCEDURE generate_training_for_missing_skills(
    p_skill_id INT
)
LANGUAGE plpgsql
AS $$
DECLARE

    volunteer_count INT;
    skill_rec RECORD;
    skill_rank INT;

BEGIN

    -- Get skill details
    SELECT *
    INTO skill_rec
    FROM skill
    WHERE skill_id = p_skill_id;

    IF NOT FOUND THEN

        RAISE EXCEPTION
        'Skill % does not exist',
        p_skill_id;

    END IF;

    -- Count volunteers with this skill
    SELECT COUNT(*)
    INTO volunteer_count
    FROM volunteer_skill
    WHERE skill_id = p_skill_id;

    RAISE NOTICE
    'Skill: %, Volunteers with this skill: %',
    skill_rec.skill_name,
    volunteer_count;

    -- Rank skills according to number of volunteers
    SELECT rank_num
    INTO skill_rank

    FROM
    (

        SELECT

            s.skill_id,
            DENSE_RANK() OVER
            (ORDER BY COUNT(vs.volunteer_id)) AS rank_num
        FROM skill s
        LEFT JOIN volunteer_skill vs
            ON s.skill_id = vs.skill_id
        GROUP BY s.skill_id) t
    WHERE t.skill_id = p_skill_id;

    -- Create training only for the two least common skills
    IF skill_rank <= 2 THEN

        INSERT INTO training
        (
            training_id,
            training_name,
            description_,
            max_participant,
            duration_hours
        )

        VALUES
        (
            -- Generate a new training ID
            (
                SELECT
                COALESCE(MAX(training_id),0)+1
                FROM training
            ),

            LEFT(
                'Training_' ||
                skill_rec.skill_name,
                15
            ),

            LEFT(
                'Training for '  || skill_rec.skill_name,
            30),
            20,
            skill_rec.difficulty_level + 3
        );

        -- Update skill status
        UPDATE skill
        SET training_status='Planned'
        WHERE skill_id=p_skill_id;
        RAISE NOTICE
        'Training created for skill %',
        skill_rec.skill_name;

    ELSE

        RAISE NOTICE
        'Skill % is not among the two least common skills. No training needed.',
        skill_rec.skill_name;
    END IF;

EXCEPTION

    WHEN OTHERS THEN
        RAISE NOTICE
        'Error in generate_training_for_missing_skills: %',
        SQLERRM;

END;
$$;
