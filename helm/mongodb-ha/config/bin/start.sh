#!/bin/bash
sleep 30
/data/etc/gen-config-replica.sh
mongo < /data/etc/create-replica.js
mongo < /data/etc/setup-account.js
mongo -u $REPLICA_USER -p $REPLICA_PASSWORD --eval "rs.status()" --authenticationDatabase $DATABASE_NAME