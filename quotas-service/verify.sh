#!/bin/bash

if [ -z $1 ]; then
	echo "Input a Docker Image id or name ..."
	exit 1
fi
docker run --name quotas-service -ti \
-p 8080:8080 \
-e MYSQL_HOST="10.0.0.11" \
-e MYSQL_USER="root" -e MYSQL_PASSWORD="openstack" \
-e KEY_STONE_HOST="10.0.0.11" -e KEY_STONE_PORT="5000" \
-e MONGO_DB_HOST="10.0.0.11" \
-e MONGO_DB_USER="loguser" -e MONGO_DB_PASSWORD="logpassword" \
$1 $2
