-- Инструкция SELECT, использующая простое обобщенное табличное выражение

-- Получить среднее значение выручки компаний, использующих домен .com
with FFF(id, name, website, revenue) as
(
    select companies.id, companies.name, companies.website, companies.revenue from companies
    where companies.website like '%.com%' 
)
select avg(revenue) from FFF;