#! /usr/bin/env bash

set -e

ZK_CLUSTER_SIZE=${ZK_CLUSTER_SIZE:-3}

function run4lw() {
  exec 5<>/dev/tcp/$2/$3;echo $1 >&5;cat <&5 | egrep "Mode: "
}

function srvr() {
  run4lw srvr $1 $2 2> /dev/null
}


for i in `seq 1 $ZK_CLUSTER_SIZE`;
do
    ZK_IP=`docker inspect -f '{{.NetworkSettings.Networks.zk.IPAddress}}' zookeeper$i`
    echo "$ZK_IP:2181 $(srvr $ZK_IP 2181)"
done

