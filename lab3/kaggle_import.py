from lab2.main import login
import csv
import os


def truncate(cur, table):
    cur.execute("TRUNCATE TABLE %s CASCADE" % table)


def get_data_from_csv(path, limit=None):
    if os.path.exists(path) is False:
        print(f"<!> import failure: incorrect path to csv data: {path!r}")
        return []
    with open(path, "r", encoding = 'cp850') as f:
        reader = csv.DictReader(f)
        data = []
        for i, row in enumerate(reader):
            data.append(row)
            if limit is not None and i == limit:
                break
        return data


def insert_table(cursor, query, table):
    for row in table:
        values = tuple([str(v).replace("'", "") if v != "" else "NULL" for v in row])
        # print(query, row, values)
        cursor.execute(query % values)


project_path = "\\".join(os.path.dirname(__file__).split("\\")[:-1])
csv_dir = "\\Resources\\beers-breweries-and-beer-reviews\\"
beers_path = project_path + csv_dir + "beers.csv"
breweries_path = project_path + csv_dir + "breweries.csv"


insert_queries = {
    "Beers": "INSERT INTO Beers (beer_id, brewery_id, style_id, name, abv) VALUES (%s, %s, %s, '%s', %s)",
    "Breweries": "INSERT INTO Breweries (brewery_id, loc_id, name) VALUES (%s, %s, '%s')",
    "Locations": "INSERT INTO Locations (loc_id, country, state, city) VALUES (%s, '%s', '%s', '%s')",
    "Styles": "INSERT INTO Styles (style_id, name) VALUES (%s, '%s')",
    "Types": "INSERT INTO Types (type_id, name) VALUES (%s, '%s')",
    "Breweries_Types": "INSERT INTO Breweries_Types (brewery_id, type_id) VALUES (%s, %s)"
}

# парсинг таблиц
beers = get_data_from_csv(beers_path)
breweries = get_data_from_csv(breweries_path)

# ------------- порядок:
# styles, types, locations
# then breweries, breweries_types
# and in the end beers

# подготовка к заполнению таблиц
Styles = tuple(set([v['style'] for v in beers]))
Types = tuple(set([x[i] for x in [v['types'].split(", ") for v in breweries] for i in range(len(x))]))
Locations = tuple(set([(v['country'], v['state'], v['city']) for v in breweries]))
Breweries = [(v['id'], v['city'], v['name']) for v in breweries]
Breweries_Types = [(v['id'], v['types'].split(", ")) for v in breweries]
Beers = [(v['id'], v['brewery_id'], v['style'], v['name'], v['abv']) for v in beers]

# таблица соответствий
n_locs = {v[2]: i for i, v in enumerate(Locations)}
n_types = dict([(x[1], x[0]) for x in enumerate(Types)])
n_styles = dict([(x[1], x[0]) for x in enumerate(Styles)])

# замена текстовых значений на идентификаторы
Breweries = [(v[0], n_locs[v[1]], v[2]) for v in Breweries]
locs = ([((x[0],) + x[1]) for x in enumerate(Locations)])
Beers = [(v[:2] + (n_styles[v[2]],) + v[3:]) for v in Beers]


with login() as connect:
    cursor = connect.cursor()

    for table in insert_queries.keys():
        truncate(cursor, table)

    insert_table(cursor, insert_queries["Styles"], set(enumerate(Styles)))
    insert_table(cursor, insert_queries["Types"], set(enumerate(Types)))
    insert_table(cursor, insert_queries["Locations"], locs)
    insert_table(cursor, insert_queries["Breweries"], Breweries)
    for item in Breweries_Types:
        _id = item[0]
        for _type in item[1]:
            cursor.execute(insert_queries["Breweries_Types"] % (_id, n_types[_type]))
    insert_table(cursor, insert_queries["Beers"], Beers)
