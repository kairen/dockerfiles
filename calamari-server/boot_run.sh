#!/bin/bash

service postgresql restart
su -l postgres -c "createdb calamari"
expect /opt/initialize
service supervisor restart
service salt-master restart
service diamond restart 
service apache2 restart


chmod 777 /var/log/calamari/cthulhu.log
chmod 777 /var/log/calamari/calamari.log

CMD=${1:-"exit 0"}
if [[ "$CMD" == "-d" ]];
then
	tail -f /var/log/calamari/httpd_error.log
else
	/bin/bash -c "$*"
fi