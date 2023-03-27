def menu() -> int:
    print("Меню:")
    print("1 - Скалярный запрос (Получить количество турниров, количество DPC поинтов которых в диапазоне 2000-3000)")
    print("2 - Запрос с несколькими соединениями (Получить название тимы, имя игрока и дату контракта)")
    print("3 - Запрос с ОТВ и оконными функциями (Получить среднее значение выручки компаний, использующих домен .com)")
    print("4 - Запрос к метаданным (Размер каждой из таблиц в БД)")
    print("5 - Скалярная функция (Получить названия турниров, их начальную и конечную дату проведения)")
    print("6 - Многооператорная или табличная функция (Получить турниры 1 тира, в названии города которых есть слово 'New')")
    print("7 - Хранимая процедура (Увеличить кол-во DPC-поинтов у турниров 1 тира в 2 раза)")
    print("8 - Системная функция или процедура (Информация о текущей БД)")
    print("9 - Создание таблицы в БД (Создать таблицу талантов)")
    print("10- Вставка данных в созданную таблицу (Добавить таланта)")
    print("11- Защита")
    print("0 - Выход")
    option = int(input())
    return option


def print_table(table):
    for row in table:
        for field in row:
            print(field, end=" | ")
        print()


def good_tournaments_amount(cursor):
    cursor.execute(
        "select count(*) from tournaments where tournaments.dpc_points between 2000 and 3000;")
    record = cursor.fetchall()
    print_table(record)


def team_player_info(cursor):
    cursor.execute(
        """select t.name, p.nickname, tp.contract_date from teams t join teams_players tp on t.id=tp.team_id join players p on tp.player_id=p.id;""")
    record = cursor.fetchall()
    print_table(record)


def avg_rev_dot_com(cursor):
    cursor.execute("""with FFF(id, name, website, revenue) as (
    select companies.id, companies.name, companies.website, companies.revenue from companies
    where companies.website like '%.com%' 
    )
    select avg(revenue) from FFF;""")
    record = cursor.fetchall()
    print_table(record)


def meta(cursor):
    cursor.execute("""
    select table_name, size
    from(
        select table_name, pg_relation_size(cast(table_name as varchar)) as size
        from information_schema.tables
        where table_schema not in ('information_schema','pg_catalog')
        order by size) tmp;
    """)
    record = cursor.fetchall()
    print_table(record)


def tournaments_dates(cursor):
    cursor.execute(
        """select name, date_start, date_finish(date_start, duration) from tournaments;""")
    record = cursor.fetchall()
    print_table(record)


def ft_tournaments_by_name(cursor):
    cursor.execute("""select * from tournaments_by_location_tier('New', 1);""")
    record = cursor.fetchall()
    print_table(record)


def dpc_update(cursor):
    cursor.execute("""call tournaments_dpc_change(1, 2);""")


def current_info(cursor):
    cursor.execute("""select current_database(), current_user;""")
    record = cursor.fetchall()
    print_table(record)


def create_talants_table(connection, cursor):
    cursor.execute("""
    drop table if exists "talants";
    create table talants(
        "id" serial primary key,
        "name" varchar,
        "salary" int);""")
    connection.commit()


def insert_talant(connection, cursor):
    name = input("Введите имя таланта: ")
    salary = int(input("Введите зарплату таланта: "))
    cursor.execute("""
    insert into talants(name, salary) values('{:s}', {:d})
    """.format(name, salary))
    connection.commit()


def players_by_tournaments(cursor):
    file_in = 'C:/jsondata/tournaments_in.json'
    file_out = 'C:/jsondata/tournaments_out.json'
    cursor.execute("""
    copy (select to_json(tournaments) from tournaments limit 5) to '{:s}';

    drop function if exists players_by_tournaments;
    create or replace procedure players_by_tournaments ()
    as $$
    begin 
        drop table if exists tmp;
        create table tmp (data json);
        copy tmp(data) from '{:s}';

        drop table if exists res;
        create temp table res as (
            select p.nickname, count(*) from players p 
            join teams_players tp on p.id = tp.player_id 
            join teams t on t.id = tp.team_id where t.id in 
                (select teams.id from teams 
                join tournaments_teams tt on teams.id = tt.team_id 
                join tournaments tr on tt.tournament_id = tr.id where tr.id in 
                    (select (tmp.data->>'id')::int from tmp)) 
            group by p.nickname
        );

        copy (select to_json(res) from res) to '{:s}';
    end;
    $$ language plpgsql;

    call players_by_tournaments();
    """.format(file_in, file_in, file_out, file_in, file_out))
