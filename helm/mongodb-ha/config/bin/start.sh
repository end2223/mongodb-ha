#!/bin/bash
/usr/local/bin/docker-entrypoint.sh mongod --replSet "$REPLICA_CLUSTER" &> /dev/null &
sleep 10
cp -r /data /data-777
if [[ "$POD_NAME" -eq "mongodb-stateful-set-0" ]]
then
    sleep 120
    /data-777/etc/gen-config-replica.sh
    mongo < /data-777/etc/create-replica.js
    mongo < /data/-777etc/setup-account.js
    mongo -u $REPLICA_USER -p $REPLICA_PASSWORD --eval "rs.status()" --authenticationDatabase $DATABASE_NAME
fi

tail -f /dev/null