#!/bin/bash

MKDIR=$(which mkdir)
MAIL=$(which mail)
CAT=$(which cat)
DATE=$(which date)
AWK=$(which awk)
SERVICE=$(which service)
MYSQLDUMP=$(which mysqldump)
PG_DUMP=$(which pg_dump)
DU=$(which du)
MONGODUMP=$(which mongodump)

MYSQL_DATA="/var/lib/mysql"
MYSQL_DUMP_DST="/mysqldumps"
MYSQL_USER="root"
MYSQL_PASS=""

MONGO_DUMP_DST="/mongodumps"

PSQL_DUMP_DST="/psqldumps"
PSQL_USER="klez"
PSQL_HOST="127.0.0.1"
PSQL_PORT="5432"
PSQL_PASS="12345"
