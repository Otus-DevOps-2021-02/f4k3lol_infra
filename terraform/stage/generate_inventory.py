#!/usr/bin/python3

import click
import json
import subprocess
import os
from pprint import pprint
import re


@click.command()
@click.option("--list", "list_flag", is_flag=True)
def get_inventory(list_flag):

    #Меняем рабочую директорию на папку со скриптом
    currentFile = __file__
    realPath = os.path.realpath(currentFile)
    dirPath = os.path.dirname(realPath)
    os.chdir(dirPath)

    #Выполняем команду terraform output
    terraform_outputs = subprocess.run(
        "terraform output", stdout=subprocess.PIPE, shell=True
    ).stdout.decode("ascii")

    # Находим переменные
    app_ip = re.search(r"external_ip_address_app = (\S+)\s", terraform_outputs).group(1)
    db_ip = re.search(r"external_ip_address_db = (\S+)\s", terraform_outputs).group(1)

    #Если передан --list - выводим json
    if list_flag:
        data = {
            "all": {"children": ["app", "db"]},
            "app": {"hosts": [app_ip]},
            "db": {"hosts": [db_ip]},
        }
        click.echo(json.dumps(data))


if __name__ == "__main__":
    get_inventory()
