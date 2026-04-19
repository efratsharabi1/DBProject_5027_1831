-- =====================
-- TYPE 
-- =====================
INSERT INTO TYPE VALUES
(1, 'Flat Tire Assistance'),
(2, 'Locked Vehicle'),
(3, 'Stuck In Elevator'),
(4, 'Child Locked In Car'),
(5, 'Locked Home Door'),
(6, 'Search And Rescue');

-- =====================
-- CATAGORY
-- =====================
INSERT INTO CATAGORY VALUES
(1, 'Language'),
(2, 'Vehicle'),
(3, 'Locksmith'),
(4, 'Rescue'),
(5, 'Technical'),
(6, 'Emergency');

-- =====================
-- VOLUNTEER
-- =====================
INSERT INTO VOLUNTEER VALUES
('Noa', 501111111, '1998-05-10', 'noa@gmail.com', 'TelAviv', 1, '2022-01-01', 'Levi', 'Y'),
('Yossi', 502222222, '1995-08-21', 'yossi@gmail.com', 'Haifa', 2, '2021-06-15', 'Cohen', 'Y'),
('Dana', 503333333, '1999-02-14', 'dana@gmail.com', 'Jerusalem', 3, '2023-03-10', 'Mizrahi', 'Y'),
('Eitan', 504444444, '1992-07-30', 'eitan@gmail.com', 'Ashdod', 4, '2020-04-05', 'Biton', 'N'),
('Shira', 505555555, '1997-12-09', 'shira@gmail.com', 'Netanya', 5, '2022-09-20', 'Avraham', 'Y');

-- =====================
-- SKILL
-- =====================
INSERT INTO SKILL VALUES
(1, 'English speaking', 'N', 1, 'English'),
(2, 'French speaking', 'N', 2, 'French'),
(3, 'Tire replacement', 'N', 3, 'Tire'),
(4, 'Car unlocking', 'N', 4, 'Unlock'),
(5, 'Elevator rescue', 'Y', 5, 'Elevator');

-- =====================
-- TRAINING
-- =====================
INSERT INTO TRAINING VALUES
('BasicAid', 'Intro help course', 25, 4, 1),
('Locks', 'Vehicle lock training', 20, 3, 2),
('Elevators', 'Elevator rescue', 15, 5, 3),
('ChildRescue', 'Child safety training', 18, 4, 4),
('SearchUnit', 'Search training', 30, 6, 5);

-- =====================
-- AVAILABILITY
-- =====================
INSERT INTO AVAILABILITY VALUES
('Sunday', '08:00', '12:00', 'Center', 1),
('Monday', '14:00', '18:00', 'North', 2),
('Tuesday', '09:00', '13:00', 'Jerusalem', 3),
('Wednesday', '16:00', '20:00', 'South', 4),
('Thursday', '10:00', '15:00', 'Sharon', 5);

-- =====================
-- CALL
-- =====================
INSERT INTO CALL VALUES
(34.78, '10:15', 'Open', 1, 509111111, '2026-04-10', 32, 'Flat tire on road', 1),
(35.21, '11:40', 'Closed', 2, 509222222, '2026-04-10', 31, 'Car locked in parking', 2),
(34.99, '08:20', 'InProgress', 3, 509333333, '2026-04-11', 32, 'People stuck elevator', 3),
(34.75, '13:05', 'Closed', 4, 509444444, '2026-04-11', 32, 'Child locked car', 4),
(35.01, '19:30', 'Open', 5, 509555555, '2026-04-12', 31, 'Door locked at home', 5);

-- =====================
-- SCHEDULED
-- =====================
INSERT INTO SCHEDULED VALUES
('2026-05-01', '09:00', 'TelAviv', '13:00', 1),
('2026-05-03', '10:00', 'Haifa', '13:00', 2),
('2026-05-05', '08:30', 'Jerusalem', '13:30', 3),
('2026-05-07', '09:00', 'Ashdod', '13:00', 4),
('2026-05-09', '08:00', 'Netanya', '14:00', 5);

-- =====================
-- קשרים
-- =====================

INSERT INTO VOLUNTEER_SKILL VALUES
(1,1),(1,3),(2,2),(2,4),(3,5),(4,4),(5,1);

INSERT INTO VOLUNTEER_TRAINING VALUES
(1,1),(2,1),(2,2),(3,3),(4,3),(5,4);

INSERT INTO SKILL_CATEGORY VALUES
(1,1),(2,1),(3,2),(4,3),(5,4);

INSERT INTO VOLUNTEER_CALL VALUES
(1,1),(2,2),(3,3),(4,4),(5,5);

COMMIT;
