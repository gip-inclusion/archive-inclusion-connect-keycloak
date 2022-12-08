#!/usr/bin/env python3
import datetime
import requests
import sys
import json
from base import get_server_data_args

server_config, args = get_server_data_args()
if len(args) != 1:
    print("You must supply a JSON file")
    sys.exit()
print()
print("* Parsing JSON file")
data = json.load(open(args[0]))

print()
print("* Updating JSON file (set ifResourceExists to SKIP and createdTimestamp to now")
if "" not in data:
    data["ifResourceExists"] = "SKIP"
now = int(datetime.datetime.now().timestamp() * 1000)
for user in data["users"]:
    user["createdTimestamp"] = now

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
print("* User batch creation")
res = requests.post(
    f"{server_config.url}/admin/realms/{server_config.realm}/partialImport",
    json=data,
    headers={'Authorization': 'Bearer ' + token},
)
print(res.json())
