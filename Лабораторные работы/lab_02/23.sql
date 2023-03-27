-- Инструкция SELECT, использующая рекурсивное обобщенное табличное выражение

/* Получаем список победителей */
create temp table teams_places (
    id serial primary key, 
    next_id int references teams_places(id), 
    name varchar
);

insert into teams_places (next_id, name) values 
(2, 'First team'), 
(3, 'Second team'), 
(4, 'Third team'),
(5, 'Fourth team'),
(null, 'Fifth team');

with recursive list as (
    select id, next_id, name from teams_places where id = 1 
    union all
    select teams_places.id, teams_places.next_id, teams_places.name from teams_places 
    join list on list.next_id = teams_places.id
) select * from list;