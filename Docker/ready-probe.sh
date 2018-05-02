#!/bin/bash
# status=$(cqlsh -e "select bootstrapped from system.local" | sed -n 2p | tr -d " ")
if [[ $(nodetool status | grep $POD_IP) == *"UN"* ]]; then
    if [[ $DEBUG ]]; then
    echo "Node is up!";
    fi
    exit 0;
else
    if [[ $DEBUG ]]; then
    echo "Node is not up!";
    fi
    exit 1;
fi