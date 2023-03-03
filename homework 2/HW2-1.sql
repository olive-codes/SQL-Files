CREATE TABLE Customer (
    cID NUMBER(3),
    cName VARCHAR(10), 
    cCreditPoint NUMBER(5),
    
    primary key (cID)
);

insert into Customer 
    values(110, 'Phil', 10);
insert into Customer 
    values(111, 'Louis', 21);
insert into Customer 
    values(112, 'John', 90);
insert into Customer 
    values(113, 'Tom', 6);
insert into Customer 
    values(114, 'Yay', 80);
insert into Customer 
    values(115, 'Maria', 110);
insert into Customer 
    values(116, 'Ana', 30);
insert into Customer 
    values(117, 'Antonio', 90);
insert into Customer 
    values(118, 'Andrew', 15);
insert into Customer 
    values(119, 'Shawn', 10);
    
CREATE TABLE cusOrder (
    oID NUMBER(4),
    c_ID NUMBER(3), 
    oTotal FLOAT,
    
    foreign key (c_ID) references Customer(cID)
);

insert into cusOrder 
    values(1000, 115, 126.55);
insert into cusOrder 
    values(1001, 114, 26.50);
insert into cusOrder 
    values(1002, 117, 106.45);
insert into cusOrder
    values(1003, 118, 90.74);
insert into cusOrder
    values(1004, 112, 6.35);
insert into cusOrder
    values(1005, 114, 305.92);
insert into cusOrder
    values(1006, 111, 3.15);
insert into cusOrder
    values(1007, 110, 80.60);
insert into cusOrder
    values(1008, 115, 66.29);
insert into cusOrder
    values(1009, 117, 226.45);

SELECT cCreditPoint*2 FROM Customer;
SELECT * FROM Customer ORDER BY cCreditPoint ASC, cID ASC; 
SELECT c_ID, SUM(oTotal) AS oTotal FROM cusOrder GROUP BY c_ID;
SELECT c.cID, Max(o.oTotal) AS oTotal FROM Customer c LEFT JOIN cusOrder o ON c.cID = o.c_ID GROUP BY c.cID; 
SELECT * FROM Customer c LEFT JOIN cusOrder o ON c.cID = o.c_ID; -- tuple f
SELECT * FROM cusOrder o LEFT JOIN Customer c ON o.c_ID = c.cID; -- tuple g
SELECT * FROM Customer c LEFT JOIN cusOrder o ON c.cID = o.c_ID WHERE c.cCreditpoint > o.oTotal; -- tuple h

drop table Customer;
drop table CustomerOrder;
    