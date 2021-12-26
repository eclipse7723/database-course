import main
import matplotlib.pyplot as plt


if __name__ == "__main__":

    with main.login() as connect:
        cursor = connect.cursor()

        # -- 3а - розподілення міцності пива - стовпчкова
        values = main.execute_sql(cursor, "query.sql", 1)
        plt.bar([v[0] for v in values], [v[1] for v in values])
        plt.ylabel("alcohol by volume")
        plt.xlabel("count")
        plt.show()

        # -- 3б - кількість внесеного пива в кожному місті
        values = main.execute_sql(cursor, "query.sql", 2)
        plt.pie(x=[v[0] for v in values], labels=[v[1] for v in values])
        plt.show()

        # -- 3в. залежність міцності пива від сорту (стиль)
