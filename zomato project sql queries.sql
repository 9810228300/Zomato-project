use zomatoanalytics;
select * from salespeople;
set sql_safe_updates=0;
show columns from salespeople;
alter table salespeople modify comm decimal(10,5);
select * from salespeople;
alter table salespeople drop comm;
alter table salespeople add comm decimal(5,5) after city;
drop table salespeople;

-- ---Q.1--------
CREATE TABLE Salespeople (
    snum INT PRIMARY KEY,
    sname VARCHAR(100),
    city VARCHAR(50),
    comm DECIMAL(5, 2)
);
insert into Salespeople values(1001,"Peel","london",0.12),
(1002,"Serres","San jose",0.13),
(1003,"Axelord","new york",0.10),
(1004,"Motika","London",0.11),
(1007,"Rafkin","Barcelona",0.15),
(1,"null","null",null);
select * from salespeople;

-- ---Q.2----

CREATE TABLE Cust (
    cnum INT,
    cname VARCHAR(255),
    city VARCHAR(255),
    rating INT,
    snum INT
);
insert into cust values(2001,"HOffman","london",100,1001),
(2002,"Giovanne","Rome",200,1003),(2003,"Liu","San jose",300,1002),
(2004,"Grass","Berlin",100,1002),(2006,"Clemens","London",300,1007),
(2007,"Pereira","Rome",100,1004),(2008,"james","London",200,1007),(1,null,null,null,null);
select * from cust;

-- -----Q.3---------
CREATE TABLE orders (
    onum INT,
    amt DECIMAL(10,2),
    odate DATE,
    cnum INT,
    snum INT
);
insert into orders values
(3001,18.69,"1994-10-03",2008,1007),
(3002,1900.10,"1994-10-03",2007,1004),
(3003,767.19,"1994-10-03",2001,1001),
(3005,5160.45,"1994-10-03",2003,1002),
(3006,1098.16,"1994-10-04",2008,1007),
(3007,75.75,"1994-10-05",2004,1002),
(3008,4723.00,"1994-10-05",2006,1001),
(3009,1713.23,"1994-10-04",2002,1003),
(3010,1309.95,"1994-10-06",2004,1002),
(3011,9891.88,"1994-10-06",2006,1001),(null,null,null,null,null);
select * from orders;

-- ----Q.4--------

SELECT s.sname AS Salesperson, c.cname AS Customer, s.city
FROM Salespeople s
JOIN Cust c ON s.city = c.city;


-- -----Q.5---------
SELECT c.cname AS 'Customer Name', s.sname AS 'Salesperson Name'
FROM Cust c
INNER JOIN Salespeople s ON c.snum = s.snum;

-- -----Q.6--------- incomplete
select onum from orders
join cust on orders.cnum=cust.cnum
join salespeople on orders.snum=salespeople.snum
where cust.city <> salespeople.city;


-- -----Q.7---------
SELECT o.onum, c.cname
FROM orders o
JOIN Cust c ON o.cnum = c.cnum;

-- ----Q.8--------
SELECT A.cname AS 'Customer 1', B.cname AS 'Customer 2', A.rating
FROM Cust A, Cust B
WHERE A.rating = B.rating AND A.cnum < B.cnum;

-- -----Q.9-------
SELECT cname AS Customer, sname AS salespeople 
FROM Cust , Salespeople 
WHERE cname = sname;
SELECT A.cname AS Customer1, B.cname AS Customer2, A.snum
FROM Cust A, Cust B
WHERE A.snum = B.snum AND A.cnum < B.cnum;

-- -------Q.10-------
SELECT A.sname AS 'Salesperson 1', B.sname AS 'Salesperson 2', A.city
FROM Salespeople A, Salespeople B
WHERE A.city = B.city AND A.snum < B.snum;

-- -------Q.11--------
SELECT o.*
FROM orders o
JOIN Cust c ON o.cnum = c.cnum
WHERE c.snum = (
    SELECT snum
    FROM Cust
    WHERE cnum = 2008
);


-- -----Q.12---------
SELECT *
FROM orders
WHERE amt > (
    SELECT AVG(amt)
    FROM orders
    WHERE odate = '1994-10-04'
) AND odate = '1994-10-04';

-- ------Q.13-----
SELECT o.*
FROM orders o
JOIN salespeople s ON o.snum = s.snum
WHERE s.city = 'London';

-- -----Q.14-------
SELECT *
FROM Cust
WHERE cnum > (
    SELECT snum + 1000
    FROM Salespeople
    WHERE sname = 'Serres'
);


-- ----Q.15---------
SELECT COUNT(*) AS 'Number of Customers'
FROM Cust
WHERE rating > (
    SELECT AVG(rating)
    FROM Cust
    WHERE city = 'San Jose'
);

-- ------Q.16-------
SELECT s.sname, COUNT(c.cnum) AS NumberOfCustomers
FROM Salespeople s
JOIN Cust c ON s.snum = c.snum
GROUP BY s.sname
HAVING COUNT(c.cnum) > 1;



