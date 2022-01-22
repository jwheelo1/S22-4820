
-- "year","state","state_po","county_name","county_fips","office","candidate","party","candidatevotes","totalvotes","version","mode"
-- 2000,"ALABAMA","AL","AUTAUGA","1001","PRESIDENT","AL GORE","DEMOCRAT",4942,17208,20191203,"TOTAL"
-- 2000,"CONNECTICUT",NA,"STATEWIDE WRITEIN",NA,"PRESIDENT","AL GORE","DEMOCRAT",NA,0,20191203,"TOTAL"
--	state_po		varchar(2) default '--', 

drop table if exists vote_by_county ;
create table vote_by_county (
	id				serial primary key,
	year			int default 2021,
	state			text default '--',		-- irritatingly all upper case.
	state_uc		text default '--',
	state_code		varchar(2) default '--', 
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

create index vote_by_county_p1 on vote_by_county ( year, county_name, state );
create index vote_by_county_p2 on vote_by_county ( year, candidate );

