#
# php 7.3-fpm-alpine 镜像编译文件
#

FROM php:7.3-fpm-alpine

LABEL maintainer="Chao Lyu <lc91926@gmail.com>"

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /tmp/composer
ENV COMPOSER_PKG "composer-1.10.6.phar"

ENV PEAR_PROXY ""
ENV PHP_EXT_APCU_PKG "apcu-5.1.18.tgz"
ENV PHP_EXT_GRPC_PKG "grpc-1.29.1.tgz"
ENV PHP_EXT_IGBINARY_PKG "igbinary-3.1.2.tgz"
ENV PHP_EXT_PHALCON_PKG "phalcon-4.0.6.tgz"
ENV PHP_EXT_PROTOBUF_PKG "protobuf-3.12.2.tgz"
ENV PHP_EXT_PSR_PKG "psr-1.0.0.tgz"
ENV PHP_EXT_REDIS_PKG "redis-5.2.2.tgz"
ENV PHP_EXT_MONGODB_PKG "mongodb-1.8.0.tar"

COPY ./pkg /tmp/pkg

RUN set -x \
    && OS_VER=$(awk -F. '{printf "v"$1"."$2}' /etc/alpine-release) \
    && echo "http://mirrors.aliyun.com/alpine/$OS_VER/main" > /etc/apk/repositories \
    && echo "http://mirrors.aliyun.com/alpine/$OS_VER/community" >> /etc/apk/repositories \
    && cp /tmp/pkg/$COMPOSER_PKG /usr/local/bin/composer && chmod +x /usr/local/bin/composer && mkdir $COMPOSER_HOME \
    && rm /usr/local/etc/php/conf.d/* \
    && rm /usr/local/etc/php-fpm.d/* \
    && cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini \
    && apk update \
    && apk add bash vim git autoconf gcc g++ make pcre-dev re2c libstdc++ tzdata python2 openssl-dev zlib-dev linux-headers freetype-dev libjpeg-turbo-dev libpng-dev libzip-dev \
    && docker-php-ext-install -j$(nproc) opcache pdo_mysql gd zip \
    && if [ "$PEAR_PROXY" != "" ] ; then pear config-set http_proxy $PEAR_PROXY ; fi \
    && pecl install /tmp/pkg/$PHP_EXT_APCU_PKG \
    && pecl install /tmp/pkg/$PHP_EXT_GRPC_PKG \
    && pecl install /tmp/pkg/$PHP_EXT_IGBINARY_PKG \
    && pecl install /tmp/pkg/$PHP_EXT_PHALCON_PKG \
    && pecl install /tmp/pkg/$PHP_EXT_PROTOBUF_PKG \
    && pecl install /tmp/pkg/$PHP_EXT_PSR_PKG \
    && pecl install /tmp/pkg/$PHP_EXT_REDIS_PKG \
    && pecl install /tmp/pkg/$PHP_EXT_MONGODB_PKG \
    && docker-php-ext-enable igbinary redis apcu grpc protobuf phalcon psr mongodb \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && apk del autoconf gcc g++ make pcre-dev re2c tzdata python2 openssl \
    && rm -rf /tmp/pkg