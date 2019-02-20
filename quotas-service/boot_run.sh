#!/bin/bash

# Quotas Service directory ENV ...
QS_DIR="/opt/quotas_service"
QS_INSTALL_DIR="$QS_DIR/install/"
QS_SERVICE_DIR="/opt/log/service"
QS_SETTINGS_DIR="/etc/log/"

# KEYSTONE HOST ENV ...
KEYSTONE_HOST=${KEYSTONE_HOST:-""}
KEYSTONE_PORT=${KEYSTONE_PORT:-""}

# MYSQL ENV ...
MYSQL_HOST=${MYSQL_HOST:-""}
MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-""}
MYSQL_DATABASE=${MYSQL_DATABASE:-""}
MYSQL_USER=${MYSQL_USER:-""}
MYSQL_PASSWORD=${MYSQL_PASSWORD:-""}
MYSQLD_ARGS=${MYSQLD_ARGS:-""}

# MongoDB ENV ...
MONGO_DB_HOST=${MONGO_DB_HOST:-"127.0.0.1"}
MONGO_DB_PORT=${MONGO_DB_PORT:-"27017"}
MONGO_DB_USER=${MONGO_DB_USER:-"log"}
MONGO_DB_PASSWORD=${MONGO_DB_PASSWORD:-"log"}
MONGO_DB=${MONGO_DB:-"log_service"}

if [[ -z ${MYSQL_HOST} ]]; then
  echo "ERROR: "
  echo "  Please configure the database connection."
  echo "  Cannot continue without a database. Aborting..."
  exit 1
else
	echo "Connection to $MYSQL_HOST MySQL Server ...."
	if [[ ! -z $MYSQL_USER ]] && [[ ! -z $MYSQL_PASSWORD ]]; then
		mysql --host=$MYSQL_HOST --user=$MYSQL_USER --password=$MYSQL_PASSWORD -e "grant all on *.* to 'root'@'%' identified by '$MYSQL_PASSWORD' with grant option;"
		mysql --host=$MYSQL_HOST --user=$MYSQL_USER --password=$MYSQL_PASSWORD < $QS_INSTALL_DIR/create_log_database.sql
		mysql --host=$MYSQL_HOST --user=$MYSQL_USER --password=$MYSQL_PASSWORD < $QS_INSTALL_DIR/setting_trigger.sql
	fi
fi

rm -rf $QS_DIR

if [ $MONGO_DB_HOST == "127.0.0.1" ]; then
	service mongodb start
	mongo --host 127.0.0.1 --eval '
	db = db.getSiblingDB("log_service");
	db.addUser({
		user: "log",
		pwd: "log",
		roles: [ "readWrite", "dbAdmin" ]
	})'
elif [ $MONGO_DB_USER != "" ] && [ $MONGO_DB_PASSWORD != "" ]; then
	mongo --host $MONGO_DB_HOST --port ${MONGO_DB_PORT} --eval "
	db = db.getSiblingDB(\"$MONGO_DB\");
	db.addUser({
		user: \"$MONGO_DB_USER\",
		pwd: \"$MONGO_DB_PASSWORD\",
		roles: [ \"readWrite\", \"dbAdmin\" ]
	})"
else
	echo "ERROR: "
	echo "  Please configure the mongodb connection."
	echo "  Cannot continue without a mongodb. Aborting..."
	exit 1
fi


if [[ -z ${KEYSTONE_HOST} ]] && [[ -z ${KEYSTONE_PORT} ]]; then
	echo "ERROR: "
	echo "  Please configure the keystone connection."
	echo "  Cannot continue without a keystone api. Aborting..."
	exit 1
fi

echo "
mongodb_info = {
    'host': \"$MONGO_DB_HOST\",
    'port': \"$MONGO_DB_PORT\",
    'user': \"$MONGO_DB_USER\",
    'password': \"$MONGO_DB_PASSWORD\",
    'database': \"$MONGO_DB\",
}
" >> "$QS_SETTINGS_DIR/setting.py"

echo "
mysql_info = {
   'host': \"$MYSQL_HOST\",
   'user': \"$MYSQL_USER\",
   'password': \"$MYSQL_PASSWORD\"
}
" >> "$QS_SETTINGS_DIR/setting.py"

echo "
keystone_info = {
   'host': \"$KEYSTONE_HOST\",
   'port': \"$KEYSTONE_PORT\"
}
" >> "$QS_SETTINGS_DIR/setting.py"

service log-service start

CMD=${1:-"exit 0"}
if [[ "$CMD" == "-d" ]];
then
	/usr/sbin/sshd -D -d
else
	/bin/bash -c "$*"
fi
