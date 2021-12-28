import psycopg2
import json
import os


def login():
    project_path = "\\".join(os.path.dirname(__file__).split("\\")[:-1])
    json_path = "\\Resources\\login.json"
    path = project_path + json_path
    if os.path.exists(path) is False:
        print(f"<!> login failure: incorrect path to json login data: {path!r}")
        return

    with open(path, "r") as f:
        login_data = json.load(f)
        s_login = " ".join(map("=".join, login_data.items()))
        connect = psycopg2.connect(s_login)
        return connect


def execute_sql(cursor, path, specific=None, log=False):
    abs_path = os.path.abspath(path)
    if os.path.exists(path) is False:
        print(f"<!> login failure: incorrect path to query: {abs_path!r}")
        return
    if path.endswith(".sql") is False:
        print(f"<!> input file must be .sql, not {path!r}")
        return

    values = []
    with open(path, 'r') as f:
        text = f.read()
        sql_commands = text.split(';')
        for i, com in enumerate(sql_commands):
            if isinstance(specific, int) and i != specific:
                continue
            try:
                if log: print(f"  * execute:\n{com}")
                cursor.execute(com)
                values = cursor.fetchall()

                fn = lambda x: x.strip() if isinstance(x, str) else x
                if values is None:
                    return
                if log: print(f"  * output:")
                for row in values:
                    if log: print(list(map(fn, row)))
            except Exception as e:
                if log: print(f"... something went wrong (may be invalid query): {e}")
                continue
        return values


if __name__ == "__main__":
    with login() as connect:
        cur = connect.cursor()
        execute_sql(cur, "create.sql")
        execute_sql(cur, "populate.sql")
        execute_sql(cur, "query.sql", specific=0, log=True)
