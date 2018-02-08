.PHONY: build start test stop

build:
	VERSION=$$(cat Dockerfile | grep "ENV zkversion" | cut -d" " -f3); \
	docker build -t "pviotti/zookeeper:$${VERSION}" .

start:
	./start-cluster.sh

test:
	./test-cluster.sh

stop:
	./stop-cluster.sh
	
