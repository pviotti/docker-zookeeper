# docker-zookeeper [![](https://images.microbadger.com/badges/image/pviotti/zookeeper.svg)](https://microbadger.com/images/pviotti/zookeeper)

This project contains the files to set up a [ZooKeeper](https://zookeeper.apache.org/) cluster with [Docker](http://docker.io).

Image on Docker Hub: https://hub.docker.com/r/pviotti/zookeeper/

## Running

### Build Docker image

```bash
$ git clone https://github.com/pviotti/docker-zookeeper.git
$ cd docker-zookeeper
$ make build
```

### Launch cluster

Environmental variables:

- `DOCKER_ZK_CLUSTER_SIZE` – The number of nodes in your ZooKeeper cluster
  (default: `3`)
 
```bash
$ make start
./start-cluster.sh

Bringing up cluster nodes:

Started zookeeper1 (172.18.0.2)
Started zookeeper2 (172.18.0.3)
Started zookeeper3 (172.18.0.4)
```

### Test

```bash
$ make test
./test-cluster.sh
172.18.0.2:2181 Mode: follower
172.18.0.3:2181 Mode: leader
172.18.0.4:2181 Mode: follower
```

### Stop and destroy

```bash
$ make stop
./stop-cluster.sh
Stopped the cluster and cleared all of the running containers.
```

## Credits and license

License: Apache 2.0.  

For this project I took some pieces of scripts and settings from

 - [jplock/docker-zookeeper](https://github.com/jplock/docker-zookeeper) (which is nice but just for a single Zk host)
 - [mesoscloud/zookeeper](https://github.com/mesoscloud/zookeeper) (which uses Ubuntu as base image and it's unmantained)
 - [hectcastro/docker-riak](https://github.com/hectcastro/docker-riak)

