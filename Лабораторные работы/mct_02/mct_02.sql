-- ЗАДАНИЕ 1
-- Создание

drop database if exists food;
create database food;

\c food;

create table "dishes" (
    id serial primary key,
    dish_name varchar not null,
    dish_desc text not null,
    rate int not null
);

create table "products" (
    id serial primary key,
    product_name varchar not null,
    man_date date not null,
    exp_date date not null,
    sup_name varchar not null
);

create table "menues"(
    id serial primary key,
    menu_name varchar not null,
    food_time varchar not null,
    menu_desc text not null
);

create table "dishes_products" (
    dish_id int not null,
    product_id int not null,
    foreign key (dish_id) references dishes (id),
    foreign key (product_id) references products (id)
);

create table "dishes_menu" (
    dish_id int not null,
    menu_id int not null,
    foreign key (dish_id) references dishes (id),
    foreign key (menu_id) references menues (id)
);

insert into dishes(dish_name, dish_desc, rate) values
('name1 soup', 'desc1', 1),
('name2 soup', 'desc2', 2),
('name3 meat', 'desc3', 3),
('name4 meat', 'desc4', 4),
('name5 soup', 'desc5', 5),
('name6 soup', 'desc6', 4),
('name7 meat', 'desc7', 3),
('name8 meat', 'desc8', 2),
('name9 meat', 'desc9', 1),
('name10 meat', 'desc10', 5);

insert into products(product_name, man_date, exp_date, sup_name) values
('name1', '2017-2-27', '2017-3-27', 's1'),
('name2', '2011-2-27', '2011-3-27', 's2'),
('name3', '2012-2-27', '2012-3-27', 's3'),
('name4', '2013-2-27', '2013-3-27', 's4'),
('name5', '2014-2-27', '2014-3-27', 's5'),
('name6', '2015-2-27', '2015-3-27', 's6'),
('name7', '2016-2-27', '2016-3-27', 's7'),
('name8', '2017-2-27', '2017-3-27', 's8'),
('name9', '2018-2-27', '2018-3-27', 's9'),
('name10', '2019-2-27', '2019-3-27', '10');

insert into menues(menu_name, food_time, menu_desc) values
('name1', 'f1', 'desc1'),
('name2', 'f2', 'desc2'),
('name3', 'f3', 'desc3'),
('name4', 'f4', 'desc4'),
('name5', 'f5', 'desc5'),
('name6', 'f6', 'desc6'),
('name7', 'f7', 'desc7'),
('name8', 'f8', 'desc8'),
('name9', 'f9', 'desc9'),
('name10', 'f10', 'desc10');

insert into dishes_products(dish_id, product_id) values
(1, 10),
(2, 9),
(3, 9),
(4, 8),
(5, 7),
(6, 6),
(7, 5),
(8, 4),
(9, 3),
(9, 1),
(10, 2);

insert into dishes_menu(dish_id, menu_id) values
(1, 10),
(2, 9),
(3, 7),
(4, 8),
(5, 7),
(6, 6),
(7, 5),
(8, 4),
(9, 3),
(9, 4),
(9, 5),
(9, 7),
(9, 8),
(9, 1),
(10, 2);

-- ЗАДАНИЕ 2

-- Инструкция SELECT, использующая предикат сравнения с квантором
-- Получить из таблицы блюд все блюда, рейтинг которых выше или равен 3
select * from dishes where dishes.rate > all (
    select dishes.rate from dishes where dishes.rate < 3 
);

-- Инструкция SELECT, использующая агрегатные функции в выражениях столбцов
-- Получить из таблицы блюд среднее значение рейтинга мясных блюд
select avg(dishes.rate) from dishes where dish_name like '%meat%';

-- Создание новой временной локальной таблицы из результирующего набора данных инструкции SELECT
-- Создание временной таблицы из таблицы Блюд-Меню (в скольких меню учавствует каждое блюдо)
create temp table tmp as 
select  dish_id, count(*) from dishes_menu group by dishes_menu.dish_id;
-- Получение количества меню для 9 блюда из времнной таблицы
select * from tmp where dish_id = 9;

-- ЗАДАНИЕ 3

-- Создать хранимую процедуру, которая, не уничтожая базу данных, уничтожает все те таблицы текущей базы данных в схеме 'dbo', имена
-- которых начинаются с фразы 'TableName'. Созданную хранимую процедуру протестировать

create function drop_tables()
returns void
language plpgsql
as
$$
declare
    row record;
begin
    for row in select table_name from information_schema.tables 
                where table_name like 'TableName%' and table_schema = 'dbo' loop
        execute 'drop table ' || row.name;
    end loop;
end;
$$;