m4_include(../../setup.m4)

# Assignment 01 

200: Pts

Due:  Jan 25, 2022

Install PostgreSQL and your Virtual System

Create a table `hw` and insert a row into it.

```
$ psql
philip=> create table hw ( n int );
TABLE CREATED
philip=> insert into hw ( n ) values ( 3 );
INSERT 0 1
philip=> select * from hw;
 n 
---
 3
(1 row)
philip=> \q
$
```

Turn in - a image screen capture of your running `psql`
from your account on the virtual system.

