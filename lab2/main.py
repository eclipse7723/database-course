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


with login() as connect:
    input("1231231")
