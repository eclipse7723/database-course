from lab2.main import login
import csv


tables = ["Beers", "Breweries", "Locations",
          "Styles", "Types", "Breweries_Types"]


with login() as connect:
    cursor = connect.cursor()

    for table_name in tables:
        cursor.execute("SELECT * FROM %s" % table_name)

        columns = [col[0] for col in cursor.description]
        with open("export\\%s.csv" % table_name, "w", newline='') as f:
            writer = csv.writer(f)
            writer.writerow(columns)
            for row in cursor:
                writer.writerow(row)
