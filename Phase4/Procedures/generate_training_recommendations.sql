CREATE OR REPLACE PROCEDURE generate_training_recommendations()
LANGUAGE plpgsql
AS $$
DECLARE
    skill_rec RECORD;
    volunteer_count INT;
    existing_training INT;
BEGIN

    FOR skill_rec IN

        SELECT
            s.skill_id,
            s.skill_name,
            s.description,
            s.difficulty_level,
            COUNT(*) AS usage_count

        FROM requires_skill rs
        JOIN skill s
            ON rs.skill_id = s.skill_id

        GROUP BY
            s.skill_id,
            s.skill_name,
            s.description,
            s.difficulty_level

        ORDER BY usage_count DESC

    LOOP

        SELECT COUNT(*)
        INTO volunteer_count
        FROM volunteer_skill
        WHERE skill_id = skill_rec.skill_id;

        IF volunteer_count < 3 THEN

            SELECT training_id
            INTO existing_training
            FROM training
            WHERE LOWER(training_name) =
                  LOWER('Training_' || skill_rec.skill_name)
            LIMIT 1;

            IF existing_training IS NULL THEN

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
                        'Auto generated training for '
                        || skill_rec.skill_name,
                        30
                    ),

                    20,

                    CASE
                        WHEN skill_rec.difficulty_level >= 5 THEN 8
                        WHEN skill_rec.difficulty_level >= 3 THEN 6
                        ELSE 4
                    END
                );

                RAISE NOTICE
                'Created training for skill %',
                skill_rec.skill_name;

            ELSE

                RAISE NOTICE
                'Training already exists for skill %',
                skill_rec.skill_name;

            END IF;

        END IF;

    END LOOP;

EXCEPTION

    WHEN OTHERS THEN

        RAISE NOTICE
        'Error in generate_training_recommendations: %',
        SQLERRM;

END;
$$;