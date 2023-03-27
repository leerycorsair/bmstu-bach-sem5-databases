-------------------------------------------------------------------------------
-- Хранимая процедура с параметрами
-- Изменить кол-во DPC-поинтов у турниров конктретного тира согласно множителю
create or replace procedure tournaments_dpc_change(tier_level int, multiplier int)
as $$ 
begin 
    update tournaments
    set dpc_points = dpc_points * multiplier
    where tier = tier_level;
end;
$$ language plpgsql;

-- Увеличить кол-во DPC-поинтов у турниров 1 тира в 2 раза
call tournaments_dpc_change(1, 2);
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- Рекурсивная хранимая процедура
-- Получить количество турниров, имеющих призовой фонд больше заданного среди заданных тиров
create or replace procedure prize_pool_cnt(tier_min int, tier_max int, prize_min int, in cnt int)
as $$
declare c int;
begin 
    if tier_min > tier_max then 
        raise notice 'COUNT = %', cnt;
        return;
    end if;

    select count(*) into c from tournaments
    where prize_pool > prize_min and tier = tier_min;
    cnt := cnt + c;
    call prize_pool_cnt(tier_min + 1, tier_max, prize_min, cnt);
end;
$$ language plpgsql;

-- Получить количество турниров, имеющих призовой фонд больше 10000000 среди заданных 1 и 2 тиров
call prize_pool_cnt(1, 3, 10000000, 0);
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- Хранимая процедура с курсором
-- Получить ники 10 самых молодых игроков, имеющих рейтинг выше заданного
create or replace procedure print_young_players(min_mmr int)
as $$
declare 
    curr_player varchar(50);
    cnt int; 
    cur refcursor;
begin
    cnt := 0;
    open cur for 
        select nickname from players
        where mmr > min_mmr
        order by birthdate desc;
    while cnt < 10 loop
        fetch cur into curr_player;
        raise notice '%', curr_player;
        cnt := cnt + 1;
    end loop;
    close cur;
end;
$$ language plpgsql;

-- Получить ники 10 самых молодых игроков, имеющих рейтинг выше 9000
call print_young_players(9000);
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- Хранимая процедура доступа к метаданным
-- Получить все таблицы в БД по указанной схеме
create or replace procedure meta_data(tb_cat varchar, tb_sch varchar)
as $$
declare r record;
begin 
    for r in select table_catalog as db, table_schema as sc, table_name as nm
        from information_schema.tables where table_catalog = tb_cat and table_schema = tb_sch 
    loop
        raise info '%', r;
    end loop;
end;
$$ language plpgsql;

-- Получить все таблицы в БД 'bmstu' по схеме 'public'
call meta_data('bmstu', 'public');
-------------------------------------------------------------------------------

