#!/bin/bash
set -e

# Initialization script.
# https://hub.docker.com/_/postgres/#initialization-scripts

export BASE_DIR=$(dirname "$BASH_SOURCE")

# The PostgreSQL user should be able to create extensions.
# Only the PostgreSQL superuser role provides that permission.
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL

  \c postgres;

  CREATE USER $KC_DB_USERNAME WITH ENCRYPTED PASSWORD '$KC_DB_PASSWORD';
  CREATE DATABASE $KC_DB_URL_DATABASE OWNER $KC_DB_USERNAME;
  ALTER USER $KC_DB_USERNAME CREATEDB SUPERUSER;

EOSQL
