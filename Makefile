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

# composer
export COMPOSER_HOME = ./data/composer

# php7.2
export PHP72_CONTAINER_NAME = dev-php72
export PHP72_FPM_IMAGE = dev-php72
export PHP72_FPM_TAG = 1.0
export PHP72_PHP_CONF_FILE=./conf/php/php72/php.ini
export PHP72_FPM_CONF_FILE=./conf/php/php72/php-fpm.conf
export PHP72_EXTENSION_CONF_FILE=./conf/php/php72/php-extension.ini

# php7.3
export PHP73_CONTAINER_NAME = dev-php73
export PHP73_FPM_IMAGE = dev-php73
export PHP73_FPM_TAG = 1.0
export PHP73_PHP_CONF_FILE=./conf/php/php73/php.ini
export PHP73_FPM_CONF_FILE=./conf/php/php73/php-fpm.conf
export PHP73_EXTENSION_CONF_FILE=./conf/php/php73/php-extension.ini

# php7.4
export PHP74_CONTAINER_NAME = dev-php74
export PHP74_FPM_IMAGE = dev-php74
export PHP74_FPM_TAG = 1.0
export PHP74_PHP_CONF_FILE=./conf/php/php74/php.ini
export PHP74_FPM_CONF_FILE=./conf/php/php74/php-fpm.conf
export PHP74_EXTENSION_CONF_FILE=./conf/php/php74/php-extension.ini

build: build-nginx build-mysql build-redis build-php72 build-php73 build-php74

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

build-php72:
	docker build -t ${PHP72_FPM_IMAGE}:${PHP72_FPM_TAG} -f Dockerfiles/php72.Dockerfile .

build-php73:
	docker build -t ${PHP73_FPM_IMAGE}:${PHP73_FPM_TAG} -f Dockerfiles/php73.Dockerfile .

build-php74:
	docker build -t ${PHP74_FPM_IMAGE}:${PHP74_FPM_TAG} -f Dockerfiles/php74.Dockerfile .