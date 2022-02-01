m4_include(../../../setup.m4)

# Lecture 06 - Joins

## Feb 1

![all-ven-diagrams.png](all-ven-diagrams.png)

there are 16 of them.

Let's work through all of them in PostgreSQL.

## 0 0000 - the set of NO data.

```
select 'a' as "x"
	where 1 = 2
;
```

Useful for checking if a program has a connection to the database.





## 2 0010 - Intersection of 2 sets

This is the `inner` join between 2 sets of data.

xyzzy





## 3 0011 and 6 0110 - Select from a single table. 

This is the not-joined condition.

```
select * from a;

select * from b;
```





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









## 8 1000 - Minus Operations.

(this also coves 9, 10, 11, 12, 13, 14 when the 2nd select (after the minus) is
one of the other join that we have already shown)

Remove from a fixed list a set of things

```
select phone_no
	from marketing_data
minus
	select phone_no
	from do_not_call_list
;
```



