#!/bin/sh
mkdir -p /var/log/rexster
DOCKERHOST=`hostname`
DOCKERIP=`grep $DOCKERHOST /etc/hosts|awk '{print $1}'`
sed 's/{{DOCKERIP}}/'"$DOCKERIP"'/g' /rexster-server/config/rexster.tpl.xml > /rexster-server/config/rexster.xml
cd /rexster-server
exec /rexster-server/bin/rexster.sh -s -c /rexster-server/config/rexster.xml >> /var/log/rexster/rexster.log 2>&1
