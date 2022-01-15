
<style>
.pagebreak { page-break-before: always; }
.half { height: 200px; }
</style>
<style>
.pagebreak { page-break-before: always; }
.half { height: 200px; }
.markdown-body {
	font-size: 12px;
}
.markdown-body td {
	font-size: 12px;
}
table {
	border: 1px solid black;
}
</style>


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

