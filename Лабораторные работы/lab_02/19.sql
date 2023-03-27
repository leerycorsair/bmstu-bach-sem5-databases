-- Инструкция UPDATE со скалярным подзапросом в предложении SET

-- Обновление призового фонда первого турнира на максимальный из всех
update tournaments set prize_pool = (
    select max(tournaments.prize_pool)from tournaments) where id = 1;