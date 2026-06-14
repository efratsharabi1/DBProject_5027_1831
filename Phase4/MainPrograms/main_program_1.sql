DO $$
DECLARE

```
calls_cursor REFCURSOR;

call_rec RECORD;
```

BEGIN

```
-- קבלת כל הקריאות ללא מתנדבים
calls_cursor := find_calls_without_volunteers();

LOOP

    FETCH calls_cursor INTO call_rec;

    EXIT WHEN NOT FOUND;

    RAISE NOTICE
'Call % | Description: % | Priority: %',
call_rec.call_id,
call_rec.call_description,
call_rec.priority_level;

    -- שיבוץ המתנדב המתאים ביותר
    CALL assign_best_volunteer_to_call(
        call_rec.call_id
    );

    -- הטריגר ירוץ אוטומטית אחרי ה-INSERT
    -- ויעדכן את status_id של הקריאה

END LOOP;

CLOSE calls_cursor;

RAISE NOTICE
'All calls without volunteers were assigned successfully';
```

EXCEPTION

```
WHEN OTHERS THEN

    RAISE NOTICE
    'Error in main program: %',
    SQLERRM;
```

END;
$$;
