  1: drop table if exists election_2020 ;
  2: create table election_2020 (
  3:     id           serial primary key,
  4:     county_name  text,
  5:     state        text,
  6:     winner       text -- either 'Joseph R Biden Jr' or 'Donald...'
  7: );
