--  Explain at least two ways to find distinct values based on two columns.
create  table InputTbl (Col1 varchar(10),col2 varchar (10));
insert into inputTbl values ('a','b')
insert into inputTbl values ('a','b')
insert into inputTbl values ('b','a')
insert into inputTbl values ('c','d')
insert into inputTbl values ('c','d')
insert into inputTbl values ('m','n')
insert into inputTbl values ('n','m')
select Distinct least(Col1,col2) as col1, greatest(col1,col2) as col2 from InputTbl
select distinct
case 
when col1<col2 then col1 else col2 end as col1,
case 
when col1<col2 then col2 else col1 end as col2
from InputTbl

-- If all the columns have zero values, then don’t show that row. In this case, we have to remove the 5th row while selecting data.
CREATE TABLE TestMultipleZero (
    A INT NULL,
    B INT NULL,
    C INT NULL,
    D INT NULL
);

INSERT INTO TestMultipleZero(A,B,C,D)
VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0);
	select * from TestMultipleZero
where A<>0 or B<>0 or C<>0 or D<>0 

create table section1(id int, name varchar(20))
insert into section1 values (1, 'Been'),
       (2, 'Roma'),
       (3, 'Steven'),
       (4, 'Paulo'),
       (5, 'Genryh'),
       (6, 'Bruno'),
       (7, 'Fred'),
       (8, 'Andro')
	   select * from section1
	   where id% 2 <> 0
	   select MIN(id) from section1
	   select MAX(id) from section1
	   select * from section1
	   where name like 'b%'
-- 
	   CREATE TABLE ProductCodes (
    Code VARCHAR(20)
);

INSERT INTO ProductCodes (Code) VALUES
('X-123'),
('X_456'),
('X#789'),
('X-001'),
('X%202'),
('X_ABC'),
('X#DEF'),
('X-999');

select * from ProductCodes
where Code like '%A_%' escape 'A'


