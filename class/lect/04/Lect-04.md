
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


# Lecture 04 - More Select
## Thu Jan 27 2022

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
  1: \c l02
  2: create table vote_by_county (
  3:     id             serial primary key,
  4:     year           int default 2021,
  5:     state          text default '--',        -- irritatingly all upper case.
  6:     state_uc       text default '--',
  7:     state_po       varchar(2) default '--',     -- Incorrectly Named Column!
  8:     county_name    text default '--',        -- irritatingly all upper case.
  9:     county_name_uc text default '--',
 10:     county_fips    int default 0,
 11:     office         text default 'unk', 
 12:     candidate      text default 'unk', 
 13:     candidate_uc   text default 'unk', 
 14:     party          text default 'unk', 
 15:     candidatevotes int default 0, 
 16:     totalvotes     int default 0,
 17:     version        int,
 18:     vote_mode      text
 19: );


```

Let's just insert a few rows to see how insert works:

```
  1: -- \c l02
  2: 
  3: insert into vote_by_county  ( year, state, county_name, version ) values
  4:     ( 2022, 'Wyoming', 'Albeny',   1 );
  5: insert into vote_by_county  ( year, state, county_name, version ) values
  6:     ( 2022, 'Wyoming', 'Big Horn', 2 );
  7: insert into vote_by_county  ( year, state, county_name, version ) values
  8:     ( 2022, 'Wyoming', 'Carbon',   8 );

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

## Update

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

## And now back to select and operators 

And now let's apply this for all of a single candidate.
This will give us all the counties that the candidate won.


```
  1: 
  2: -- Find the set of counties that voted for "Sleepy Joe" in 2020
  3: 
  4: select t1.state, t1.county_name
  5: from vote_by_county as t1
  6: where t1.year = 2020
  7:     and t1.candidate = 'Joseph R Biden Jr'
  8:     and t1.candidatevotes = (
  9:         select max(t2.candidatevotes) as max_votes
 10:         from vote_by_county as t2
 11:         where t2.state = t1.state
 12:           and t2.county_name = t1.county_name
 13:     )
 14:     order by state, county_name
 15:     ;

```

And the former president

```
  1: select t1.state, t1.county_name
  2: from vote_by_county as t1
  3: where t1.year = 2020
  4:     and t1.candidate = 'Donald J Trump'
  5:     and t1.candidatevotes = (
  6:         select max(t2.candidatevotes) as max_votes
  7:         from vote_by_county as t2
  8:         where t2.state = t1.state
  9:           and t2.county_name = t1.county_name
 10:     )
 11:     order by state, county_name
 12: ;

```


## Operators

[https://www.postgresql.org/docs/9.0/functions.html](https://www.postgresql.org/docs/9.0/functions.html)

There are lots!

<div class="pagebreak"></div>

<table border="1" class="CALSTABLE">
      <colgroup><col>
      <col>
      <col>
      <col>
      </colgroup><thead>
        <tr>
          <th>Operator</th>
          <th>Description</th>
          <th>Example</th>
          <th>Result</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><tt class="LITERAL">+</tt></td>
          <td>addition</td>
          <td><tt class="LITERAL">2 + 3</tt></td>
          <td><tt class="LITERAL">5</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL">-</tt></td>
          <td>subtraction</td>
          <td><tt class="LITERAL">2 - 3</tt></td>
          <td><tt class="LITERAL">-1</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL">*</tt></td>
          <td>multiplication</td>
          <td><tt class="LITERAL">2 * 3</tt></td>
          <td><tt class="LITERAL">6</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL">/</tt></td>
          <td>division (integer division truncates the result)</td>
          <td><tt class="LITERAL">4 / 2</tt></td>
          <td><tt class="LITERAL">2</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL">%</tt></td>
          <td>modulo (remainder)</td>
          <td><tt class="LITERAL">5 % 4</tt></td>
          <td><tt class="LITERAL">1</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL">^</tt></td>
          <td>exponentiation</td>
          <td><tt class="LITERAL">2.0 ^ 3.0</tt></td>
          <td><tt class="LITERAL">8</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL">|/</tt></td>
          <td>square root</td>
          <td><tt class="LITERAL">|/ 25.0</tt></td>
          <td><tt class="LITERAL">5</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL">||/</tt></td>
          <td>cube root</td>
          <td><tt class="LITERAL">||/ 27.0</tt></td>
          <td><tt class="LITERAL">3</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL">!</tt></td>
          <td>factorial</td>
          <td><tt class="LITERAL">5 !</tt></td>
          <td><tt class="LITERAL">120</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL">!!</tt></td>
          <td>factorial (prefix operator)</td>
          <td><tt class="LITERAL">!! 5</tt></td>
          <td><tt class="LITERAL">120</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL">@</tt></td>
          <td>absolute value</td>
          <td><tt class="LITERAL">@ -5.0</tt></td>
          <td><tt class="LITERAL">5</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL">&amp;</tt></td>
          <td>bitwise AND</td>
          <td><tt class="LITERAL">91 &amp; 15</tt></td>
          <td><tt class="LITERAL">11</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL">|</tt></td>
          <td>bitwise OR</td>
          <td><tt class="LITERAL">32 | 3</tt></td>
          <td><tt class="LITERAL">35</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL">#</tt></td>
          <td>bitwise XOR</td>
          <td><tt class="LITERAL">17 # 5</tt></td>
          <td><tt class="LITERAL">20</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL">~</tt></td>
          <td>bitwise NOT</td>
          <td><tt class="LITERAL">~1</tt></td>
          <td><tt class="LITERAL">-2</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL">&lt;&lt;</tt></td>
          <td>bitwise shift left</td>
          <td><tt class="LITERAL">1 &lt;&lt; 4</tt></td>
          <td><tt class="LITERAL">16</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL">&gt;&gt;</tt></td>
          <td>bitwise shift right</td>
          <td><tt class="LITERAL">8 &gt;&gt; 2</tt></td>
          <td><tt class="LITERAL">2</tt></td>
        </tr>
      </tbody>
  <table>


<div class="pagebreak"></div>

### string operations

<table border="1" class="CALSTABLE">
      <colgroup><col>
      <col>
      <col>
      <col>
      <col>
      </colgroup><thead>
        <tr>
          <th>Function</th>
          <th>Return Type</th>
          <th>Description</th>
          <th>Example</th>
          <th>Result</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><tt class="LITERAL"><tt class="PARAMETER">string</tt>
          <tt class="LITERAL">||</tt> <tt class="PARAMETER">string</tt></tt></td>
          <td><tt class="TYPE">text</tt></td>
          <td>String concatenation</td>
          <td><tt class="LITERAL">'Post' || 'greSQL'</tt></td>
          <td><tt class="LITERAL">PostgreSQL</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL"><tt class="PARAMETER">string</tt>
          <tt class="LITERAL">||</tt> <tt class="PARAMETER">non-string</tt></tt> or <tt class="LITERAL"><tt class="PARAMETER">non-string</tt>
          <tt class="LITERAL">||</tt> <tt class="PARAMETER">string</tt></tt></td>
          <td><tt class="TYPE">text</tt></td>
          <td>String concatenation with one non-string input</td>
          <td><tt class="LITERAL">'Value: ' || 42</tt></td>
          <td><tt class="LITERAL">Value: 42</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL"><code class="FUNCTION">bit_length(<tt class="PARAMETER">string</tt>)</code></tt></td>
          <td><tt class="TYPE">int</tt></td>
          <td>Number of bits in string</td>
          <td><tt class="LITERAL">bit_length('jose')</tt></td>
          <td><tt class="LITERAL">32</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL"><code class="FUNCTION">char_length(<tt class="PARAMETER">string</tt>)</code></tt> or <tt class="LITERAL"><code class="FUNCTION">character_length(<tt class="PARAMETER">string</tt>)</code></tt></td>
          <td><tt class="TYPE">int</tt></td>
          <td>Number of characters in string</td>
          <td><tt class="LITERAL">char_length('jose')</tt></td>
          <td><tt class="LITERAL">4</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL"><code class="FUNCTION">lower(<tt class="PARAMETER">string</tt>)</code></tt></td>
          <td><tt class="TYPE">text</tt></td>
          <td>Convert string to lower case</td>
          <td><tt class="LITERAL">lower('TOM')</tt></td>
          <td><tt class="LITERAL">tom</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL"><code class="FUNCTION">octet_length(<tt class="PARAMETER">string</tt>)</code></tt></td>
          <td><tt class="TYPE">int</tt></td>
          <td>Number of bytes in string</td>
          <td><tt class="LITERAL">octet_length('jose')</tt></td>
          <td><tt class="LITERAL">4</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL"><code class="FUNCTION">overlay(<tt class="PARAMETER">string</tt>
          placing <tt class="PARAMETER">string</tt> from <tt class="TYPE">int</tt> [<span class="OPTIONAL">for <tt class="TYPE">int</tt></span>])</code></tt></td>
          <td><tt class="TYPE">text</tt></td>
          <td>Replace substring</td>
          <td><tt class="LITERAL">overlay('Txxxxas' placing 'hom'
          from 2 for 4)</tt></td>
          <td><tt class="LITERAL">Thomas</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL"><code class="FUNCTION">position(<tt class="PARAMETER">substring</tt>
          in <tt class="PARAMETER">string</tt>)</code></tt></td>
          <td><tt class="TYPE">int</tt></td>
          <td>Location of specified substring</td>
          <td><tt class="LITERAL">position('om' in
          'Thomas')</tt></td>
          <td><tt class="LITERAL">3</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL"><code class="FUNCTION">substring(<tt class="PARAMETER">string</tt>
          [<span class="OPTIONAL">from <tt class="TYPE">int</tt></span>] [<span class="OPTIONAL">for
          <tt class="TYPE">int</tt></span>])</code></tt></td>
          <td><tt class="TYPE">text</tt></td>
          <td>Extract substring</td>
          <td><tt class="LITERAL">substring('Thomas' from 2 for
          3)</tt></td>
          <td><tt class="LITERAL">hom</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL"><code class="FUNCTION">substring(<tt class="PARAMETER">string</tt>
          from <tt class="REPLACEABLE c3">pattern</tt>)</code></tt></td>
          <td><tt class="TYPE">text</tt></td>
          <td>Extract substring matching POSIX regular expression.
          See <a href="functions-matching.html">Section 9.7</a> for
          more information on pattern matching.</td>
          <td><tt class="LITERAL">substring('Thomas' from
          '...$')</tt></td>
          <td><tt class="LITERAL">mas</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL"><code class="FUNCTION">substring(<tt class="PARAMETER">string</tt>
          from <tt class="REPLACEABLE c3">pattern</tt> for
          <tt class="REPLACEABLE c3">escape</tt>)</code></tt></td>
          <td><tt class="TYPE">text</tt></td>
          <td>Extract substring matching <acronym class="ACRONYM">SQL</acronym> regular expression. See <a href="functions-matching.html">Section 9.7</a> for more
          information on pattern matching.</td>
          <td><tt class="LITERAL">substring('Thomas' from
          '%#"o_a#"_' for '#')</tt></td>
          <td><tt class="LITERAL">oma</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL"><code class="FUNCTION">trim([<span class="OPTIONAL">leading |
          trailing | both</span>] [<span class="OPTIONAL"><tt class="PARAMETER">characters</tt></span>]
          from <tt class="PARAMETER">string</tt>)</code></tt></td>
          <td><tt class="TYPE">text</tt></td>
          <td>Remove the longest string containing only the
          <tt class="PARAMETER">characters</tt> (a space by
          default) from the start/end/both ends of the <tt class="PARAMETER">string</tt></td>
          <td><tt class="LITERAL">trim(both 'x' from
          'xTomxx')</tt></td>
          <td><tt class="LITERAL">Tom</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL"><code class="FUNCTION">upper(<tt class="PARAMETER">string</tt>)</code></tt></td>
          <td><tt class="TYPE">text</tt></td>
          <td>Convert string to upper case</td>
          <td><tt class="LITERAL">upper('tom')</tt></td>
          <td><tt class="LITERAL">TOM</tt></td>
        </tr>
      </tbody>
    </table>


<div class="pagebreak"></div>

### Base Functions

<table border="1" class="CALSTABLE">
      <colgroup><col>
      <col>
      <col>
      <col>
      <col>
      </colgroup><thead>
        <tr>
          <th>Function</th>
          <th>Return Type</th>
          <th>Description</th>
          <th>Example</th>
          <th>Result</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><tt class="LITERAL"><code class="FUNCTION">abs(<tt class="REPLACEABLE c3">x</tt>)</code></tt></td>
          <td>(same as input)</td>
          <td>absolute value</td>
          <td><tt class="LITERAL">abs(-17.4)</tt></td>
          <td><tt class="LITERAL">17.4</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL"><code class="FUNCTION">cbrt(<tt class="TYPE">dp</tt>)</code></tt></td>
          <td><tt class="TYPE">dp</tt></td>
          <td>cube root</td>
          <td><tt class="LITERAL">cbrt(27.0)</tt></td>
          <td><tt class="LITERAL">3</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL"><code class="FUNCTION">ceil(<tt class="TYPE">dp</tt> or <tt class="TYPE">numeric</tt>)</code></tt></td>
          <td>(same as input)</td>
          <td>smallest integer not less than argument</td>
          <td><tt class="LITERAL">ceil(-42.8)</tt></td>
          <td><tt class="LITERAL">-42</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL"><code class="FUNCTION">ceiling(<tt class="TYPE">dp</tt> or <tt class="TYPE">numeric</tt>)</code></tt></td>
          <td>(same as input)</td>
          <td>smallest integer not less than argument (alias for
          <code class="FUNCTION">ceil</code>)</td>
          <td><tt class="LITERAL">ceiling(-95.3)</tt></td>
          <td><tt class="LITERAL">-95</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL"><code class="FUNCTION">degrees(<tt class="TYPE">dp</tt>)</code></tt></td>
          <td><tt class="TYPE">dp</tt></td>
          <td>radians to degrees</td>
          <td><tt class="LITERAL">degrees(0.5)</tt></td>
          <td><tt class="LITERAL">28.6478897565412</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL"><code class="FUNCTION">div(<tt class="PARAMETER">y</tt> <tt class="TYPE">numeric</tt>, <tt class="PARAMETER">x</tt>
          <tt class="TYPE">numeric</tt>)</code></tt></td>
          <td><tt class="TYPE">numeric</tt></td>
          <td>integer quotient of <tt class="PARAMETER">y</tt>/<tt class="PARAMETER">x</tt></td>
          <td><tt class="LITERAL">div(9,4)</tt></td>
          <td><tt class="LITERAL">2</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL"><code class="FUNCTION">exp(<tt class="TYPE">dp</tt> or <tt class="TYPE">numeric</tt>)</code></tt></td>
          <td>(same as input)</td>
          <td>exponential</td>
          <td><tt class="LITERAL">exp(1.0)</tt></td>
          <td><tt class="LITERAL">2.71828182845905</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL"><code class="FUNCTION">floor(<tt class="TYPE">dp</tt> or <tt class="TYPE">numeric</tt>)</code></tt></td>
          <td>(same as input)</td>
          <td>largest integer not greater than argument</td>
          <td><tt class="LITERAL">floor(-42.8)</tt></td>
          <td><tt class="LITERAL">-43</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL"><code class="FUNCTION">ln(<tt class="TYPE">dp</tt> or <tt class="TYPE">numeric</tt>)</code></tt></td>
          <td>(same as input)</td>
          <td>natural logarithm</td>
          <td><tt class="LITERAL">ln(2.0)</tt></td>
          <td><tt class="LITERAL">0.693147180559945</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL"><code class="FUNCTION">log(<tt class="TYPE">dp</tt> or <tt class="TYPE">numeric</tt>)</code></tt></td>
          <td>(same as input)</td>
          <td>base 10 logarithm</td>
          <td><tt class="LITERAL">log(100.0)</tt></td>
          <td><tt class="LITERAL">2</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL"><code class="FUNCTION">log(<tt class="PARAMETER">b</tt> <tt class="TYPE">numeric</tt>, <tt class="PARAMETER">x</tt>
          <tt class="TYPE">numeric</tt>)</code></tt></td>
          <td><tt class="TYPE">numeric</tt></td>
          <td>logarithm to base <tt class="PARAMETER">b</tt></td>
          <td><tt class="LITERAL">log(2.0, 64.0)</tt></td>
          <td><tt class="LITERAL">6.0000000000</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL"><code class="FUNCTION">mod(<tt class="PARAMETER">y</tt>, <tt class="PARAMETER">x</tt>)</code></tt></td>
          <td>(same as argument types)</td>
          <td>remainder of <tt class="PARAMETER">y</tt>/<tt class="PARAMETER">x</tt></td>
          <td><tt class="LITERAL">mod(9,4)</tt></td>
          <td><tt class="LITERAL">1</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL"><code class="FUNCTION">pi()</code></tt></td>
          <td><tt class="TYPE">dp</tt></td>
          <td><span class="QUOTE">"π"</span> constant</td>
          <td><tt class="LITERAL">pi()</tt></td>
          <td><tt class="LITERAL">3.14159265358979</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL"><code class="FUNCTION">power(<tt class="PARAMETER">a</tt> <tt class="TYPE">dp</tt>, <tt class="PARAMETER">b</tt> <tt class="TYPE">dp</tt>)</code></tt></td>
          <td><tt class="TYPE">dp</tt></td>
          <td><tt class="PARAMETER">a</tt> raised to the power of
          <tt class="PARAMETER">b</tt></td>
          <td><tt class="LITERAL">power(9.0, 3.0)</tt></td>
          <td><tt class="LITERAL">729</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL"><code class="FUNCTION">power(<tt class="PARAMETER">a</tt> <tt class="TYPE">numeric</tt>, <tt class="PARAMETER">b</tt>
          <tt class="TYPE">numeric</tt>)</code></tt></td>
          <td><tt class="TYPE">numeric</tt></td>
          <td><tt class="PARAMETER">a</tt> raised to the power of
          <tt class="PARAMETER">b</tt></td>
          <td><tt class="LITERAL">power(9.0, 3.0)</tt></td>
          <td><tt class="LITERAL">729</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL"><code class="FUNCTION">radians(<tt class="TYPE">dp</tt>)</code></tt></td>
          <td><tt class="TYPE">dp</tt></td>
          <td>degrees to radians</td>
          <td><tt class="LITERAL">radians(45.0)</tt></td>
          <td><tt class="LITERAL">0.785398163397448</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL"><code class="FUNCTION">round(<tt class="TYPE">dp</tt> or <tt class="TYPE">numeric</tt>)</code></tt></td>
          <td>(same as input)</td>
          <td>round to nearest integer</td>
          <td><tt class="LITERAL">round(42.4)</tt></td>
          <td><tt class="LITERAL">42</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL"><code class="FUNCTION">round(<tt class="PARAMETER">v</tt> <tt class="TYPE">numeric</tt>, <tt class="PARAMETER">s</tt>
          <tt class="TYPE">int</tt>)</code></tt></td>
          <td><tt class="TYPE">numeric</tt></td>
          <td>round to <tt class="PARAMETER">s</tt> decimal
          places</td>
          <td><tt class="LITERAL">round(42.4382, 2)</tt></td>
          <td><tt class="LITERAL">42.44</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL"><code class="FUNCTION">sign(<tt class="TYPE">dp</tt> or <tt class="TYPE">numeric</tt>)</code></tt></td>
          <td>(same as input)</td>
          <td>sign of the argument (-1, 0, +1)</td>
          <td><tt class="LITERAL">sign(-8.4)</tt></td>
          <td><tt class="LITERAL">-1</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL"><code class="FUNCTION">sqrt(<tt class="TYPE">dp</tt> or <tt class="TYPE">numeric</tt>)</code></tt></td>
          <td>(same as input)</td>
          <td>square root</td>
          <td><tt class="LITERAL">sqrt(2.0)</tt></td>
          <td><tt class="LITERAL">1.4142135623731</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL"><code class="FUNCTION">trunc(<tt class="TYPE">dp</tt> or <tt class="TYPE">numeric</tt>)</code></tt></td>
          <td>(same as input)</td>
          <td>truncate toward zero</td>
          <td><tt class="LITERAL">trunc(42.8)</tt></td>
          <td><tt class="LITERAL">42</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL"><code class="FUNCTION">trunc(<tt class="PARAMETER">v</tt> <tt class="TYPE">numeric</tt>, <tt class="PARAMETER">s</tt>
          <tt class="TYPE">int</tt>)</code></tt></td>
          <td><tt class="TYPE">numeric</tt></td>
          <td>truncate to <tt class="PARAMETER">s</tt> decimal
          places</td>
          <td><tt class="LITERAL">trunc(42.4382, 2)</tt></td>
          <td><tt class="LITERAL">42.43</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL"><code class="FUNCTION">width_bucket(<tt class="PARAMETER">op</tt>
          <tt class="TYPE">numeric</tt>, <tt class="PARAMETER">b1</tt> <tt class="TYPE">numeric</tt>,
          <tt class="PARAMETER">b2</tt> <tt class="TYPE">numeric</tt>, <tt class="PARAMETER">count</tt>
          <tt class="TYPE">int</tt>)</code></tt></td>
          <td><tt class="TYPE">int</tt></td>
          <td>return the bucket to which <tt class="PARAMETER">operand</tt> would be assigned in an
          equidepth histogram with <tt class="PARAMETER">count</tt>
          buckets, in the range <tt class="PARAMETER">b1</tt> to
          <tt class="PARAMETER">b2</tt></td>
          <td><tt class="LITERAL">width_bucket(5.35, 0.024, 10.06,
          5)</tt></td>
          <td><tt class="LITERAL">3</tt></td>
        </tr>
        <tr>
          <td><tt class="LITERAL"><code class="FUNCTION">width_bucket(<tt class="PARAMETER">op</tt>
          <tt class="TYPE">dp</tt>, <tt class="PARAMETER">b1</tt>
          <tt class="TYPE">dp</tt>, <tt class="PARAMETER">b2</tt>
          <tt class="TYPE">dp</tt>, <tt class="PARAMETER">count</tt> <tt class="TYPE">int</tt>)</code></tt></td>
          <td><tt class="TYPE">int</tt></td>
          <td>return the bucket to which <tt class="PARAMETER">operand</tt> would be assigned in an
          equidepth histogram with <tt class="PARAMETER">count</tt>
          buckets, in the range <tt class="PARAMETER">b1</tt> to
          <tt class="PARAMETER">b2</tt></td>
          <td><tt class="LITERAL">width_bucket(5.35, 0.024, 10.06,
          5)</tt></td>
          <td><tt class="LITERAL">3</tt></td>
        </tr>
      </tbody>
    </table>

How About the square root operator!

File: 07.sql

```

select |/25.0;


```

and a factorial operator!

```
select 5!;
```
and

```
select !! 5;
```

That is *FUN* !  Not 1 but 2 factorial operators.



