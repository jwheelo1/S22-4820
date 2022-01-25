  1: 
  2: drop table if exists slot;
  3: create table slot (
  4:     slot_id                serial primary key,
  5:     start_time             timestamp not null,
  6:     day_of_week         int,
  7:     time_of_day         time,
  8:       created             timestamp default current_timestamp not null,
  9:     updated             timestamp
 10: );
 11: 
 12: create index slot_p1 on slot ( start_time );
 13: create index slot_p2 on slot ( day_of_week );
 14: create index slot_p3 on slot ( time_of_day );
 15: 
 16: 
 17: 
 18: 
 19: CREATE OR REPLACE function slot_upd()
 20: RETURNS trigger AS 
 21: $BODY$
 22: DECLARE
 23:     l varchar(20);
 24: BEGIN
 25:     NEW.updated := current_timestamp;
 26:     SELECT extract(dow from NEW.start_time) INTO l;
 27:     NEW.day_of_week = l;
 28:     NEW.time_of_day = cast ( NEW.start_time as time );
 29:     RETURN NEW;
 30: END
 31: $BODY$
 32: LANGUAGE 'plpgsql';
 33: 
 34: 
 35: CREATE TRIGGER slot_trig_upd
 36:     BEFORE update ON slot
 37:     FOR EACH ROW
 38:     EXECUTE PROCEDURE slot_upd();
 39: 
 40: 
 41: 
 42: 
 43: 
 44: 
 45: CREATE OR REPLACE function slot_ins()
 46: RETURNS trigger AS 
 47: $BODY$
 48: DECLARE
 49:     l varchar(20);
 50: BEGIN
 51:     SELECT extract(dow from NEW.start_time) INTO l;
 52:     NEW.day_of_week = l;
 53:     NEW.time_of_day = cast ( NEW.start_time as time );
 54:     RETURN NEW;
 55: END
 56: $BODY$
 57: LANGUAGE 'plpgsql';
 58: 
 59: 
 60: CREATE TRIGGER slot_trig_ins
 61:     BEFORE insert ON slot
 62:     FOR EACH ROW
 63:     EXECUTE PROCEDURE slot_ins();
 64: 
 65: 
 66: 
 67: 
 68: 
 69: insert into slot ( start_time ) values 
 70:     ( '2022-01-20T14:00:00' )
 71:     ;
 72: 
 73: select * from slot;
 74: 
