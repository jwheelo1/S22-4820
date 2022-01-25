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
