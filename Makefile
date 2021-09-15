# conf
export PROJECT_DIR = ../project

# nginx
export NGINX_CONTAINER_NAME = dev-nginx
export NGINX_IMAGE = dev-nginx
export NGINX_TAG = 1.0
export NGINX_HTTP_HOST_PORT = 80
export NGINX_CONFD_DIR = ./conf/nginx/conf.d
export NGINX_CONF_FILE = ./conf/nginx/nginx.conf
export NGINX_LOG_DIR = ./log/nginx

# mysql
export MYSQL_CONTAINER_NAME = dev-mysql
export MYSQL_IMAGE = dev-mysql
export MYSQL_TAG = 1.0
export MYSQL_HOST_PORT = 3306
export MYSQL_ROOT_PASSWORD=123456
export MYSQL_DATA_DIR=./data/mysql
export MYSQL_CONF_FILE=./conf/mysql/mysql.cnf

# redis
export REDIS_CONTAINER_NAME = dev-redis
export REDIS_IMAGE = dev-redis
export REDIS_TAG = 1.0
export REDIS_HOST_PORT=6379
export REDIS_CONF_FILE=./conf/redis/redis.conf

# rabbitmq
export RABBIT_CONTAINER_NAME = dev-rabbitmq
export RABBIT_IMAGE = dev-rabbitmq
export RABBIT_TAG = 1.0
export RABBIT_AMQP_PORT = 5672
export RABBIT_HTTP_PORT = 15672
export RABBIT_ROOT_USER=root
export RABBIT_ROOT_PASSWORD=123456
export RABBIT_DATA_DIR=./data/rabbitmq

# pulsar
export PULSAR_CONTAINER_NAME = dev-pulsar
export PULSAR_IMAGE = dev-pulsar
export PULSAR_TAG = 1.0
export PULSAR_PORT = 6650
export PULSAR_HTTP_PORT = 8080
export PULSAR_CONF_DIR=./conf/pulsar
export PULSAR_DATA_DIR=./data/pulsar

# zookeeper
export ZOOKEEPER_CONTAINER_NAME = dev-zookeeper
export ZOOKEEPER_IMAGE = wurstmeister/zookeeper
export ZOOKEEPER_TAG = 1.0
export ZOOKEEPER_HOST_PORT=2181
export ZOOKEEPER_DATA_DIR=./data/zookeeper

# kafka
export KAFKA_CONTAINER_NAME = dev-kafka
export KAFKA_IMAGE = wurstmeister/kafka
export KAFKA_TAG = 1.0
export KAFKA_HOST_PORT=9092
export KAFKA_LOG_DIR = ./log/kafka
export KAFKA_ADVERTISED_LISTENERS = docker.for.mac.host.internal
export KAFKA_LISTENERS = 0.0.0.0

build: build-nginx build-mysql build-redis build-rabbitmq build-pulsar

start:
	docker-compose up -d

restart:
	docker-compose restart

stop:
	docker-compose stop

delete:
	docker-compose stop
	docker-compose rm -f

build-nginx:
	docker build -t ${NGINX_IMAGE}:${NGINX_TAG} -f Dockerfiles/nginx.Dockerfile .

build-mysql:
	docker build -t ${MYSQL_IMAGE}:${MYSQL_TAG} -f Dockerfiles/mysql.Dockerfile .

build-redis:
	docker build -t ${REDIS_IMAGE}:${REDIS_TAG} -f Dockerfiles/redis.Dockerfile .

build-rabbitmq:
	docker build -t ${RABBIT_IMAGE}:${RABBIT_TAG} -f Dockerfiles/rabbitmq.Dockerfile .

build-pulsar:
	docker build -t ${PULSAR_IMAGE}:${PULSAR_TAG} -f Dockerfiles/pulsar.Dockerfile .