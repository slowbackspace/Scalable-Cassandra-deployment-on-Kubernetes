#!/bin/bash

index=$(hostname | rev | cut -d- -f1 | rev) 
if [[ $index == "0" ]]; then
    while true; do
        sleep 20;
        if [[ $(nodetool status | grep $POD_IP) == *"UN"* ]]; then
            break;
        fi
    done

    sleep 5
    output=$(cqlsh -u cassandra -p cassandra -e "describe keyspaces")
    if [[ "${output}" == *"Bad credentials"* ]]; then
        echo "User already created"
    else
        cqlsh -u cassandra -p cassandra -e "CREATE ROLE IF NOT EXISTS $CASSANDRA_USERNAME WITH PASSWORD = '$CASSANDRA_PASSWORD' AND SUPERUSER = true AND LOGIN = true;"
        sleep 1
        random_pass=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
        cqlsh -u $CASSANDRA_USERNAME -p $CASSANDRA_PASSWORD -e "ALTER ROLE cassandra WITH PASSWORD='$random_pass' AND SUPERUSER=false;"
        cqlsh -u $CASSANDRA_USERNAME -p $CASSANDRA_PASSWORD -e "ALTER KEYSPACE system_auth WITH REPLICATION = {class : 'NetworkTopologyStrategy', 'dc1' : 3, 'dc2' : 2}";
    fi
fi
exit 0
