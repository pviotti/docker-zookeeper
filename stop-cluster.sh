#! /usr/bin/env bash

set -e

docker ps -a | grep "pviotti/zookeeper" | cut -d" " -f1 | xargs -I{} docker rm -f {} > /dev/null 2>&1

docker network rm zk > /dev/null 2>&1

echo "Stopped the cluster and cleared all of the running containers."
