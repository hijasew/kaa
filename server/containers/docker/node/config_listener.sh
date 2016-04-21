#!/bin/bash

#Configure node Kaa services
if [ "$CONTROL_ENABLED" == "false" ]; then
  sed -i "s/\(control_server_enabled *= *\).*/\1false/" /usr/lib/kaa-node/conf/kaa-node.properties
fi
if [ "$BOOTSTRAP_ENABLED" == "false" ]; then
  sed -i "s/\(bootstrap_server_enabled *= *\).*/\1false/" /usr/lib/kaa-node/conf/kaa-node.properties
fi
if [ "$OPERATIONS_ENABLED" == "false" ]; then
  sed -i "s/\(operations_server_enabled *= *\).*/\1false/" /usr/lib/kaa-node/conf/kaa-node.properties
fi

#Specify default NoSQL database
[ "$DATABASE" ] && sed -i "s/\(nosql_db_provider_name *= *\).*/\1$DATABASE/" /usr/lib/kaa-node/conf/dao.properties;

#Configure SQL database
[ "$JDBC_HOST" ] && sed -i "s/\(jdbc_host *= *\).*/\1$JDBC_HOST/" /usr/lib/kaa-node/conf/dao.properties;
[ "$JDBC_HOST" ] && sed -i "s/\(jdbc_url *= *\).*/\1jdbc\:postgresql\:\/\/$JDBC_HOST\:5432\/kaa/" /usr/lib/kaa-node/conf/admin-dao.properties;
[ "$JDBC_PORT" ] && sed -i "s/\(jdbc_port *= *\).*/\1$JDBC_PORT/" /usr/lib/kaa-node/conf/dao.properties;


#Configure cluster setup
[ "$ZK_HOSTS" ] && sed -i "s/\(zk_host_port_list *= *\).*/\1$ZK_HOSTS/" /usr/lib/kaa-node/conf/kaa-node.properties;
[ "$CASSANDRA_HOSTS" ] && sed -i "s/\(node_list *= *\).*/\1$CASSANDRA_HOSTS/" /usr/lib/kaa-node/conf/common-dao-cassandra.properties;
[ "$MONGODB_HOSTS" ] && sed -i "s/\(servers *= *\).*/\1$MONGODB_HOSTS/" /usr/lib/kaa-node/conf/common-dao-mongodb.properties;

HOSTNAME=`ip route get 8.8.8.8 | awk '{print $NF; exit}'`
sed -i "s/\(thrift_host *= *\).*/\1$HOSTNAME/" /usr/lib/kaa-node/conf/kaa-node.properties
sed -i "s/\(transport_public_interface *= *\).*/\1$HOSTNAME/" /usr/lib/kaa-node/conf/kaa-node.properties



