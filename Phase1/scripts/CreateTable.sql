CREATE TABLE VOLUNTEER
(
  First_Name VARCHAR(20) NOT NULL,
  Phone INT NOT NULL,
  Birthday DATE NOT NULL,
  Email VARCHAR(20) NOT NULL,
  City VARCHAR(20) NOT NULL,
  Volunteer_ID INT NOT NULL,
  recruitment_date DATE NOT NULL,
  Last_Name VARCHAR(20) NOT NULL,
  Is_Active CHAR(1) NOT NULL,
  PRIMARY KEY (Volunteer_ID),

  UNIQUE (Phone),
  UNIQUE (Email),

  CHECK (Is_Active IN ('Y','N')),
  CHECK (Birthday < CURRENT_DATE),
  CHECK (recruitment_date >= Birthday),
  CHECK (recruitment_date <= CURRENT_DATE)
);

CREATE TABLE SKILL
(
  Skill_ID INT NOT NULL,
  Description VARCHAR(30) NOT NULL,
  Requires_Certificate CHAR(1) NOT NULL,
  Difficulty_Level INT NOT NULL,
  Skill_Name VARCHAR(15) NOT NULL,
  PRIMARY KEY (Skill_ID),

  UNIQUE (Skill_Name),

  CHECK (Requires_Certificate IN ('Y','N')),
  CHECK (Difficulty_Level BETWEEN 1 AND 5)
);

CREATE TABLE AVAILABILITY
(
  Day_Of_Week VARCHAR(10) NOT NULL,
  Start_Time VARCHAR(5) NOT NULL,
  End_Time VARCHAR(5) NOT NULL,
  Preferred_Region_ VARCHAR(20) NOT NULL,
  Volunteer_ID INT NOT NULL,
  PRIMARY KEY (Day_Of_Week, Start_Time, Volunteer_ID),
  FOREIGN KEY (Volunteer_ID) REFERENCES VOLUNTEER(Volunteer_ID),

  CHECK (Start_Time < End_Time),
  CHECK (Day_Of_Week IN (
  'Sunday','Monday','Tuesday','Wednesday',
  'Thursday','Friday','Saturday'))
);

CREATE TABLE TYPE
(
  Type_ID INT NOT NULL,
  Type_Name VARCHAR(40) NOT NULL,
  PRIMARY KEY (Type_ID),
  UNIQUE (Type_Name),
  CHECK (Type_Name IN (
    'Flat Tire Assistance',
    'Locked Vehicle',
    'Stuck In Elevator',
    'Child Locked In Car',
    'Locked Home Door',
    'Search And Rescue'
  ))
);

CREATE TABLE CALL
(
  Longitude FLOAT NOT NULL,
  Call_Time VARCHAR(5) NOT NULL,
  Status VARCHAR(15) NOT NULL,
  Call_ID INT NOT NULL,
  Phone INT NOT NULL,
  Call_Date DATE NOT NULL,
  Latitude INT NOT NULL,
  Description VARCHAR(50) NOT NULL,
  Type_ID INT NOT NULL,
  PRIMARY KEY (Call_ID),
  FOREIGN KEY (Type_ID) REFERENCES TYPE(Type_ID),

  CHECK (Status IN ('Open','Closed','InProgress'))
);

CREATE TABLE TRAINING
(
  Training_Name VARCHAR(15) NOT NULL,
  Description_ VARCHAR(30) NOT NULL,
  Max_Participant INT NOT NULL,
  Duration_Hours INT NOT NULL,
  Training_ID INT NOT NULL,
  PRIMARY KEY (Training_ID),

  CHECK (Max_Participant > 0),
  CHECK (Duration_Hours > 0)
);

CREATE TABLE SCHEDULED
(
  Meeting_Date DATE NOT NULL,
  Start_Time VARCHAR(5) NOT NULL,
  Location VARCHAR(20) NOT NULL,
  End_Time VARCHAR(5) NOT NULL,
  Training_ID INT NOT NULL,
  PRIMARY KEY (Training_ID, Meeting_Date, Start_Time),
  FOREIGN KEY (Training_ID) REFERENCES TRAINING(Training_ID),

  CHECK (Start_Time < End_Time)
);

CREATE TABLE CATAGORY
(
  Catagory_ID INT NOT NULL,
  Catagory_Name VARCHAR(20) NOT NULL,
  PRIMARY KEY (Catagory_ID),
  UNIQUE (Catagory_Name),
  CHECK (Catagory_Name IN (
    'Language',
    'Vehicle',
    'Locksmith',
    'Rescue',
    'Technical',
    'Emergency'
  ))
);

CREATE TABLE VOLUNTEER_SKILL
(
  Volunteer_ID INT NOT NULL,
  Skill_ID INT NOT NULL,
  PRIMARY KEY (Volunteer_ID, Skill_ID),
  FOREIGN KEY (Volunteer_ID) REFERENCES VOLUNTEER(Volunteer_ID),
  FOREIGN KEY (Skill_ID) REFERENCES SKILL(Skill_ID)
);

CREATE TABLE VOLUNTEER_CALL
(
  Volunteer_ID INT NOT NULL,
  Call_ID INT NOT NULL,
  PRIMARY KEY (Volunteer_ID, Call_ID),
  FOREIGN KEY (Volunteer_ID) REFERENCES VOLUNTEER(Volunteer_ID),
  FOREIGN KEY (Call_ID) REFERENCES CALL(Call_ID)
);

CREATE TABLE VOLUNTEER_TRAINING
(
  Training_ID INT NOT NULL,
  Volunteer_ID INT NOT NULL,
  PRIMARY KEY (Training_ID, Volunteer_ID),
  FOREIGN KEY (Training_ID) REFERENCES TRAINING(Training_ID),
  FOREIGN KEY (Volunteer_ID) REFERENCES VOLUNTEER(Volunteer_ID)
);

CREATE TABLE SKILL_CATEGORY
(
  Skill_ID INT NOT NULL,
  Catagory_ID INT NOT NULL,
  PRIMARY KEY (Skill_ID, Catagory_ID),
  FOREIGN KEY (Skill_ID) REFERENCES SKILL(Skill_ID),
  FOREIGN KEY (Catagory_ID) REFERENCES CATAGORY(Catagory_ID)
);
