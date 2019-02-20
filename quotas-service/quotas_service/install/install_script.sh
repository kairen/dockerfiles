#!/bin/bash

DIR=$(dirname $0)
#echo "path: "$DIR
#exit 0

mkdir -p /etc/log/
mkdir -p /opt/log/web/
mkdir -p /opt/log/service/
mkdir -p /var/log/log_service/
touch /var/log/log_service/background_service
touch /var/log/log_service/web_service

cp -R $DIR"/../file/setting/setting.py" "/etc/log/"
cp -R $DIR"/../file/web/"* "/opt/log/web/"
cp -R $DIR"/../file/service/"* "/opt/log/service/"
cp -R $DIR"/../file/init.d/log_service" "/etc/init.d"
echo "Install Success."

mysql --user=root --password=quotas < $DIR"/create_log_database.sql"
#echo "Create Log DataBase Success."

mysql --user=root --password=quotas < $DIR"/setting_trigger.sql"
#echo "Setting Trigger Success."

echo "Installed Finished."
