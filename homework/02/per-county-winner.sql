drop table if exists election_2020 ;
create table election_2020 (
    id           serial primary key,
    county_name  text,
    state        text,
    winner       text -- either 'Joseph R Biden Jr' or 'Donald...'
);
