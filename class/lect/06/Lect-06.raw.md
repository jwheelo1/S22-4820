m4_include(../../../setup.m4)

# Lecture 06 - Joins

## Feb 1

![all-ven-diagrams.png](all-ven-diagrams.png)

There are 16 of them.

Let's work through all of them in PostgreSQL.

Tables and data for exampels:

```
m4_include(data.sql.nu)
m4_ omment([[[

drop table if exists marketing_data ;
create table if not exists marketing_data (
	name text,
	phone_no text
);
drop table if exists do_not_call_list ;
create table if not exists do_not_call_list (
	phone_no text
);
insert into marketing_data (name, phone_no) values
	( 'philip', '720-209-7888')
	,('bob', '505-444-1212')
	,('mark', '307-338-1212')
;
insert into do_not_call_list ( phone_no ) values
	 ('505-444-1212')
;

]]])
```


The JOIN types in Postgres are

- INNER JOIN, or just JOIN - this is the most common.
- The CROSS JOIN
- The LEFT OUTER JOIN
- The RIGHT OUTER JOIN
- The FULL OUTER JOIN

and we can use them do do most of the possible ven diagrams above.
The ven diagrams that we can not do are also useful - so I will
show you all 16.

On the web: [https://www.postgresqltutorial.com/postgresql-joins/](https://www.postgresqltutorial.com/postgresql-joins/)
or [https://www.tutorialspoint.com/postgresql/postgresql_using_joins.htm](https://www.tutorialspoint.com/postgresql/postgresql_using_joins.htm)
.





m4_comment([[[ =========================================================================================== ]]])
## 0 0000 - the set of NO data.

```
select 'a' as "x"
	where 1 = 2
;
```

Useful for checking if a program has a connection to the database.






m4_comment([[[ =========================================================================================== ]]])
## 3 0011 and 6 0110 - Select from a single table. 

This is the not-joined condition.  Also see below.

```
m4_include(3.sql.nu)
m4_comment([[[

select * from marketing_data;
select * from do_not_call_list;

]]])
```

Output:

```
m4_include(3.out)
```





m4_comment([[[ =========================================================================================== ]]])
## 2 0010 - Intersection of 2 sets

This is the `inner` join between 2 sets of data.

```
m4_include(2.sql.nu)
m4_comment([[[
select name
	from marketing_data as t1
		join do_not_call_list as t2 on ( t1.phone_no = t2.phone_no)
;
]]])
```

or INNER JOIN

```
m4_include(2-inner.sql.nu)
m4_comment([[[
select name
	from marketing_data as t1
		inner join do_not_call_list as t2 on ( t1.phone_no = t2.phone_no)
;
]]])
```

or in the where clause

```
m4_include(2-where.sql.nu)
m4_comment([[[
select t1.name
	from marketing_data as t1, do_not_call_list as t2
	where t1.phone_no = t2.phone_no
;
]]])
```

Output:

```
m4_include(2.out)
```




m4_comment([[[ =========================================================================================== ]]])
## 15 - 1111 - Select with no conditions.

This is useful for doing calculations in PostgreSQL.

```
select 12 * 33;
```

(In Oracle....)

```
select 12 * 33 from dual;
```

Or generate a series:

```
SELECT generate_series(3, 100) / 3;
```









m4_comment([[[ =========================================================================================== ]]])
## 8 1000 - Except (minus) Operations.

(this also coves 9, 10, 11, 12, 13, 14 when the 2nd select (after the minus) is
one of the other join that we have already shown)

Remove from a fixed list a set of things

```
m4_include(8.sql.nu)
m4_comment([[[

select t1.phone_no
	from marketing_data as t1
except 
	select t2.phone_no
	from do_not_call_list as t2
;

]]])
```

In Oracle, DB2, MS-SQL-Server, MariaDB and mySQL:

```
m4_include(8-oracle.sql.nu)
```

This is really good for things like products that are out of stock!


Output:

```
m4_include(8.out)
```




m4_comment([[[ =========================================================================================== ]]])
## 1 0001 

This gives us just the numbes in the do-not-call list that are not in the 
set of marketing data.

```
m4_include(1.sql.nu)
m4_comment([[[
select name, when_added
	from marketing_data as t1
		right join do_not_call_list as t2 on ( t1.phone_no = t2.phone_no)
		where t1.phone_no is null 
;
]]])
```

Output:

```
m4_include(1.out)
```


m4_comment([[[ =========================================================================================== ]]])
## 4 0100 

This is like 1 or the "minus" above with the tables switched.

```
m4_include(4.sql.nu)
m4_comment([[[
select name, t1.phone_no, when_added
	from marketing_data as t1
		left join do_not_call_list as t2 on ( t1.phone_no = t2.phone_no)
		where t2.phone_no is null 
;
]]])
```

Output:

```
m4_include(4.out)
```





m4_comment([[[ =========================================================================================== ]]])
## 5 0101 


```
m4_include(5.sql.nu)
m4_comment([[[
select name
	from marketing_data as t1
		full outer join do_not_call_list as t2 on ( t1.phone_no = t2.phone_no)
		where t1.phone_no is null 
	 	   or t2.phone_no is null
;
]]])
```

Output:

```
m4_include(5.out)
```





m4_comment([[[ =========================================================================================== ]]])
## 7 0111 - full outer join


```
m4_include(7.sql.nu)
m4_comment([[[
select name
	from marketing_data as t1
		full join do_not_call_list as t2 on ( t1.phone_no = t2.phone_no)
;
]]])
```

FULL OUTER

```
m4_include(7-outer.sql.nu)
m4_comment([[[
select name
	from marketing_data as t1
		full outer join do_not_call_list as t2 on ( t1.phone_no = t2.phone_no)
;
]]])
```

Output:

```
m4_include(7.out)
```




m4_comment([[[ =========================================================================================== ]]])
## Cross Join

This is the one that is not in the VEN diagram - that is all of the left table with all of the right
table.   This is more of a "join-all-together so I can post filer" or "join-all-together so I can
construct new data from it" operation.

Given our little set of data this makes no sense.   Oh... Well...

```
m4_include(cross-join.sql.nu)
```

or (this is the way you would do this in Oracle, mySQL, MariaDB)

```
m4_include(cross-where.sql.nu)
```

Output:

```
m4_include(cross-join.out)
```



