CREATE TABLE Emps (
    empID NUMBER(12),
    ssNo NUMBER(9),
    name VARCHAR(24),
    mgrID NUMBER(12),
    
    primary key (empID),
    foreign key (mgrID) references customers(empId)
);