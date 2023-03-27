-- Инструкция SELECT, использующая простое выражение CASE

-- Получить из таблицы турниров классификацию турниров по их статусу сезона (этот сезон, или прошедшие)
select tournaments.name, tournaments.date_start,
case date_part('year', tournaments.date_start)
when date_part('year', now()) then 'Current season'
else 'Passed'
end as "Status"
from tournaments;