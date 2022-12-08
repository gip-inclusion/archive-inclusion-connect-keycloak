#!/usr/bin/env python3
import requests

from openpyxl import Workbook
from datetime import datetime
from base import get_server_data_args


server_config, args = get_server_data_args()

print()
print("* Request for authorization")
res = requests.post(
    f"{server_config.url}/realms/master/protocol/openid-connect/token",
    data={
        "username": server_config.username,
        "password": server_config.password,
        "grant_type": "password",
        "client_id": "admin-cli",
    },
)

if res.status_code != 200:
    print(f"Bad response status: {res.status_code}")
else:
    print("OK")

print()
print("* Recovery of the token")
token = res.json()["access_token"]
print(token)

print()
print("* Export user list")
wb = Workbook()
ws = wb.active
ws.title = "Utilisateurs"
ws.append(["email", "Nom", "Prénom"])

page = 0
user_per_page = 1000
downloaded_users = 0
while True:
    res = requests.get(
        f"{server_config.url}/admin/realms/{server_config.realm}/users",
        params={
            "max": user_per_page,
            "first": page * user_per_page,
            "briefRepresentation": True,
        },
        headers={'Authorization': 'Bearer ' + token},
    )
    users = res.json()

    if not users:
        break
    else: 
        downloaded_users += len(users)

    for user in users:
        ws.append(
            [
                user["email"],
                user["lastName"],
                user["firstName"],
            ]
        )

    print(f"  Downloaded {downloaded_users} users")
    page += 1


filename = f"utilisateurs_{server_config.realm}_{datetime.now().strftime('%Y%m%d-%H%M%S')}.xlsx"
wb.save(filename)
print(f"* Wrote in {filename}")


