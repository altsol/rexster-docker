#!/bin/sh
mkdir -p /var/log/rexster
cd /rexster-server
exec /rexster-server/bin/rexster.sh -s -c /rexster-server/config/rexster.xml >> /var/log/rexster/rexster.log 2>&1
