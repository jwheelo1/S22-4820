
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
  1: select state, min(year), sum(totalvotes) as state_total_votes
  2:     from vote_by_county 
  3:     where year = 2020
  4:     group by state
  5: ;

```

`group by` state showing all the candidates in each state.

```
  1: select state, candidate,  min(year), sum(candidatevotes) as votes_for_candiate, sum(totalvotes) total_votes
  2:     from vote_by_county 
  3:     where year = 2020
  4:     group by state, candidate      
  5:     order by 3, 1, 2, 4 desc
  6: ;

```

Let's group by the state and find out the set of states that each
candidate won.

```
  1: select state, candidate,  
  2:         min(year) as year,
  3:         sum(candidatevotes) as votes_for_candiate,
  4:         sum(totalvotes) total_votes, 
  5:     from vote_by_county as t1
  6:     where t1.year = 2020
  7:     group by t1.state, t1.candidate      
  8:     having sum(t1.candidatevotes) = (
  9:         select max(t3.state_total) as max_state_total 
 10:         from (
 11:             select candidate, sum(t2.candidatevotes) as state_total
 12:             from vote_by_county as t2
 13:             where t2.year = 2020
 14:               and t2.state = t1.state
 15:             group by candidate
 16:         ) as t3
 17:     )
 18:     order by 3, 1, 2, 4 desc
 19: ;

```
