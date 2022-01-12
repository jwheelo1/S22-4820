m4_include(../../../setup.m4)

# Lecture 05 - More Select
## Feb 1



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
create table vote_by_county (
    id             serial primary key,
    year           int default 2021,
    state          text default '--',        -- irritatingly all upper case.
    state_uc       text default '--',
    state_po       varchar(2) default '--',     -- Incorrectly Named Column!
    county_name    text default '--',        -- irritatingly all upper case.
    county_name_uc text default '--',
    county_fips    int default 0,
    office         text default 'unk', 
    candidate      text default 'unk', 
    candidate_uc   text default 'unk', 
    party          text default 'unk', 
    candidatevotes int default 0, 
    totalvotes     int default 0,
    version        int,
    vote_mode      text
);
```

Let's just insert a few rows to see how insert works:

```
insert into vote_by_county  ( year, state, county_name, version ) values
    ( 2022, 'Wyoming', 'Albeny',   1 );
insert into vote_by_county  ( year, state, county_name, version ) values
    ( 2022, 'Wyoming', 'Big Horn', 2 );
insert into vote_by_county  ( year, state, county_name, version ) values
    ( 2022, 'Wyoming', 'Carbon',   8 );
```


And look into the "where", the group by and having clause

`group by` takes sets of data and sorts it and where there are duplicates 
it groups the data.  This allows you to calculate sum and average
over sets of data.

```
m4_include(gb1.sql.nu)
```

`group by` state showing all the candidates in each state.

```
m4_include(gb2.sql.nu)
```

Let's group by the state and find out the set of states that each
candidate won.

This works with "having" as a where like clause.

Also this has sub-queries.

```
m4_include(gb3.sql.nu)
```

