CREATE OR REPLACE PROCEDURE generate_training_for_missing_skills(p_skill_id INT)
LANGUAGE plpgsql
AS $$
DECLARE

    volunteer_count INT;

    skill_rec RECORD;

BEGIN

    SELECT *
    INTO skill_rec
    FROM skill
    WHERE skill_id = p_skill_id;

    IF NOT FOUND THEN

        RAISE EXCEPTION
        'Skill % does not exist',
        p_skill_id;

    END IF;

    SELECT COUNT(*)
    INTO volunteer_count

    FROM volunteer_skill

    WHERE skill_id = p_skill_id;

    RAISE NOTICE
    'Skill: %, Volunteers with this skill: %',

    skill_rec.skill_name,

    volunteer_count;

    IF volunteer_count < 3 THEN

        INSERT INTO training
        (
            training_name,
            description,
            max_participant,
            duration_hours
        )

        VALUES
        (
            LEFT('Training_' || skill_rec.skill_name,15),

            LEFT(
            'Training for '
            || skill_rec.skill_name,
            30
            ),

            20,

            skill_rec.difficulty_level + 3
        );

        UPDATE skill

        SET training_status='Planned'

        WHERE skill_id=p_skill_id;

        RAISE NOTICE

        'Training created for skill %',

        skill_rec.skill_name;

    ELSE

        RAISE NOTICE

        'Enough volunteers exist. No training needed for %',

        skill_rec.skill_name;

    END IF;

EXCEPTION

    WHEN OTHERS THEN

        RAISE NOTICE

        'Error in generate_training_for_missing_skills: %',

        SQLERRM;

END;
$$;
