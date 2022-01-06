  1: 
  2: -- "year","state","state_po","county_name","county_fips","office","candidate","party","candidatevotes","totalvotes","version","mode"
  3: -- 2000,"ALABAMA","AL","AUTAUGA","1001","PRESIDENT","AL GORE","DEMOCRAT",4942,17208,20191203,"TOTAL"
  4: -- 2000,"CONNECTICUT",NA,"STATEWIDE WRITEIN",NA,"PRESIDENT","AL GORE","DEMOCRAT",NA,0,20191203,"TOTAL"
  5: 
  6: drop table if exists vote_by_county ;
  7: create table vote_by_county (
  8:     id                serial primary key,
  9:     year            int default 2021,
 10:     state            text default '--',        -- irritatingly all upper case.
 11:     state_uc        text default '--',
 12:     state_po        varchar(2) default '--', 
 13:     county_name        text default '--',        -- irritatingly all upper case.
 14:     county_name_uc    text default '--',
 15:     county_fips        int default 0,
 16:     office            text default 'unk', 
 17:     candidate        text default 'unk', 
 18:     candidate_uc    text default 'unk', 
 19:     party            text default 'unk', 
 20:     candidatevotes    int default 0, 
 21:     totalvotes        int default 0,
 22:     version            int,
 23:     vote_mode        text
 24: );
 25: 
 26: create index vote_by_county_p1 on vote_by_county ( year, county_name, state );
 27: create index vote_by_county_p2 on vote_by_county ( year, candidate );
 28: 
