#!/bin/bash
if [[ $(nodetool status | grep $POD_IP) == *"UN"* ]]; then
    echo "decommissioning node"
    nodetool decommission \
    && rm -rf /var/lib/cassandra/data/* \
    && rm -rf /var/lib/cassandra/commitlog \
    && rm -rf /var/lib/cassandra/saved_caches \
    && rm -rf /var/log/cassandra/
else
    exit 0;
fi