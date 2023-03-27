-- Создать таблицу, в которой будет атрибут(-ы) с типом XML или JSON, или
-- добавить атрибут с типом XML или JSON к уже существующей таблице.
-- Заполнить атрибут правдоподобными данными с помощью команд INSERT
-- или UPDATE.

drop table if exists json_tourns;
create table json_tourns as (select * from tournaments);

alter table json_tourns add column json_column json;

update json_tourns
set json_column = (
    select to_json(tournaments) from tournaments
    where tournaments.id = json_tourns.id
);