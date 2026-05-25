-- =========================================
-- STEP 1 - CREATE NEW TABLES
-- =========================================

-- LOCATION --

CREATE TABLE IF NOT EXISTS public.location (
    location_id INT PRIMARY KEY,
    address VARCHAR(255) NULL,
    latitude NUMERIC(9,6) NULL,
    longitude NUMERIC(9,6) NULL,
    location_notes TEXT NULL
);

-- STATUS --

CREATE TABLE IF NOT EXISTS public.status (
    status_id INT PRIMARY KEY,
    status_label VARCHAR(50) NOT NULL
);

-- CALLER --

CREATE TABLE IF NOT EXISTS public.caller (
    caller_id INT PRIMARY KEY,
    caller_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    special_features TEXT NULL
);

-- =========================================
-- STEP 2 - ALTER EXISTING TABLES
-- =========================================

-- VOLUNTEER --

ALTER TABLE public.volunteer
ADD COLUMN IF NOT EXISTS has_equipment BOOLEAN;

ALTER TABLE public.volunteer
ADD COLUMN IF NOT EXISTS availability_status VARCHAR(50);

ALTER TABLE public.volunteer
RENAME COLUMN city TO volunteer_address;

ALTER TABLE public.volunteer
ADD COLUMN IF NOT EXISTS location_id INT;

-- CALL --

ALTER TABLE public.call
DROP COLUMN IF EXISTS longitude;

ALTER TABLE public.call
DROP COLUMN IF EXISTS latitude;

ALTER TABLE public.call
DROP COLUMN IF EXISTS phone;

ALTER TABLE public.call
DROP COLUMN IF EXISTS status;

ALTER TABLE public.call
ADD COLUMN IF NOT EXISTS image TEXT;

ALTER TABLE public.call
ADD COLUMN IF NOT EXISTS priority_level VARCHAR(50);

ALTER TABLE public.call
RENAME COLUMN description TO call_description;

ALTER TABLE public.call
ADD COLUMN IF NOT EXISTS location_id INT;

ALTER TABLE public.call
ADD COLUMN IF NOT EXISTS status_id INT;

ALTER TABLE public.call
ADD COLUMN IF NOT EXISTS caller_id INT;

-- SCHEDULED --

ALTER TABLE public.scheduled
ADD COLUMN IF NOT EXISTS location_id INT;

-- TYPE --

ALTER TABLE public.type
RENAME TO c_type;


-- =========================================
-- STEP 3 - CREATE RELATIONSHIP TABLES
-- =========================================

-- C_Type SKILL --

CREATE TABLE IF NOT EXISTS public.requires_skill (
    type_id INT NOT NULL,
    skill_id INT NOT NULL,
    PRIMARY KEY (type_id, skill_id),
    FOREIGN KEY (type_id) REFERENCES public.c_type(type_id),
    FOREIGN KEY (skill_id) REFERENCES public.skill(skill_id)
);


-- =========================================
-- STEP 4 - ADD FOREIGN KEYS
-- =========================================

-- CALL --

ALTER TABLE public.call
ADD CONSTRAINT fk_call_location
FOREIGN KEY (location_id)
REFERENCES public.location(location_id);

ALTER TABLE public.call
ADD CONSTRAINT fk_call_status
FOREIGN KEY (status_id)
REFERENCES public.status(status_id);

ALTER TABLE public.call
ADD CONSTRAINT fk_call_caller
FOREIGN KEY (caller_id)
REFERENCES public.caller(caller_id);

-- VOLUNTEER --

ALTER TABLE public.volunteer
ADD CONSTRAINT fk_volunteer_location
FOREIGN KEY (location_id)
REFERENCES public.location(location_id);

-- =========================================
-- STEP 5 - INSERT DATA FROM RECEIVED SYSTEM
-- =========================================

-- VOLUNTEER --

INSERT INTO public.volunteer (
    volunteer_id,
    first_name,
    last_name,
    phone,
    birthday,
    email,
    recruitment_date,
    is_active,
    volunteer_address,
    has_equipment,
    availability_status
)
SELECT
    rs.volunteer_id,
    rs.first_name,
    rs.last_name,
    regexp_replace(rs.phone_number, '[^0-9]', '', 'g')::integer,
    DATE '2000-01-01',
    'unknown_' || rs.volunteer_id || '@email.com',
    DATE '2025-01-01',
    'Y',
    'Unknown Address',
    rs.has_equipment,
    rs.availability_status
FROM received_system.volunteer rs
WHERE NOT EXISTS (
    SELECT 1
    FROM public.volunteer v
    WHERE v.volunteer_id = rs.volunteer_id
);

-- CALL --

INSERT INTO public.call (
    call_id,
    call_description,
    call_date,
    call_time,
    image,
    priority_level,
    type_id
)
SELECT
    r.request_id,
    r.incident_description,
    r.date,
    TIME '08:00:00' + ((r.request_id % 12) * INTERVAL '1 hour'),
    r.image,
    r.prioriry_level,
    ((r.request_id % 4) + 1)
FROM received_system.request r
WHERE NOT EXISTS (
    SELECT 1
    FROM public.call c
    WHERE c.call_id = r.request_id
);

-- LOCATION --

INSERT INTO public.location (
    location_id,
    address,
    latitude,
    longitude,
    location_notes
)
SELECT
    ROW_NUMBER() OVER () AS location_id,
    rs.city || ', ' || rs.street || ' ' || rs.house_number AS address,
    rs.latitude,
    rs.longitude,
    'No notes'
FROM received_system.location rs;

-- STATUS --

INSERT INTO public.status (
    status_id,
    status_label
)
SELECT
    rs.status_id,
    rs.status_label
FROM received_system.status rs
WHERE NOT EXISTS (
    SELECT 1
    FROM public.status s
    WHERE s.status_id = rs.status_id
);

-- CALLER --

INSERT INTO public.caller (
    caller_id,
    caller_name,
    phone_number,
    special_features
)

SELECT
    f.contactperson_id,
    f.contactperson_name,
    f.phone_number,
    f.special_features

FROM received_system.family f

WHERE NOT EXISTS (
    SELECT 1
    FROM public.caller c
    WHERE c.caller_id = f.contactperson_id
);

-- C_Type SKILL --

INSERT INTO public.requires_skill (type_id, skill_id)
SELECT
    t.type_id,
    s.skill_id
FROM public.c_type t
JOIN public.skill s
ON s.skill_id = ((t.type_id - 1) % (SELECT COUNT(*) FROM public.skill)) + 1
ON CONFLICT (type_id, skill_id) DO NOTHING;

-- =========================================
-- STEP 6 - UPDATE EXISTING TABLES
-- =========================================

-- VOLUNTEER --

UPDATE public.volunteer v
SET
    has_equipment = rs.has_equipment,
    availability_status = rs.availability_status
FROM received_system.volunteer rs
WHERE v.volunteer_id = rs.volunteer_id;

-- CALL --

UPDATE public.call c
SET
    image = r.image,
    priority_level = r.prioriry_level
FROM received_system.request r
WHERE c.call_id = r.request_id;

UPDATE public.call c
SET status_id = r.status_id
FROM received_system.request r
WHERE c.call_id = r.request_id;

UPDATE public.call
SET caller_id = ((call_id - 1) % 500) + 1
WHERE caller_id IS NULL;

-- CALL LOCATIONS --

UPDATE public.call
SET location_id = ((call_id - 1) % 500) + 1;
