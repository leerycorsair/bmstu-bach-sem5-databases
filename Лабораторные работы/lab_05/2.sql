-- Выполнить загрузку и сохранение XML или JSON файла в таблицу.
-- Созданная таблица после всех манипуляций должна соответствовать таблице
-- базы данных, созданной в первой лабораторной работе.

drop table if exists tmp;
create table tmp (data json);
\copy tmp(data) from 'C:/jsondata/tournaments.json';

drop table if exists json_tourns;
select jpr.*
into table json_tourns
from tmp,  json_populate_record(null::tournaments, data) as jpr;
