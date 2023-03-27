import psycopg2
from psycopg2 import Error
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
from utils import *
import os


def main():
    try:
        connection = psycopg2.connect(user="postgres",
                                      password="123",
                                      host="127.0.0.1",
                                      port="5432",
                                      database="bmstu")
        connection.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
        cursor = connection.cursor()

        option = -1
        while option:
            option = menu()
            if option == 1:
                good_tournaments_amount(cursor)
            elif option == 2:
                team_player_info(cursor)
            elif option == 3:
                avg_rev_dot_com(cursor)
            elif option == 4:
                meta(cursor)
            elif option == 5:
                tournaments_dates(cursor)
            elif option == 6:
                ft_tournaments_by_name(cursor)
            elif option == 7:
                dpc_update(cursor)
            elif option == 8:
                current_info(cursor)
            elif option == 9:
                create_talants_table(connection, cursor)
            elif option == 10:
                insert_talant(connection, cursor)
            elif option == 11:
                players_by_tournaments(cursor)
        print()

    except (Exception, Error) as error:
        print("Ошибка при работе с PostgreSQL", error)
    finally:
        if connection:
            cursor.close()
            connection.close
            print("Соединение закрыто")

if __name__ == '__main__':
    main()
