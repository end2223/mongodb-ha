admin = db.getSiblingDB("__database_name")
admin.createUser(
  {
    user: "__admin_user",
    pwd: "__admin_password",
    roles: [ { role: "userAdminAnyDatabase", db: "__database_name" } ]
  }
)// let's authenticate to create the other user
db.getSiblingDB("__database_name").auth("__admin_user", "__admin_password" )
db.getSiblingDB("__database_name").createUser(
  {
    "user" : "__replica_user",
    "pwd" : "__replica_password",
    roles: [ { "role" : "clusterAdmin", "__replica_user" : "__replica_password" } ]
  }
)