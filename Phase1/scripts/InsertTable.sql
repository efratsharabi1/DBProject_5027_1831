-- =====================================
-- TYPE
-- =====================================
INSERT INTO TYPE VALUES
(1,'Flat Tire Assistance'),
(2,'Locked Vehicle'),
(3,'Stuck In Elevator'),
(4,'Child Locked In Car'),
(5,'Locked Home Door'),
(6,'Search And Rescue');

-- =====================================
-- CATAGORY
-- =====================================
INSERT INTO CATAGORY VALUES
(1,'Language'),
(2,'Vehicle'),
(3,'Locksmith'),
(4,'Rescue'),
(5,'Technical'),
(6,'Emergency');

-- =====================================
-- VOLUNTEER (20 רשומות)
-- =====================================
INSERT INTO VOLUNTEER VALUES
('Noa',501111111,'1998-05-10','noa@gmail.com','TelAviv',1,'2022-01-01','Levi','Y'),
('Yossi',502222222,'1995-08-21','yossi@gmail.com','Haifa',2,'2021-06-15','Cohen','Y'),
('Dana',503333333,'1999-02-14','dana@gmail.com','Jerusalem',3,'2023-03-10','Mizrahi','Y'),
('Eitan',504444444,'1992-07-30','eitan@gmail.com','Ashdod',4,'2020-04-05','Biton','N'),
('Shira',505555555,'1997-12-09','shira@gmail.com','Netanya',5,'2022-09-20','Avraham','Y'),
('Amit',506111111,'1996-03-11','amit@gmail.com','TelAviv',6,'2021-05-05','David','Y'),
('Lior',507222222,'1993-11-02','lior@gmail.com','Haifa',7,'2020-08-12','Katz','Y'),
('Rina',508333333,'2000-01-25','rina@gmail.com','Jerusalem',8,'2023-01-01','Peretz','Y'),
('Omer',509444444,'1994-09-17','omer@gmail.com','Ashkelon',9,'2022-06-10','Bar','N'),
('Tamar',501000000,'1998-12-30','tamar@gmail.com','Netanya',10,'2023-02-02','Nissan','Y'),
('Gil',502111000,'1997-04-04','gil@gmail.com','Haifa',11,'2022-05-01','Shalom','Y'),
('Adi',503222000,'1996-07-07','adi@gmail.com','TelAviv',12,'2021-03-15','Haim','Y'),
('Ron',504333000,'1993-01-10','ron@gmail.com','Jerusalem',13,'2020-09-09','Tal','N'),
('Maya',505444000,'1999-11-11','maya@gmail.com','Ashdod',14,'2023-01-20','Barak','Y'),
('Idan',506555000,'1995-06-06','idan@gmail.com','Netanya',15,'2022-08-08','Or','Y'),
('Eli',507666000,'1992-02-02','eli@gmail.com','TelAviv',16,'2020-02-02','Mor','Y'),
('Neta',508777000,'1997-06-18','neta@gmail.com','Haifa',17,'2022-04-12','Rosen','Y'),
('Gal',509888000,'1994-11-05','gal@gmail.com','Jerusalem',18,'2021-07-20','BenAmi','N'),
('Dean',501999000,'1998-08-22','dean@gmail.com','Netanya',19,'2022-10-01','Yosef','Y'),
('Yuval',502888111,'1993-09-09','yuval@gmail.com','TelAviv',20,'2020-11-11','Golan','Y');

-- =====================================
-- SKILL (15 רשומות)
-- =====================================
INSERT INTO SKILL VALUES
(1,'English speaking','N',1,'English'),
(2,'French speaking','N',2,'French'),
(3,'Tire replacement','N',3,'Tire'),
(4,'Car unlocking','N',4,'Unlock'),
(5,'Elevator rescue','Y',5,'Elevator'),
(6,'Hebrew speaking','N',1,'Hebrew'),
(7,'Arabic speaking','N',2,'Arabic'),
(8,'Basic mechanics','N',3,'Mechanics'),
(9,'Radio communication','N',2,'Radio'),
(10,'First aid','Y',4,'FirstAid'),
(11,'Navigation','N',2,'Navigation'),
(12,'Technical repair','N',3,'Technical'),
(13,'Emergency response','Y',5,'Emergency'),
(14,'Vehicle support','N',2,'Vehicle'),
(15,'Locksmith skills','N',4,'Locksmith');

-- =====================================
-- TRAINING (15 רשומות)
-- =====================================
INSERT INTO TRAINING VALUES
('BasicAid','Intro help',25,4,1),
('Locks','Vehicle lock',20,3,2),
('Elevators','Elevator rescue',15,5,3),
('ChildRescue','Child safety',18,4,4),
('SearchUnit','Search training',30,6,5),
('RoadHelp','Road assist',22,3,6),
('Medic','First aid',20,4,7),
('CarAccess','Vehicle access',18,3,8),
('HomeEntry','Door opening',15,2,9),
('LiftSafe','Lift safety',12,5,10),
('RescuePro','Rescue pro',20,6,11),
('FieldTech','Tech work',19,4,12),
('RadioUse','Radio training',28,2,13),
('Emergency1','Emergency',26,5,14),
('Navigation','Navigation',18,3,15);

-- =====================================
-- CALL (20 רשומות)
-- =====================================
INSERT INTO CALL VALUES
(34.78,'10:15','Open',1,509111111,'2026-04-10',32,'Flat tire',1),
(35.21,'11:40','Closed',2,509222222,'2026-04-10',31,'Car locked',2),
(34.99,'08:20','InProgress',3,509333333,'2026-04-11',32,'Elevator stuck',3),
(34.75,'13:05','Closed',4,509444444,'2026-04-11',32,'Child locked',4),
(35.01,'19:30','Open',5,509555555,'2026-04-12',31,'Door locked',5),
(34.80,'14:20','Open',6,508666666,'2026-04-13',32,'Flat tire',1),
(35.10,'17:45','Closed',7,508777777,'2026-04-14',31,'Car locked',2),
(34.90,'09:10','InProgress',8,508888888,'2026-04-15',32,'Elevator stuck',3),
(34.70,'20:00','Open',9,508999999,'2026-04-16',32,'Child locked',4),
(35.00,'12:30','Closed',10,509000000,'2026-04-17',31,'Door locked',5),
(34.88,'10:10','Open',11,507111111,'2026-04-18',32,'Flat tire',1),
(35.12,'11:20','Closed',12,507222222,'2026-04-18',31,'Car locked',2),
(34.95,'09:30','InProgress',13,507333333,'2026-04-19',32,'Elevator stuck',3),
(34.72,'18:00','Closed',14,507444444,'2026-04-19',32,'Child locked',4),
(35.02,'13:00','Open',15,507555555,'2026-04-20',31,'Door locked',5),
(34.81,'09:25','Open',16,507666666,'2026-04-21',32,'Flat tire',1),
(35.14,'10:40','Closed',17,507777777,'2026-04-21',31,'Car locked',2),
(34.97,'12:05','InProgress',18,507888888,'2026-04-22',32,'Elevator stuck',3),
(34.74,'14:15','Open',19,507999999,'2026-04-22',32,'Child locked',4),
(35.03,'16:20','Closed',20,508000000,'2026-04-23',31,'Door locked',5);

-- =====================================
-- קשרים
-- =====================================
INSERT INTO VOLUNTEER_SKILL VALUES
(1,1),(1,3),(2,2),(2,4),(3,5),(4,4),(5,1),
(6,6),(7,7),(8,8),(9,9),(10,10),(11,11),(12,12),
(13,13),(14,14),(15,15),(16,1),(17,2),(18,3);

INSERT INTO VOLUNTEER_CALL VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),
(6,6),(7,7),(8,8),(9,9),(10,10),
(11,11),(12,12),(13,13),(14,14),(15,15);

INSERT INTO VOLUNTEER_TRAINING VALUES
(1,1),(2,1),(2,2),(3,3),(4,3),(5,4),
(6,6),(7,6),(8,7),(9,8),(10,7),
(11,8),(12,9),(13,10),(14,11);

COMMIT;
