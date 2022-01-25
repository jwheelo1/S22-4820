  1: 
  2: -- "year","state","state_po","county_name","county_fips","office","candidate","party","candidatevotes","totalvotes","version","mode"
  3: -- 2000,"ALABAMA","AL","AUTAUGA","1001","PRESIDENT","AL GORE","DEMOCRAT",4942,17208,20191203,"TOTAL"
  4: -- 2000,"CONNECTICUT",NA,"STATEWIDE WRITEIN",NA,"PRESIDENT","AL GORE","DEMOCRAT",NA,0,20191203,"TOTAL"
  5: --    state_po        varchar(2) default '--', 
  6: 
  7: drop table if exists vote_by_county ;
  8: create table vote_by_county (
  9:     id                serial primary key,
 10:     year            int default 2021,
 11:     state            text default '--',        -- irritatingly all upper case.
 12:     state_uc        text default '--',
 13:     state_code        varchar(2) default '--', 
 14:     county_name        text default '--',        -- irritatingly all upper case.
 15:     county_name_uc    text default '--',
 16:     county_fips        int default 0,
 17:     office            text default 'unk', 
 18:     candidate        text default 'unk', 
 19:     candidate_uc    text default 'unk', 
 20:     party            text default 'unk', 
 21:     candidatevotes    int default 0, 
 22:     totalvotes        int default 0,
 23:     version            int,
 24:     vote_mode        text
 25: );
 26: 
 27: create index vote_by_county_p1 on vote_by_county ( year, county_name, state );
 28: create index vote_by_county_p2 on vote_by_county ( year, candidate );
 29: 
