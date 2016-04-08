.PHONY: build start test stop

build:
	docker build -t "pviotti/zookeeper" .

start:
	./start-cluster.sh

test:
	./test-cluster.sh

stop:
	./stop-cluster.sh
	
