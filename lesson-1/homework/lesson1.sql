--1. Define the following terms: data, database, relational database, and table.
--data is raw facts and figures that have meaning. It can be numbers, text, images, or any form of information.
--database is an organized collection of data that allows efficient storage, retrieval, and management.
--relational database is a type of database that stores data in tables and maintains relationships between different sets of data using keys.
--table is a structured format in a database consisting of rows and columns, where each row represents a record and each column represents a field containing specific data.
--2. List five key features of SQL Server.
--High Availability and Disaster Recovery
--Security Features
--Performance Optimization
--Performance Optimization
--Support for Multiple Data Types
--3. What are the different authentication modes available when connecting to SQL Server? (Give at least 2)
--Windows Authentication Mode
--SQL Server Authentication
--Mixed Mode Authentication
--4. Create a new database in SSMS named SchoolDB.
create database SchoolDB
--5. Write and execute a query to create a table called Students with columns: StudentID (INT, PRIMARY KEY), Name (VARCHAR(50)), Age (INT).
create table Students (StudentID int primary key, Name varchar(50), Age int)
--6. Describe the differences between SQL Server, SSMS, and SQL.
-- SQL SERVER -A relational database management system (RDBMS) developed by Microsoft.
-- SQL Server Management Studio (SSMS) - A graphical user interface (GUI) tool for managing SQL Server databases.
--SQL (Structured Query Language) - A programming language used to interact with databases.
--Hard
--7. Research and explain the different SQL commands: DQL, DML, DDL, DCL, TCL with examples.
-- DQL (data query language)-DQL commands retrieve data from the database. command is select
--DML(data manupulation language)- DML commands handle data manipulation within tables. commands are insert, update, delete
-- DDl(data definition language)- DDL commands define and modify the structure of database objects like tables, indexes, and schemas. commands are create, drop, alter and truncate 
--DCL(data control language)- DCL commands manage user permissions and access control. commands are grant(gives)  and revoke (removes)
--TCL(transaction control language)-TCL commands handle transactions in SQL. commands are begin tran, commit tran and rollback tran
--8. Write a query to insert three records into the Students table.
insert into Students Values (1,'John', 18)
insert into Students Values (2,'Joh', 15)
insert into Students Values (3,'Jo', 20)
--9. Restore AdventureWorksDW2022.bak file to your server. (write its steps to submit) You can find the database from this link :https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2022.bak
-- open laptop, turn on it. enter website and download adventure file, and then enter my computer and copy or cut adventure file and upload to backup file inside sql file inside windows. upload here: Program files->Microsoft SQL Server->MSSQL16.MSSQLSERVER-> MSSQL -> backup.
