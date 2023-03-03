CREATE TABLE Models (
    model_id number(5) primary key,
    modelBrand varchar(15),
    modelName varchar(15) 
);

CREATE TABLE Cars (
    CarID number(5) primary key,
    VIN number(10) UNIQUE,
    Color char(15),
    YearofMake number(4),
    Model_id number(5),
    foreign key (Model_id) references Models(model_id)
);

insert into Cars
    values(123, 3456783412, 'Red', 2010, 1);
insert into Cars
    values(234, 2876309034, 'Blue', 2003, 2);
            
insert into Models
    values(1, 'Toyota', 'Camry');
insert into Models
    values(2, 'Toyota', 'Camry');
    
insert into Cars
    values (235, 3456783412, 'Silver', 2010, 1);
    
DELETE FROM Model;

DROP TABLE Cars;
DROP TABLE Models;
DROP TABLE Model;
 
--i. Error starting at line : 27 in command -
--   insert into Cars
--      values (235, 3456783412, 'Silver', 2010, 1)
--   Error at Command Line : 27 Column : 13
--   Error report -
--   SQL Error: ORA-00942: table or view does not exist
--   00942. 00000 -  "table or view does not exist"
--   *Cause:    
--   *Action:

-- The error comes from the values not matching the constraints of the values for that table. 
-- In this case the VIN is not unique (same one is used)

--ii. Error starting at line : 30 in command -
--DELETE FROM Model
--Error at Command Line : 30 Column : 13
--Error report -
--SQL Error: ORA-00942: table or view does not exist
--00942. 00000 -  "table or view does not exist"
--*Cause:    
--*Action:

--This error comes from a syntax error. The table is called Models, not Model. 

--iii. Alter statements

ALTER TABLE Cars
    DROP CONSTRAINT VIN;

ALTER TABLE Models
    RENAME TO Model;
