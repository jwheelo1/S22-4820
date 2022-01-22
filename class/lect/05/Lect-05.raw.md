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

Let's load real data...

File: `../02/county/load_vote_by_county.sql`

```
m4_include(../02/county/load_vote_by_county.sql)
```

and the file with it wrapped so that we can read it in the `.pdf`:

```
delete from vote_by_county;
\COPY vote_by_county ( year, state_uc, state_po, county_name_uc, county_fips,
office, candidate_uc, party, candidatevotes, totalvotes, version, vote_mode )
FROM 'countypres_2000-2020.csv' DELIMITER ',' NULL AS 'NA' CSV HEADER;
```

Thins to note, the `\\` at the beginning allows us to load a file 
over a network link.  There is a `COPY` command that is local to the
server that runs only on the same machine as the database server.

The data looks like:

```
"year","state","state_po","county_name","county_fips","office","candidate","party","candidatevotes","totalvotes","version","mode"
2000,"ALABAMA","AL","AUTAUGA","1001","PRESIDENT","AL GORE","DEMOCRAT",4942,17208,20191203,"TOTAL"
2000,"ALABAMA","AL","AUTAUGA","1001","PRESIDENT","GEORGE W. BUSH","REPUBLICAN",11993,17208,20191203,"TOTAL"
2000,"ALABAMA","AL","AUTAUGA","1001","PRESIDENT","RALPH NADER","GREEN",160,17208,20191203,"TOTAL"
2000,"ALABAMA","AL","AUTAUGA","1001","PRESIDENT","OTHER","OTHER",113,17208,20191203,"TOTAL"
2000,"ALABAMA","AL","BALDWIN","1003","PRESIDENT","AL GORE","DEMOCRAT",13997,56480,20191203,"TOTAL"
2000,"ALABAMA","AL","BALDWIN","1003","PRESIDENT","GEORGE W. BUSH","REPUBLICAN",40872,56480,20191203,"TOTAL"
2000,"ALABAMA","AL","BALDWIN","1003","PRESIDENT","RALPH NADER","GREEN",1033,56480,20191203,"TOTAL"
2000,"ALABAMA","AL","BALDWIN","1003","PRESIDENT","OTHER","OTHER",578,56480,20191203,"TOTAL"
2000,"ALABAMA","AL","BARBOUR","1005","PRESIDENT","AL GORE","DEMOCRAT",5188,10395,20191203,"TOTAL"
2000,"ALABAMA","AL","BARBOUR","1005","PRESIDENT","GEORGE W. BUSH","REPUBLICAN",5096,10395,20191203,"TOTAL"
2000,"ALABAMA","AL","BARBOUR","1005","PRESIDENT","RALPH NADER","GREEN",46,10395,20191203,"TOTAL"
2000,"ALABAMA","AL","BARBOUR","1005","PRESIDENT","OTHER","OTHER",65,10395,20191203,"TOTAL"
2000,"ALABAMA","AL","BIBB","1007","PRESIDENT","AL GORE","DEMOCRAT",2710,7101,20191203,"TOTAL"
2000,"ALABAMA","AL","BIBB","1007","PRESIDENT","GEORGE W. BUSH","REPUBLICAN",4273,7101,20191203,"TOTAL"
...
```


```
select count(1) from vote_by_county;
```


And look into the "where", the group by and having clause

`group by` takes sets of data and sorts it and where there are duplicates 
it groups the data.  This allows you to calculate sum and average
over sets of data.

```
m4_include(gb1.sql.nu)
m4_comment([[[
  1: select state, min(year), sum(totalvotes) as state_total_votes
  2:     from vote_by_county 
  3:     where year = 2020
  4:     group by state
  5: ;
]]])
```

`group by` state showing all the candidates in each state.

```
m4_include(gb2.sql.nu)
m4_comment([[[
  1: select state, candidate,  min(year), sum(candidatevotes) as votes_for_candiate, sum(totalvotes) total_votes
  2:     from vote_by_county 
  3:     where year = 2020
  4:     group by state, candidate      
  5:     order by 3, 1, 2, 4 desc
  6: ;
]]])
```

Output:

```
m4_include(gb2.out)
m4_comment([[[
        state         |     candidate     | min  | votes_for_candiate | total_votes 
----------------------+-------------------+------+--------------------+-------------
 Alabama              | Donald J Trump    | 2020 |            1441170 |     2323282
 Alabama              | Joseph R Biden Jr | 2020 |             849624 |     2323282
 Alabama              | Other             | 2020 |              32488 |     2323282
 Alaska               | Donald J Trump    | 2020 |             189951 |      357569
 Alaska               | Jo Jorgensen      | 2020 |               8897 |      357569
 Alaska               | Joseph R Biden Jr | 2020 |             153778 |      357569
 Alaska               | Other             | 2020 |               4943 |      715138
 Arizona              | Donald J Trump    | 2020 |            1661686 |    10155882
 Arizona              | Jo Jorgensen      | 2020 |              51465 |    10155882
 Arizona              | Joseph R Biden Jr | 2020 |            1672143 |    10155882
 Arizona              | Other             | 2020 |                  0 |    20311764
 Arkansas             | Donald J Trump    | 2020 |             760647 |     4876276
 ...
 Vermont              | Other             | 2020 |              11684 |      741652
 Virginia             | Donald J Trump    | 2020 |            1962430 |    13386199
 Virginia             | Jo Jorgensen      | 2020 |              64761 |    13386199
 Virginia             | Joseph R Biden Jr | 2020 |            2413568 |    13386199
 Virginia             | Other             | 2020 |              21841 |    13386199
 Washington           | Donald J Trump    | 2020 |            1584651 |     4087631
 Washington           | Jo Jorgensen      | 2020 |              80500 |     4087631
 Washington           | Joseph R Biden Jr | 2020 |            2369612 |     4087631
 Washington           | Other             | 2020 |              52868 |     8175262
 West Virginia        | Donald J Trump    | 2020 |             545382 |      794652
 West Virginia        | Jo Jorgensen      | 2020 |              10687 |      794652
 West Virginia        | Joseph R Biden Jr | 2020 |             235984 |      794652
 West Virginia        | Other             | 2020 |               2599 |      794652
 Wisconsin            | Donald J Trump    | 2020 |            1610065 |     3297352
 Wisconsin            | Jo Jorgensen      | 2020 |              38491 |     3297352
 Wisconsin            | Joseph R Biden Jr | 2020 |            1630673 |     3297352
 Wisconsin            | Other             | 2020 |              18123 |     6594704
 Wyoming              | Donald J Trump    | 2020 |             193559 |      278503
 Wyoming              | Jo Jorgensen      | 2020 |               5768 |      278503
 Wyoming              | Joseph R Biden Jr | 2020 |              73491 |      278503
 Wyoming              | Other             | 2020 |               5685 |      278503
(195 rows)
]]])
```

Let's group by the state and find out the set of states that each
candidate won.

This works with "having" as a where like clause.

Also this has sub-queries.

```
m4_include(gb3.sql.nu)
```

Output:

```
m4_include(gb3.out)
m4_comment([[[
philip=# \i gb3.sql
        state         |     candidate     | year | votes_for_candiate | total_votes
----------------------+-------------------+------+--------------------+-------------
 Alabama              | Donald J Trump    | 2020 |            1441170 |     2323282
 Alaska               | Donald J Trump    | 2020 |             189951 |      357569
 Arizona              | Joseph R Biden Jr | 2020 |            1672143 |    10155882
 Arkansas             | Donald J Trump    | 2020 |             760647 |     4876276
 California           | Joseph R Biden Jr | 2020 |           11110250 |    17212389
 Colorado             | Joseph R Biden Jr | 2020 |            1804352 |     3256980
 Connecticut          | Joseph R Biden Jr | 2020 |            1080831 |     1823857
 Delaware             | Joseph R Biden Jr | 2020 |             296268 |      504010
 District Of Columbia | Joseph R Biden Jr | 2020 |             317323 |      344356
 Florida              | Donald J Trump    | 2020 |            5668731 |    11067456
 Georgia              | Joseph R Biden Jr | 2020 |            2474507 |    19993928
 Hawaii               | Joseph R Biden Jr | 2020 |             366127 |      574457
 Idaho                | Donald J Trump    | 2020 |             554119 |      867361
 Illinois             | Joseph R Biden Jr | 2020 |            3471915 |     6033744
 Indiana              | Donald J Trump    | 2020 |            1729519 |     3033121
 Iowa                 | Donald J Trump    | 2020 |             902009 |     3381742
 Kansas               | Donald J Trump    | 2020 |             771406 |     1372303
 Kentucky             | Donald J Trump    | 2020 |            1326418 |     2134996
 Louisiana            | Donald J Trump    | 2020 |            1255776 |     2148062
 Maine                | Joseph R Biden Jr | 2020 |             430473 |      822534
 Maryland             | Joseph R Biden Jr | 2020 |            1985023 |    15185155
 Massachusetts        | Joseph R Biden Jr | 2020 |            2382202 |     3658005
 Michigan             | Joseph R Biden Jr | 2020 |            2804040 |     5539302
 Minnesota            | Joseph R Biden Jr | 2020 |            1717077 |     3277171
 Mississippi          | Donald J Trump    | 2020 |             756764 |     1313759
 Missouri             | Donald J Trump    | 2020 |            1718736 |     3025962
 Montana              | Donald J Trump    | 2020 |             343602 |      603640
 Nebraska             | Donald J Trump    | 2020 |             556846 |      951712
 Nevada               | Joseph R Biden Jr | 2020 |             703314 |     1404911
 New Hampshire        | Joseph R Biden Jr | 2020 |             424937 |      803833
 New Jersey           | Joseph R Biden Jr | 2020 |            2608335 |     4549353
 New Mexico           | Joseph R Biden Jr | 2020 |             501614 |      923965
 New York             | Joseph R Biden Jr | 2020 |            5230985 |     8661735
 North Carolina       | Donald J Trump    | 2020 |            2758773 |    22099208
 North Dakota         | Donald J Trump    | 2020 |             235595 |      361819
 Ohio                 | Donald J Trump    | 2020 |            3154834 |     5922202
 Oklahoma             | Donald J Trump    | 2020 |            1020280 |     4682097
 Oregon               | Joseph R Biden Jr | 2020 |            1340383 |     2374321
 Pennsylvania         | Joseph R Biden Jr | 2020 |            3458229 |     6915283
 Rhode Island         | Joseph R Biden Jr | 2020 |             307486 |      517757
 South Carolina       | Donald J Trump    | 2020 |            1385103 |    15079974
 South Dakota         | Donald J Trump    | 2020 |             261043 |      422609
 Tennessee            | Donald J Trump    | 2020 |            1852475 |     3053851
 Texas                | Donald J Trump    | 2020 |            5890347 |    11315056
 Utah                 | Donald J Trump    | 2020 |             865139 |     5434835
 Vermont              | Joseph R Biden Jr | 2020 |             242826 |      370826
 Virginia             | Joseph R Biden Jr | 2020 |            2413568 |    13386199
 Washington           | Joseph R Biden Jr | 2020 |            2369612 |     4087631
 West Virginia        | Donald J Trump    | 2020 |             545382 |      794652
 Wisconsin            | Joseph R Biden Jr | 2020 |            1630673 |     3297352
 Wyoming              | Donald J Trump    | 2020 |             193559 |      278503
(51 rows)
]]])
```
