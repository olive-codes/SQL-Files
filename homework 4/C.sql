DROP TABLE SocialNetwork;

CREATE TABLE SocialNetwork
(
  Person       VARCHAR2(25) NOT NULL,
  Friend       VARCHAR2(25) NOT NULL
);

insert into SocialNetwork values ('Amy', 'Brad');
insert into SocialNetwork values ('Amy', 'Christine');
insert into SocialNetwork values ('Amy', 'Edgar');
insert into SocialNetwork values ('Brad', 'Fiona');
insert into SocialNetwork values ('Brad', 'Gary');
insert into SocialNetwork values ('Brad', 'Hannah');
insert into SocialNetwork values ('Christine', 'Hannah');
insert into SocialNetwork values ('Christine', 'Ingrid');
insert into SocialNetwork values ('Christine', 'Dave');
insert into SocialNetwork values ('Dave', 'Ingrid');
insert into SocialNetwork values ('Dave', 'Kate');
insert into SocialNetwork values ('Dave', 'James');
insert into SocialNetwork values ('Dave', 'Leo');
insert into SocialNetwork values ('Edgar', 'Kate');
insert into SocialNetwork values ('Edgar', 'Melissa');
insert into SocialNetwork values ('Edgar', 'Nicole');
insert into SocialNetwork values ('Fiona', 'Amy');    
insert into SocialNetwork values ('Gary', 'Oliver');
insert into SocialNetwork values ('Hannah', 'Quincey');
insert into SocialNetwork values ('James', 'Quincey');
insert into SocialNetwork values ('Melissa', 'Leo');
insert into SocialNetwork values ('Oliver', 'Fiona');
insert into SocialNetwork values ('Oliver', 'Penny');
insert into SocialNetwork values ('Quincey', 'James');

SELECT * FROM SocialNetwork;

--1 directly and transitively

WITH
    bradGraph as
    (
        SELECT Person, Friend, LEVEL as d
        FROM SocialNetwork
        START WITH Person = 'Brad'
        CONNECT BY NOCYCLE PRIOR Friend = Person
        ORDER BY d ASC
    ),
    -- 1. People Brad can reach
    bradCanReach as
    (SELECT DISTINCT(Friend) FROM bradGraph WHERE Friend != 'Brad')
    -- 2. People Brad cannot reach
    , bradCannotReach as
    (SELECT DISTINCT(Person) FROM SocialNetwork WHERE Person NOT IN (SELECT Friend FROM bradCanReach) AND Person != 'Brad')
SELECT * FROM bradCannotReach;


--3 FIX Only those people who are connected to Christine via transitive relationship i.e not an immediate follower.

WITH
    intoChristine as
    (
        SELECT Person, Friend, LEVEL as distance
        FROM SocialNetwork
        START WITH Person = 'Christine'
        CONNECT BY NOCYCLE PRIOR Person = Friend
        ORDER BY Person ASC
    ),
    minDistance as
    (
        SELECT Person, MIN(distance) as minDist FROM intoChristine  GROUP BY Person
    )
SELECT Distinct Person from minDistance WHERE minDist > 2;
   
    

--4 Find the shortest path to reach from Amy to James.
--Use transitive, not sure how to make it start from Amy and End at James
--SELECT MIN(PATH) FROM SocialNetwork;
--maybe use COUNT and then MIN on path? 

WITH 
    pathsToJames AS 
    (
    
    --Need to end with James
    SELECT Person, Friend, SYS_CONNECT_BY_PATH(Person, '<-') as thePath, LEVEL AS d 
    FROM SocialNetwork
    WHERE Person = 'Amy'
    START WITH Person = 'James'
    CONNECT BY NOCYCLE PRIOR Person = Friend
    --END WITH Person = 'Amy'
    )
SELECT thePath FROM pathsToJames ORDER BY d ASC FETCH FIRST 1 ROWS ONLY;
    
