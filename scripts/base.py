from dataclasses import dataclass
from optparse import OptionParser

@dataclass
class ServerConfig:
    url: str
    username: str
    password: str
    realm: str


def get_server_data_args():
    parser = OptionParser()
    parser.add_option("--url", dest="url")
    parser.add_option("--username", dest="username")
    parser.add_option("--password", dest="password")
    parser.add_option("--realm", dest="realm")
    options, args = parser.parse_args()

    print("* Server url and credentials. Default values are for local environment.")
    url = options.url or input("Server URL: ") or "http://localhost:8080"
    username = options.username or input("Username: ") or "admin"
    password = options.password or input("Password: ") or "password"
    realm = options.realm or input("Realm: ") or "local"
    return ServerConfig(url=url, username=username, password=password, realm=realm), args