-------------------------------------------------------------------------------
-- Извлечь XML/JSON фрагмент из XML/JSON документа
select '[{"id":3,"name":"Supreme Ladder","tier":3,"prize_pool":30704000,"date_start":"2020-03-16","duration":14,"dpc_points":1400,"location":"Roanoke"},
{"id":5,"name":"Succinct Ladder","tier":3,"prize_pool":7612000,"date_start":"2010-02-18","duration":30,"dpc_points":2100,"location":"Washington"},
{"id":6,"name":"Fragile Minor","tier":4,"prize_pool":24738000,"date_start":"2013-10-24","duration":27,"dpc_points":1800,"location":"Havre de Grace"},
{"id":7,"name":"Quixotic Minor","tier":4,"prize_pool":3171000,"date_start":"2010-04-10","duration":15,"dpc_points":1500,"location":"Memphis"}]'::json->1;
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- Извлечь значения конкретных узлов или атрибутов XML/JSON документа
drop table if exists tmp;
create table tmp (data json);
\copy tmp(data) from 'C:/jsondata/tournaments.json';

select data->'location' from tmp;
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- Выполнить проверку существования узла или атрибута
drop table if exists tmp;
create table tmp (data json);
\copy tmp(data) from 'C:/jsondata/tournaments.json';

select data->'unknown column' is not null as result
from tmp limit 1;
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- Изменить XML/JSON документ
select jsonb_set('[{"id":3,"name":"Supreme Ladder","tier":3,"prize_pool":30704000,"date_start":"2020-03-16","duration":14,"dpc_points":1400,"location":"Roanoke"},
{"id":5,"name":"Succinct Ladder","tier":3,"prize_pool":7612000,"date_start":"2010-02-18","duration":30,"dpc_points":2100,"location":"Washington"},
{"id":6,"name":"Fragile Minor","tier":4,"prize_pool":24738000,"date_start":"2013-10-24","duration":27,"dpc_points":1800,"location":"Havre de Grace"},
{"id":7,"name":"Quixotic Minor","tier":4,"prize_pool":3171000,"date_start":"2010-04-10","duration":15,"dpc_points":1500,"location":"Memphis"}]',
'{0, tier}', '1')->0;
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- Разделить XML/JSON документ на несколько строк по узлам
drop table if exists tmp;
create table tmp (data json);
\copy tmp(data) from 'C:/jsondata/tournaments.json';

drop table if exists div_tmp;
select json_build_object('id', data->'id', 'name', data->'name', 'tier', data->'tier', 'prize_pool', data->'prize_pool') as first,
    json_build_object('date_start', data->'date_start', 'duration', data->'duration','dpc_points', data->'dpc_points', 'location', data->'location') as second
into table div_tmp from (select data from tmp) as new_tmp;
-------------------------------------------------------------------------------
