CREATE TABLE customers (
    customerid NUMBER(3),
    name VARCHAR(25),
    address VARCHAR(50),
    
    primary key (customerid)
);

CREATE TABLE orders (
    orderid NUMBER(5),
    orderdate date,
    customerid NUMBER(3),
    
    primary key (orderid),
    foreign key (customerid) references customers(customerid)
);

CREATE TABLE products (
    productid NUMBER(2),
    description VARCHAR(28),
    finish VARCHAR(10),
    price FLOAT,
    
    primary key (productid)
);

CREATE TABLE requests (
    orderid NUMBER(5),
    productid NUMBER(2),
    quantity INTEGER,
    
    foreign key (orderid) references orders(orderid),
    foreign key (productid) references products(productid)
);

insert into customers
    values(2, 'CASUAL FURNITURE', 'PLANO, TX');
insert into customers
    values(6, 'MOUNTAIN GALLERY', 'BOULDER, CO');
    
insert into orders
    values(1006, '24-mar-10', 2);
insert into orders
    values(1007, '25-mar-10', 6);
insert into orders
    values(1008, '25-mar-10', 6);
insert into orders
    values(1009, '26-mar-10', 2);
    
insert into products
    values(10, 'WRITING DESK', 'OAK', 425);
insert into products
    values(30, 'DINING TABLE', 'ASH', null);
insert into products
    values(40, 'ENTERTAINMENT CENTER', 'MAPLE', 650);
insert into products
    values(70, 'CHILDRENS DRESSER', 'PINE', 300);
    
insert into requests
    values(1006, 10, 4);
insert into requests
    values(1006, 30, 2);
insert into requests
    values(1006, 40, 1);
insert into requests
    values(1007, 40, 3);
insert into requests
    values(1007, 70, 2);
insert into requests
    values(1008, 70, 1);
insert into requests
    values(1009, 10, 2);
insert into requests
    values(1009, 40, 1);
    
select * from customers;
select * from orders;
select * from products;
select * from requests;

drop table customers;
drop table orders;
drop table products;
drop table requests;