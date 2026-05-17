
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: ochrith
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO ochrith;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: ochrith
--

COMMENT ON SCHEMA public IS '';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: delivery; Type: TABLE; Schema: public; Owner: ochrith
--

CREATE TABLE public.delivery (
    delivery_id integer NOT NULL,
    date date NOT NULL,
    status character varying(50),
    item_type character varying(100),
    quantity integer,
    request_id integer,
    CONSTRAINT delivery_quantity_check CHECK ((quantity > 0))
);


ALTER TABLE public.delivery OWNER TO ochrith;

--
-- Name: family; Type: TABLE; Schema: public; Owner: ochrith
--

CREATE TABLE public.family (
    contactperson_id integer NOT NULL,
    contactperson_name character varying(255) NOT NULL,
    phone_number character varying(20),
    number_of_members integer,
    special_features text,
    CONSTRAINT family_number_of_members_check CHECK ((number_of_members > 0))
);


ALTER TABLE public.family OWNER TO ochrith;

--
-- Name: location; Type: TABLE; Schema: public; Owner: ochrith
--

CREATE TABLE public.location (
    latitude numeric(9,6) NOT NULL,
    longitude numeric(9,6) NOT NULL,
    city character varying(100) NOT NULL,
    street character varying(100),
    house_number integer,
    CONSTRAINT chk_coordinates CHECK ((((latitude >= 29.0) AND (latitude <= 34.0)) AND ((longitude >= 34.0) AND (longitude <= 36.0))))
);


ALTER TABLE public.location OWNER TO ochrith;

--
-- Name: request; Type: TABLE; Schema: public; Owner: ochrith
--

CREATE TABLE public.request (
    request_id integer NOT NULL,
    date date NOT NULL,
    image character varying(255),
    incident_description text,
    prioriry_level integer,
    contactperson_id integer,
    category_id integer,
    status_id integer,
    latitude numeric(9,6),
    longitude numeric(9,6),
    CONSTRAINT chk_prioriry_level CHECK (((prioriry_level >= 1) AND (prioriry_level <= 5))),
    CONSTRAINT request_prioriry_level_check CHECK (((prioriry_level >= 1) AND (prioriry_level <= 5)))
);


ALTER TABLE public.request OWNER TO ochrith;

--
-- Name: requestcategory; Type: TABLE; Schema: public; Owner: ochrith
--

CREATE TABLE public.requestcategory (
    category_id integer NOT NULL,
    category_name character varying(100) NOT NULL,
    description text,
    required_skills character varying(255)
);


ALTER TABLE public.requestcategory OWNER TO ochrith;

--
-- Name: status; Type: TABLE; Schema: public; Owner: ochrith
--

CREATE TABLE public.status (
    status_id integer NOT NULL,
    status_label character varying(50) NOT NULL
);


ALTER TABLE public.status OWNER TO ochrith;

--
-- Name: treatment; Type: TABLE; Schema: public; Owner: ochrith
--

CREATE TABLE public.treatment (
    treatment_id integer NOT NULL,
    date date NOT NULL,
    start_time time without time zone,
    completion_time time without time zone,
    feedback_notes text,
    photo_after character varying(255),
    delivery_id integer,
    volunteer_id integer,
    request_id integer,
    CONSTRAINT chk_treatment_duration CHECK (((completion_time IS NULL) OR ((completion_time - start_time) <= '24:00:00'::interval))),
    CONSTRAINT chk_treatment_time_order CHECK (((completion_time IS NULL) OR (completion_time >= start_time)))
);


ALTER TABLE public.treatment OWNER TO ochrith;

--
-- Name: volunteer; Type: TABLE; Schema: public; Owner: ochrith
--

CREATE TABLE public.volunteer (
    volunteer_id integer NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    phone_number character varying(20),
    has_equipment boolean,
    availability_status character varying(50),
    counter integer DEFAULT 0,
    skill_type character varying(100),
    latitude numeric(9,6),
    longitude numeric(9,6)
);

-- ======================================================
-- STEP 1: INDEPENDENT TABLES (Parent Tables)
-- These tables do not have foreign keys.
-- ======================================================

-- Stores the various states of a request (e.g., Pending, In Progress, Completed)
CREATE TABLE STATUS (
    status_id INT PRIMARY KEY,
    status_label VARCHAR(50) NOT NULL
);


CREATE TABLE REQUESTCATEGORY (
    Category_id INT PRIMARY KEY,
    Category_name VARCHAR(100) NOT NULL,
    description TEXT,
    required_skills VARCHAR(255)
);


CREATE TABLE LOCATION (
    latitude NUMERIC(9,6),
    longitude NUMERIC(9,6),
    city VARCHAR(100) NOT NULL,
    street VARCHAR(100),
    house_number INT,
    PRIMARY KEY (latitude, longitude)
);

-- Information about the families receiving aid
CREATE TABLE FAMILY (
    ContactPerson_id INT PRIMARY KEY,
    ContactPerson_name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    -- Constraint: A family must have at least one member
    number_of_members INT CHECK (number_of_members > 0),
    special_features TEXT
);

-- ======================================================
-- STEP 2: TABLES WITH DEPENDENCIES
-- These tables reference the parent tables above.
-- ======================================================

-- Volunteers who provide help
CREATE TABLE VOLUNTEER (
    volunteer_id INT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20),
    has_equipment BOOLEAN,
    availability_status VARCHAR(50),
    counter INT DEFAULT 0, -- Tracks the number of missions completed
    skill_type VARCHAR(100),
    latitude NUMERIC(9,6),
    longitude NUMERIC(9,6),
    FOREIGN KEY (latitude, longitude) REFERENCES LOCATION(latitude, longitude)
);

-- The central request table
CREATE TABLE REQUEST (
    Request_id INT PRIMARY KEY,
    date DATE NOT NULL,
    image VARCHAR(255), -- Path or URL to the incident photo
    incident_description TEXT,
    -- Constraint: Priority must be between 1 (Low) and 5 (Critical)
    prioriry_level INT CHECK (prioriry_level BETWEEN 1 AND 5),
    ContactPerson_id INT REFERENCES FAMILY(ContactPerson_id),
    Category_id INT REFERENCES REQUESTCATEGORY(Category_id),
    status_id INT REFERENCES STATUS(status_id),
    --treatment_id INT REFERENCES TREATMENT(treatment_id),
    latitude NUMERIC(9,6),
    longitude NUMERIC(9,6),
    FOREIGN KEY (latitude, longitude) REFERENCES LOCATION(latitude, longitude)
);

-- Tracks physical items being sent to a family
CREATE TABLE DELIVERY (
    delivery_id INT PRIMARY KEY,
    date DATE NOT NULL,
    status VARCHAR(50),
    item_type VARCHAR(100),
    -- Constraint: Quantity cannot be zero or negative
    quantity INT CHECK (quantity > 0),
    Request_id INT REFERENCES REQUEST(Request_id)
);

-- Records the actual action taken by a volunteer
CREATE TABLE TREATMENT (
    treatment_id INT PRIMARY KEY,
    date DATE NOT NULL,
    start_time TIME,
    completion_time TIME,
    feedback_notes TEXT,
    photo_after VARCHAR(255),
    delivery_id INT REFERENCES DELIVERY(delivery_id),
    volunteer_id INT REFERENCES VOLUNTEER(volunteer_id),
    request_id INT REFERENCES REQUEST(request_id)
);


-- ======================================================
-- STEP 1: INDEPENDENT TABLES (Parent Tables)
-- These tables do not have foreign keys.
-- ======================================================

-- Stores the various states of a request (e.g., Pending, In Progress, Completed)
CREATE TABLE STATUS (
    status_id INT PRIMARY KEY,
    status_label VARCHAR(50) NOT NULL
);


CREATE TABLE REQUESTCATEGORY (
    Category_id INT PRIMARY KEY,
    Category_name VARCHAR(100) NOT NULL,
    description TEXT,
    required_skills VARCHAR(255)
);


CREATE TABLE LOCATION (
    latitude NUMERIC(9,6),
    longitude NUMERIC(9,6),
    city VARCHAR(100) NOT NULL,
    street VARCHAR(100),
    house_number INT,
    PRIMARY KEY (latitude, longitude)
);

-- Information about the families receiving aid
CREATE TABLE FAMILY (
    ContactPerson_id INT PRIMARY KEY,
    ContactPerson_name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20),
    -- Constraint: A family must have at least one member
    number_of_members INT CHECK (number_of_members > 0),
    special_features TEXT
);

-- ======================================================
-- STEP 2: TABLES WITH DEPENDENCIES
-- These tables reference the parent tables above.
-- ======================================================

-- Volunteers who provide help
CREATE TABLE VOLUNTEER (
    volunteer_id INT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20),
    has_equipment BOOLEAN,
    availability_status VARCHAR(50),
    counter INT DEFAULT 0, -- Tracks the number of missions completed
    skill_type VARCHAR(100),
    latitude NUMERIC(9,6),
    longitude NUMERIC(9,6),
    FOREIGN KEY (latitude, longitude) REFERENCES LOCATION(latitude, longitude)
);

-- The central request table
CREATE TABLE REQUEST (
    Request_id INT PRIMARY KEY,
    date DATE NOT NULL,
    image VARCHAR(255), -- Path or URL to the incident photo
    incident_description TEXT,
    -- Constraint: Priority must be between 1 (Low) and 5 (Critical)
    prioriry_level INT CHECK (prioriry_level BETWEEN 1 AND 5),
    ContactPerson_id INT REFERENCES FAMILY(ContactPerson_id),
    Category_id INT REFERENCES REQUESTCATEGORY(Category_id),
    status_id INT REFERENCES STATUS(status_id),
    --treatment_id INT REFERENCES TREATMENT(treatment_id),
    latitude NUMERIC(9,6),
    longitude NUMERIC(9,6),
    FOREIGN KEY (latitude, longitude) REFERENCES LOCATION(latitude, longitude)
);

-- Tracks physical items being sent to a family
CREATE TABLE DELIVERY (
    delivery_id INT PRIMARY KEY,
    date DATE NOT NULL,
    status VARCHAR(50),
    item_type VARCHAR(100),
    -- Constraint: Quantity cannot be zero or negative
    quantity INT CHECK (quantity > 0),
    Request_id INT REFERENCES REQUEST(Request_id)
);

-- Records the actual action taken by a volunteer
CREATE TABLE TREATMENT (
    treatment_id INT PRIMARY KEY,
    date DATE NOT NULL,
    start_time TIME,
    completion_time TIME,
    feedback_notes TEXT,
    photo_after VARCHAR(255),
    delivery_id INT REFERENCES DELIVERY(delivery_id),
    volunteer_id INT REFERENCES VOLUNTEER(volunteer_id),
    request_id INT REFERENCES REQUEST(Request_id)

);