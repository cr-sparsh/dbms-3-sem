create database lab1;

use lab1;

create table student (
usn int primary key,
name varchar(100),
depid int
);


insert into student values
(3,"vivan",10),
(4,"dhrvu",20);

create table dept(
depid int primary key,
depname varchar(100)
);

insert into dept values
(10,"bca"),
(20,"bsc"),
(30,"btech");

select student.name, dept.depid 
from student
inner join dept on student.depid = dept.depid;


select * from student;