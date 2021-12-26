import main
import matplotlib.pyplot as plt


if __name__ == "__main__":

    with main.login() as connect:
        cursor = connect.cursor()
        query_path = "query.sql"

        # -- 3а - розподілення міцності пива - стовпчкова
        values = main.execute_sql(cursor, query_path, 1)
        plt.bar([v[0] for v in values], [v[1] for v in values])
        plt.ylabel("alcohol by volume")
        plt.xlabel("count")
        plt.savefig("img/3a.png")
        plt.show()

        # -- 3б - кількість внесеного пива в кожному місті
        values = main.execute_sql(cursor, query_path, 2)
        plt.pie(x=[v[0] for v in values], labels=[v[1] for v in values], autopct="%.1f%%")
        plt.savefig("img/3b.png")
        plt.show()

        # -- 3в. залежність міцності пива від сорту (стиль)
        values = main.execute_sql(cursor, query_path, 3)
        abv = [v[1] for v in values]
        sorts = [v[2] for v in values]
        xs = range(len(abv))
        plt.bar(xs, height=abv)
        plt.xticks(xs, sorts)
        for x, a, s in zip(xs, abv, abv):
            plt.text(x, a/2, s, color="w")
        plt.savefig("img/3c.png")
        plt.show()
