m4_include(../../../setup.m4)

# Lecture 2 - Tables / Insert / Select

SQL databases are composed of a set of tables.

A table is a set of columns, with names and types - like a struct or record in other languages.

There is a set of rows - that act kind of like an un-ordered array of columns.

SQL normally stores this as a row-order store.

Some SQL-ish databases like Cassandra store this as a colum-store.


```
$ psql
pg=# \i create-tables.sql
pg=# \q
$
```

the file


```
create table vote_by_county (
	id				serial primary key,
	year			int default 2021,
	state			text default '--',		-- irritatingly all upper case.
	state_uc		text default '--',
	state_po		varchar(2) default '--', 	-- Incorrectly Named Column!
	county_name		text default '--',		-- irritatingly all upper case.
	county_name_uc	text default '--',
	county_fips		int default 0,
	office			text default 'unk', 
	candidate		text default 'unk', 
	candidate_uc	text default 'unk', 
	party			text default 'unk', 
	candidatevotes	int default 0, 
	totalvotes		int default 0,
	version			int,
	vote_mode		text
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

Now we can get the data back:

```
select year, state, county_name, version 
	from vote_by_county ;
```

## Data Types for tables

The data types used in our example:

|   Type | Description                                                                           |
|-------:|:--------------------------------------------------------------------------------------|
| serial | an integer that is generated (if null) by the database.                               |
| int    | an integer (bigint, numeric etc)                                                      |
| text   | a string from NULL, 0 length to `2**33` bytes in length.                              |
| varchar(maxlen) |  A 'text' field with a limited length.                                       |
| char(maxlen)    | a right blank-padded fixed length string.                                    |
| char varying(maxlen) | same as varchar()                                                       |

`not null` disallow NULL values.

`default Value` if insert skips this value then default will be used.  This is different than the
value NULL.

`primary key` means that .

There are a bunch of other data types in PostgreSQL (MySQL/MariaDB has a bunch too, Oracle
has a bunch, MS Sql Server too).

<table class="CALSTABLE">
<colgroup><col>
<col>
<col>
</colgroup><thead>
<tr>
<th>Name</th>
<th>Aliases</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr>
<td><tt class="TYPE">bigint</tt></td>
<td><tt class="TYPE">int8</tt></td>
<td>signed eight-byte integer</td>
</tr>
<tr>
<td><tt class="TYPE">bigserial</tt></td>
<td><tt class="TYPE">serial8</tt></td>
<td>autoincrementing eight-byte integer</td>
</tr>
<tr>
<td><tt class="TYPE">bit [ (<tt class="REPLACEABLE c3">n</tt>) ]</tt></td>
<td>&nbsp;</td>
<td>fixed-length bit string</td>
</tr>
<tr>
<td><tt class="TYPE">bit varying [ (<tt class="REPLACEABLE c3">n</tt>) ]</tt></td>
<td><tt class="TYPE">varbit [ (<tt class="REPLACEABLE c3">n</tt>) ]</tt></td>
<td>variable-length bit string</td>
</tr>
<tr>
<td><tt class="TYPE">boolean</tt></td>
<td><tt class="TYPE">bool</tt></td>
<td>logical Boolean (true/false)</td>
</tr>
<tr>
<td><tt class="TYPE">box</tt></td>
<td>&nbsp;</td>
<td>rectangular box on a plane</td>
</tr>
<tr>
<td><tt class="TYPE">bytea</tt></td>
<td>&nbsp;</td>
<td>binary data (<span class="QUOTE">"byte array"</span>)</td>
</tr>
<tr>
<td><tt class="TYPE">character [ (<tt class="REPLACEABLE c3">n</tt>) ]</tt></td>
<td><tt class="TYPE">char [ (<tt class="REPLACEABLE c3">n</tt>) ]</tt></td>
<td>fixed-length character string</td>
</tr>
<tr>
<td><tt class="TYPE">character varying [ (<tt class="REPLACEABLE c3">n</tt>) ]</tt></td>
<td><tt class="TYPE">varchar [ (<tt class="REPLACEABLE c3">n</tt>) ]</tt></td>
<td>variable-length character string</td>
</tr>
<tr>
<td><tt class="TYPE">cidr</tt></td>
<td>&nbsp;</td>
<td>IPv4 or IPv6 network address</td>
</tr>
<tr>
<td><tt class="TYPE">circle</tt></td>
<td>&nbsp;</td>
<td>circle on a plane</td>
</tr>
<tr>
<td><tt class="TYPE">date</tt></td>
<td>&nbsp;</td>
<td>calendar date (year, month, day)</td>
</tr>
<tr>
<td><tt class="TYPE">double precision</tt></td>
<td><tt class="TYPE">float8</tt></td>
<td>double precision floating-point number (8 bytes)</td>
</tr>
<tr>
<td><tt class="TYPE">inet</tt></td>
<td>&nbsp;</td>
<td>IPv4 or IPv6 host address</td>
</tr>
<tr>
<td><tt class="TYPE">integer</tt></td>
<td><tt class="TYPE">int</tt>, <tt class="TYPE">int4</tt></td>
<td>signed four-byte integer</td>
</tr>
<tr>
<td><tt class="TYPE">interval [ <tt class="REPLACEABLE c3">fields</tt> ] [ (<tt class="REPLACEABLE c3">p</tt>) ]</tt></td>
<td>&nbsp;</td>
<td>time span</td>
</tr>
<tr>
<td><tt class="TYPE">json</tt></td>
<td>&nbsp;</td>
<td>textual JSON data</td>
</tr>
<tr>
<td><tt class="TYPE">jsonb</tt></td>
<td>&nbsp;</td>
<td>binary JSON data, decomposed</td>
</tr>
<tr>
<td><tt class="TYPE">line</tt></td>
<td>&nbsp;</td>
<td>infinite line on a plane</td>
</tr>
<tr>
<td><tt class="TYPE">lseg</tt></td>
<td>&nbsp;</td>
<td>line segment on a plane</td>
</tr>
<tr>
<td><tt class="TYPE">macaddr</tt></td>
<td>&nbsp;</td>
<td>MAC (Media Access Control) address</td>
</tr>
<tr>
<td><tt class="TYPE">money</tt></td>
<td>&nbsp;</td>
<td>currency amount</td>
</tr>
<tr>
<td><tt class="TYPE">numeric [ (<tt class="REPLACEABLE c3">p</tt>, <tt class="REPLACEABLE c3">s</tt>) ]</tt></td>
<td><tt class="TYPE">decimal [ (<tt class="REPLACEABLE c3">p</tt>, <tt class="REPLACEABLE c3">s</tt>) ]</tt></td>
<td>exact numeric of selectable precision</td>
</tr>
<tr>
<td><tt class="TYPE">path</tt></td>
<td>&nbsp;</td>
<td>geometric path on a plane</td>
</tr>
<tr>
<td><tt class="TYPE">pg_lsn</tt></td>
<td>&nbsp;</td>
<td><span class="PRODUCTNAME">PostgreSQL</span> Log Sequence Number</td>
</tr>
<tr>
<td><tt class="TYPE">point</tt></td>
<td>&nbsp;</td>
<td>geometric point on a plane</td>
</tr>
<tr>
<td><tt class="TYPE">polygon</tt></td>
<td>&nbsp;</td>
<td>closed geometric path on a plane</td>
</tr>
<tr>
<td><tt class="TYPE">real</tt></td>
<td><tt class="TYPE">float4</tt></td>
<td>single precision floating-point number (4 bytes)</td>
</tr>
<tr>
<td><tt class="TYPE">smallint</tt></td>
<td><tt class="TYPE">int2</tt></td>
<td>signed two-byte integer</td>
</tr>
<tr>
<td><tt class="TYPE">smallserial</tt></td>
<td><tt class="TYPE">serial2</tt></td>
<td>autoincrementing two-byte integer</td>
</tr>
<tr>
<td><tt class="TYPE">serial</tt></td>
<td><tt class="TYPE">serial4</tt></td>
<td>autoincrementing four-byte integer</td>
</tr>
<tr>
<td><tt class="TYPE">text</tt></td>
<td>&nbsp;</td>
<td>variable-length character string</td>
</tr>
<tr>
<td><tt class="TYPE">time [ (<tt class="REPLACEABLE c3">p</tt>) ] [ without time zone ]</tt></td>
<td>&nbsp;</td>
<td>time of day (no time zone)</td>
</tr>
<tr>
<td><tt class="TYPE">time [ (<tt class="REPLACEABLE c3">p</tt>) ] with time zone</tt></td>
<td><tt class="TYPE">timetz</tt></td>
<td>time of day, including time zone</td>
</tr>
<tr>
<td><tt class="TYPE">timestamp [ (<tt class="REPLACEABLE c3">p</tt>) ] [ without time zone ]</tt></td>
<td>&nbsp;</td>
<td>date and time (no time zone)</td>
</tr>
<tr>
<td><tt class="TYPE">timestamp [ (<tt class="REPLACEABLE c3">p</tt>) ] with time zone</tt></td>
<td><tt class="TYPE">timestamptz</tt></td>
<td>date and time, including time zone</td>
</tr>
<tr>
<td><tt class="TYPE">tsquery</tt></td>
<td>&nbsp;</td>
<td>text search query</td>
</tr>
<tr>
<td><tt class="TYPE">tsvector</tt></td>
<td>&nbsp;</td>
<td>text search document</td>
</tr>
<tr>
<td><tt class="TYPE">txid_snapshot</tt></td>
<td>&nbsp;</td>
<td>user-level transaction ID snapshot</td>
</tr>
<tr>
<td><tt class="TYPE">uuid</tt></td>
<td>&nbsp;</td>
<td>universally unique identifier</td>
</tr>
<tr>
<td><tt class="TYPE">xml</tt></td>
<td>&nbsp;</td>
<td>XML data</td>
</tr>
</tbody>
