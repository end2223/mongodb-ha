#!/bin/bash

# generate config for replica
replica=""
for ((i=0; i<$NUMBER_REPLICA; i++)); do
  replica="$replica{\"_id\": \"$i\", \"host\": \"mongodb-$i:27017\"}, "
done;
replica="{\"_id\": \"$REPLICA_CLUSTER\", \"members\": [${replica%,*}]}"

# update create replica script
sed -i "s/__CONFIG/$replica/" create-replica.js

# update create account admin, cluster
sed -i "s/__database_name/$DATABASE_NAME/g" setup-account.js
sed -i "s/__admin_user/$ADMIN_USER/g" setup-account.js
sed -i "s/__admin_password/$ADMIN_PASSWORD/g" setup-account.js
sed -i "s/__replica_user/$REPLICA_USER/g" setup-account.js
sed -i "s/__replica_password/$REPLICA_PASSWORD/g" setup-account.js


# admin = db.getSiblingDB("__database_name")
# admin.createUser(
#   {
#     user: "__admin_user",
#     pwd: "__admin_password",
#     roles: [ { role: "userAdminAnyDatabase", db: "__database_name" } ]
#   }
# )// let's authenticate to create the other user
# db.getSiblingDB("__database_name").auth("__admin_user", "__admin_password" )
# db.getSiblingDB("__database_name").createUser(
#   {
#     "user" : "__replica_user",
#     "pwd" : "__replica_password",
#     roles: [ { "role" : "clusterAdmin", "__replica_user" : "__replica_password" } ]
#   }
# )