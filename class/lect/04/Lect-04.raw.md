m4_include(../../../setup.m4)

# Lecture 04 - More Select
## Jan 27


```
Select [ Projected Columns ]
From Table ...
    join to ...
Where ...
Group By Column List
Having [ where on grouped data ]
Ordr By [ Columns ]
```


Ok....
We have looked at the projected columns and order by.


Let's use our table from last time

```
m4_include(../02/create-tables.sql.nu)
m4_comment([[[
  1: -- \c l02
  2: create table vote_by_county (
  3:     id                serial primary key,
  4:     year            int default 2021,
  5:     state            text default '--',        -- irritatingly all upper case.
  6:     state_uc        text default '--',
  7:     state_po        varchar(2) default '--',     -- Incorrectly Named Column!
  8:     county_name        text default '--',        -- irritatingly all upper case.
  9:     county_name_uc    text default '--',
 10:     county_fips        int default 0,
 11:     office            text default 'unk', 
 12:     candidate        text default 'unk', 
 13:     candidate_uc    text default 'unk', 
 14:     party            text default 'unk', 
 15:     candidatevotes    int default 0, 
 16:     totalvotes        int default 0,
 17:     version            int,
 18:     vote_mode        text
 19: );
]]])
```

Let's just insert a few rows to see how insert works:

```
m4_include(../02/insert3.sql.nu)
```


and look into the "where"

```
select id, year
	from vote_by_county 
	where county_name = 'Carbon'
;
```

or a list


```
select id, year
	from vote_by_county 
	where county_name in ( 'Carbon', 'Albeny' )
;
```

we `or` and `and`.


```
select id, year, state, county
    from vote_by_county 
	where county_name = 'Carbon'
       or county_name = 'Albeny' 
;
```

Comparison with operators

```
select id, year, state, county
    from vote_by_county 
	where version < 4
;
```

This is where other tools (ORMs, MongoDB etc) fail : they only allow you to pick stuff
that is by example, as in equal to.

```
select id, year, state, county
    from vote_by_county 
	where totalvotes != 0
;
```

To really understand this we need more than 3 rows of data.
We will have a lecture on 'copy'/'to' and 'copy'/'from' but let's load some data
from lecture 2 and start really using the where clause.

```
delete from vote_by_county ;

\COPY vote_by_county ( year, state_uc, state_po, county_name_uc, county_fips, office,
candidate_uc, party, candidatevotes, totalvotes, version, vote_mode ) FROM
'countypres_2000-2020.csv' DELIMITER ',' NULL AS 'NA' CSV HEADER;
```

Note that `\COPY` is not the same as `COPY` - and `\COPY` really has to be on
a single line.

one of the functions that we can use in the projected columns is `count(1)` or `count(*)`.  They have different performance characteristics.
```
select count(1) as "number of rows" from vote_by_county ;
```

some quick fixes - we will cover 'Update' a little later too..

```
update vote_by_county
	set state = initcap ( state_uc )
	;
update vote_by_county
	set county_name = initcap ( county_name_uc )
	;
update vote_by_county
	set candidate = initcap ( candidate_uc )
	;
```

And now back to select.  

First who ran in 2020?

```
-- get a list of candiates that ran in 2020 presidential election

select distinct t1.candidate
	from vote_by_county as t1
	where t1.year = 2020
	order by 1
	;
```

Let's take a single state/county and find the winner.

```
		select max(t2.candidatevotes) as max_votes
		from vote_by_county as t2
		where t2.state = 'Wyoming'
		  and t2.county_name = 'Albeny'
;
```

And now let's apply this for all of a single candidate.
This will give us all the counties that the candidate won.


```
m4_include(joe_biden__counties.sql)
```

And the former president

```
m4_include(dt_counties.sql)
```

