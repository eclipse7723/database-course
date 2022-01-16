from lab2.main import login
import matplotlib.pyplot as plt


if __name__ == "__main__":
    with login() as connect:
        cursor = connect.cursor()

        # setup views
        with open("create.sql", "r") as f:
            view_command = f.read()
            cursor.execute(view_command)

        queries = [
            "SELECT * FROM abv_count",
            "SELECT * FROM city_count",
            "SELECT * FROM avg_style_abv",
        ]

        # -- 3а - розподілення міцності пива - стовпчкова
        cursor.execute(queries[0])
        values = cursor.fetchall()
        plt.bar([v[0] for v in values], [v[1] for v in values])
        plt.ylabel("alcohol by volume")
        plt.xlabel("count")
        plt.savefig("img/3a.png")
        plt.show()

        # -- 3б - кількість внесеного пива в кожному місті
        cursor.execute(queries[1])
        values = cursor.fetchall()
        plt.pie(x=[v[0] for v in values], labels=[v[1] for v in values], autopct="%.1f%%")
        plt.savefig("img/3b.png")
        plt.show()

        # -- 3в. залежність міцності пива від сорту (стиль)
        cursor.execute(queries[2])
        values = cursor.fetchall()
        abv = [v[1] for v in values]
        sorts = [v[2] for v in values]
        xs = range(len(abv))
        plt.bar(xs, height=abv)
        plt.xticks(xs, sorts)
        for x, a, s in zip(xs, abv, abv):
            plt.text(x, a / 2, s, color="w")
        plt.savefig("img/3c.png")
        plt.show()
