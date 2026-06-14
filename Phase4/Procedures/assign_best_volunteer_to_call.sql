CREATE OR REPLACE PROCEDURE assign_best_volunteer_to_call(p_call_id INT)
LANGUAGE plpgsql
AS $$
DECLARE
    volunteer_cursor CURSOR FOR
        SELECT *
        FROM volunteer
        WHERE is_active = 'Y';

    volunteer_rec RECORD;
    v_call RECORD;
    best_volunteer INT := NULL;
    best_score INT := -1;
    current_score INT;
    matching_skills INT;
    distance NUMERIC;
    v_lat NUMERIC;
    v_lon NUMERIC;
    c_lat NUMERIC;
    c_lon NUMERIC;
BEGIN
    SELECT *
    INTO v_call
    FROM call
    WHERE call_id = p_call_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Call % does not exist', p_call_id;
    END IF;

    SELECT latitude, longitude
    INTO c_lat, c_lon
    FROM location
    WHERE location_id = v_call.location_id;

    OPEN volunteer_cursor;

    LOOP
        FETCH volunteer_cursor INTO volunteer_rec;
        EXIT WHEN NOT FOUND;

        current_score := 0;

        SELECT COUNT(*)
        INTO matching_skills
        FROM volunteer_skill vs
        JOIN requires_skill rs ON vs.skill_id = rs.skill_id
        WHERE vs.volunteer_id = volunteer_rec.volunteer_id
          AND rs.type_id = v_call.type_id;

        current_score := current_score + matching_skills * 15;

        IF volunteer_rec.has_equipment = TRUE THEN
            current_score := current_score + 20;
        END IF;

        IF LOWER(volunteer_rec.availability_status) = 'available' THEN
            current_score := current_score + 20;
        END IF;

        IF volunteer_rec.location_id IS NOT NULL THEN
            SELECT latitude, longitude
            INTO v_lat, v_lon
            FROM location
            WHERE location_id = volunteer_rec.location_id;

            distance := SQRT(POWER(v_lat - c_lat, 2) + POWER(v_lon - c_lon, 2));

            IF distance < 0.02 THEN
                current_score := current_score + 30;
            ELSIF distance < 0.05 THEN
                current_score := current_score + 20;
            ELSE
                current_score := current_score + 10;
            END IF;
        END IF;

        IF current_score > best_score THEN
            best_score := current_score;
            best_volunteer := volunteer_rec.volunteer_id;
        END IF;
    END LOOP;

    CLOSE volunteer_cursor;

    IF best_volunteer IS NOT NULL THEN
        INSERT INTO volunteer_call(volunteer_id, call_id)
        VALUES(best_volunteer, p_call_id);

        RAISE NOTICE 'Volunteer % assigned to call % with score %',
            best_volunteer, p_call_id, best_score;
    ELSE
        RAISE NOTICE 'No suitable volunteer found for call %', p_call_id;
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error in assign_best_volunteer_to_call: %', SQLERRM;
END;
$$;
