.PHONY: build start test stop

build:
	docker build -t "pviotti/zookeeper:3.4.9" .

start:
	./start-cluster.sh

test:
	./test-cluster.sh

stop:
	./stop-cluster.sh
	
