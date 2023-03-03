
-- Drop all the tables to clean up
DROP TABLE Handles;
DROP TABLE Animal;
DROP TABLE ZooKeeper;

CREATE TABLE ZooKeeper
(
  ZID        NUMBER(3,0),
  ZName       VARCHAR2(25) NOT NULL,
  HourlyRate NUMBER(6, 2) NOT NULL,
  
  CONSTRAINT ZooKeeper_PK
     PRIMARY KEY(ZID)
);


-- ACategory: Animal category 'common', 'rare', 'exotic'.  May be NULL
-- TimeToFeed: Time it takes to feed the animal (hours)
CREATE TABLE Animal
(
  AID       NUMBER(3, 0),
  AName      VARCHAR(30) NOT NULL,
  ACategory VARCHAR(18),
  
  TimeToFeed NUMBER(4,2),  
  
  CONSTRAINT Animal_PK
    PRIMARY KEY(AID)
);


CREATE TABLE Handles
(
  ZooKeepID      NUMBER(3,0),
  AnimalID     NUMBER(3,0),
  
  Assigned     DATE,
  
  CONSTRAINT Handles_PK
    PRIMARY KEY(ZooKeepID, AnimalID),
    
  CONSTRAINT Handles_FK1
    FOREIGN KEY(ZooKeepID)
      REFERENCES ZooKeeper(ZID),
      
  CONSTRAINT Handles_FK2
    FOREIGN KEY(AnimalID)
      REFERENCES Animal(AID)
);


INSERT INTO ZooKeeper VALUES (1, 'Jim Carrey', 500);
INSERT INTO ZooKeeper VALUES (2, 'Tina Fey', 350);  
INSERT INTO ZooKeeper VALUES (3, 'Rob Schneider', 250);
  
INSERT INTO Animal VALUES(1, 'Galapagos Penguin', 'exotic', 0.5);
INSERT INTO Animal VALUES(2, 'Emperor Penguin', 'rare', 0.75);

INSERT INTO Animal VALUES(3, 'Sri Lankan sloth bear', 'exotic', 2.5);
INSERT INTO Animal VALUES(4, 'Grizzly bear', 'common', 3.0);
INSERT INTO Animal VALUES(5, 'Giant Panda bear', 'exotic', 1.5);
INSERT INTO Animal VALUES(6, 'Florida black bear', 'rare', 1.75);

INSERT INTO Animal VALUES(7, 'Siberian tiger', 'rare', 3.5);
INSERT INTO Animal VALUES(8, 'Bengal tiger', 'common', 2.75);
INSERT INTO Animal VALUES(9, 'South China tiger', 'exotic', 2.25);

INSERT INTO Animal VALUES(10, 'Alpaca', 'common', 0.25);
INSERT INTO Animal VALUES(11, 'Llama', NULL, 3.5);



INSERT INTO Handles VALUES(1, 1, '01-Jan-2000');
INSERT INTO Handles VALUES(1, 2, '02-Jan-2000');
INSERT INTO Handles VALUES(1, 10, '01-Jan-2000');

INSERT INTO Handles VALUES(2, 3, '02-Jan-2000');
INSERT INTO Handles VALUES(2, 4, '04-Jan-2000');
INSERT INTO Handles VALUES(2, 5, '03-Jan-2000');

INSERT INTO Handles VALUES(3, 7, '01-Jan-2000');
INSERT INTO Handles VALUES(3, 8, '03-Jan-2000');
INSERT INTO Handles VALUES(3, 9, '05-Jan-2000');
INSERT INTO Handles Values(3, 10,'04-Jan-2000');

--1
SELECT SUM(TimeToFeed) as totalTimeToFeedRare FROM Animal WHERE ACategory = 'rare' GROUP BY ACategory;
--2 FIX? Should there be no animal Need to check. Checked there are none. There is one equal to but question says larger
SELECT AName, TimeToFeed FROM Animal WHERE TimeToFeed > (SELECT MAX(TimeToFeed) FROM Animal WHERE ACategory = 'rare');
--3 handling at least 4 animals
SELECT DISTINCT ZName FROM ZooKeeper, Handles WHERE ZooKeeper.ZID = Handles.ZooKeepID GROUP BY Zname HAVING COUNT (ZName) >= 4;
--4 Find the names of the animals that are not related to the bear.
SELECT DISTINCT AName FROM Animal WHERE AName NOT LIKE '%bear%';
--5 List zookeepers earning the most while feeding animals. FIX? MAX of Max Rate
--SELECT Max(Sum(ZooKeeper.HourlyRate * Animal.TimeToFeed)) as MaxRate FROM Handles LEFT JOIN ZooKeeper ON Handles.ZooKeepID = ZooKeeper.ZID LEFT JOIN Animal ON Animal.AID = Handles.AnimalID GROUP BY Handles.ZooKeepID;

SELECT * FROM
    (SELECT ZooKeeper.ZID, ZooKeeper.ZName, Sum(ZooKeeper.HourlyRate * Animal.TimeToFeed) as pay 
            FROM Handles 
            LEFT JOIN ZooKeeper ON Handles.ZooKeepID = ZooKeeper.ZID 
            LEFT JOIN Animal ON Animal.AID = Handles.AnimalID 
            GROUP BY ZooKeeper.ZName, ZooKeeper.ZID)
    WHERE pay IN
       (SELECT Max(Sum(ZooKeeper.HourlyRate * Animal.TimeToFeed)) 
            FROM Handles 
            LEFT JOIN ZooKeeper ON Handles.ZooKeepID = ZooKeeper.ZID 
            LEFT JOIN Animal ON Animal.AID = Handles.AnimalID 
            GROUP BY ZooKeeper.ZName, ZooKeeper.ZID)
        ;