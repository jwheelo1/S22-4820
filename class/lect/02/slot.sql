
drop table if exists slot;
create table slot (
	slot_id				serial primary key,
	start_time 			timestamp not null,
	day_of_week 		int,
	time_of_day 		time,
  	created 			timestamp default current_timestamp not null,
	updated 			timestamp
);

create index slot_p1 on slot ( start_time );
create index slot_p2 on slot ( day_of_week );
create index slot_p3 on slot ( time_of_day );




CREATE OR REPLACE function slot_upd()
RETURNS trigger AS 
$BODY$
DECLARE
	l varchar(20);
BEGIN
	NEW.updated := current_timestamp;
	SELECT extract(dow from NEW.start_time) INTO l;
	NEW.day_of_week = l;
	NEW.time_of_day = cast ( NEW.start_time as time );
	RETURN NEW;
END
$BODY$
LANGUAGE 'plpgsql';


CREATE TRIGGER slot_trig_upd
	BEFORE update ON slot
	FOR EACH ROW
	EXECUTE PROCEDURE slot_upd();






CREATE OR REPLACE function slot_ins()
RETURNS trigger AS 
$BODY$
DECLARE
	l varchar(20);
BEGIN
	SELECT extract(dow from NEW.start_time) INTO l;
	NEW.day_of_week = l;
	NEW.time_of_day = cast ( NEW.start_time as time );
	RETURN NEW;
END
$BODY$
LANGUAGE 'plpgsql';


CREATE TRIGGER slot_trig_ins
	BEFORE insert ON slot
	FOR EACH ROW
	EXECUTE PROCEDURE slot_ins();





insert into slot ( start_time ) values 
	( '2022-01-20T14:00:00' )
	;

select * from slot;

