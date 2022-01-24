
m4_include(../../../../setup.m4)

# Assignment 02 - Select data on per-capita income

## Due Feb 10
## 200 pts

Create a table that matches with the data in `clean-data.csv`.

Load the data in `clean-data.csv`  using the `load-bea-data.sql` script.

Construct a select statement that will take the data
and combine it with the county election data in
the table `election_2020` (data provided - see the lecture 2
data).

Print out 2 columns of data.    The columns should be "Winner"
and "Average Per Capita 2020 Income".

Example Output:

```
$ psql
Pager usage is off.
psql (14.0, server 13.4)
Type "help" for help.

philip=# \i ans-per-capita-by-candidate.sql
      Winner       | Average Per Capita 2020 Income
-------------------+--------------------------------
 Donald J Trump    |                       42823.50
 Joseph R Biden Jr |                      118750.50
(2 rows)
```

Formatting:  the income number is formatted using a type
cast of `::numeric(10,2)`.

To do the query you will need a table that lists the per-county
winners.

```
m4_include(per-county-winner.sql.nu)
m4_comment([[[
drop table if exists election_2020 ;
create table election_2020 (
    id           serial primary key,
    county_name  text,
    state        text,
    winner       text -- either 'Joseph R Biden Jr' or 'Donald...'
);
]]])
```

Create and populate the table with using insert/update statements.


## Turn in

1. Your insert update/statements for `election_2020`.
2. A select from `election_2020` that groups and counts the number of counties that each candidate won. (Hint: Biden won 293 counties)
Turn in the output from this select statement.
3. Your select statement that shows the average per capita income by counties that a candidate won.
The output from this select. (Hint: should match the example output above).
