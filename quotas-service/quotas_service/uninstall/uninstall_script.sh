#!/bin/bash

DIR=$(dirname $0)
#echo $DIR
#exit 0

rm -R "/var/log/log_service"
rm -R "/etc/log"
rm -R "/opt/log/web"
rm -R "/opt/log/service"
rm -R "/etc/init.d/log_service"
echo "Remove file Success."

mysql -u root -p < $DIR"/drop_mysql_setting.sql"
echo "Remove Log Database and Trigger Success."

echo "Removed Finished."
