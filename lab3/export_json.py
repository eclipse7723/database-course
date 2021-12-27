from lab2.main import login
import json


tables = ["Beers", "Breweries", "Locations",
          "Styles", "Types", "Breweries_Types"]

export = {}
with login() as connect:
    cursor = connect.cursor()

    for table_name in tables:
        cursor.execute("SELECT * FROM %s" % table_name)

        columns = [col[0] for col in cursor.description]

        rows = []
        for row in cursor:
            values = dict(zip(columns, row))
            rows.append(values)

        export[table_name] = rows


with open("export\\database.json", "w", encoding='cp850') as f:
    json.dump(export, f)
