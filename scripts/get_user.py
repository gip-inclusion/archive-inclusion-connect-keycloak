#!/usr/bin/env python3
from datetime import datetime
import requests
import sys
from base import get_server_data_args

server_config, args = get_server_data_args()
if len(args) != 1:
    print("You must supply a user ID")
    sys.exit()

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
print(f"* Get user info : sub={args[0]}")
res = requests.get(
    f"{server_config.url}/admin/realms/{server_config.realm}/users/{args[0]}",
    headers={'Authorization': 'Bearer ' + token},
)
data = res.json()
print(f"Name          : {data['lastName'].upper()} {data['firstName']}")
print(f"Email         : {data['email']}")
print(f"Creation      : {datetime.fromtimestamp(data['createdTimestamp']/1000)}")
print(f"Email vérifié : {data['emailVerified']}")
