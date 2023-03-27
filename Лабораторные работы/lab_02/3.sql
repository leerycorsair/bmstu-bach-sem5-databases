-- Инструкция SELECT, использующая предикат LIKE

-- Получить из таблицы турниров турниры, в названии которых указано Major и длительность менее 10 дней
select * from tournaments 
where tournaments.name like '%Major%' and duration < 10;