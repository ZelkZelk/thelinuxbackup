#!/bin/bash

MKDIR=$(which mkdir)
MAIL=$(which mail)
CAT=$(which cat)
DATE=$(which date)
AWK=$(which awk)
SERVICE=$(which service)
MYSQLDUMP=$(which mysqldump)
DU=$(which du)
MONGODUMP=$(which mongodump)

MYSQL_DATA="/var/lib/mysql"
MYSQL_DUMP_DST="/mysqldumps"
MYSQL_USER="root"
MYSQL_PASS=""

MONGO_DUMP_DST="/mongodumps"
