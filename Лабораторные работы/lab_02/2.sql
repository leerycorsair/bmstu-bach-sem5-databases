-- Инструкция SELECT, использующая предикат BETWEEN

-- Получить из таблицы турниров количество турниров, количество DPC поинтов которых в диапазоне 2000-3000
select count(*) from tournaments 
where tournaments.dpc_points between 2000 and 3000;