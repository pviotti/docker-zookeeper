#!/usr/bin/env bash

set -e

ZK_VERSION=$(cat Dockerfile | grep "ENV zkversion" | cut -d" " -f3)
ZK_CLUSTER_SIZE=${ZK_CLUSTER_SIZE:-3}
SERVERS=$(for i in `seq 1 $ZK_CLUSTER_SIZE`; do echo -n zookeeper$i,; done)
SERVERS=${SERVERS%,}

if docker ps -a | grep "pviotti/zookeeper" >/dev/null; then
  echo -e "\nIt looks like you already have some ZooKeeper containers running."
  echo    "Please take them down before attempting to bring up another"
  echo -e "cluster with the following command:\n"
  echo -e "  make stop\n"
  exit 1
fi

echo -e "\nBringing up cluster nodes:\n"

if ! docker network ls | grep zk >/dev/null ; then
    docker network create zk >/dev/null 2>&1
fi

for i in `seq 1 $ZK_CLUSTER_SIZE`;
do
  docker run  -e "MYID=$i" \
              -e "SERVERS=$SERVERS" \
              -h "zookeeper$i" \
              --net="zk" \
              --name="zookeeper$i" \
              -d pviotti/zookeeper:$ZK_VERSION > /dev/null 2>&1

  ZK_IP=`docker inspect -f '{{.NetworkSettings.Networks.zk.IPAddress}}' "zookeeper$i"`
  echo "Started zookeeper$i ($ZK_IP)"
done

