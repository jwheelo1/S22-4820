\c l02
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
