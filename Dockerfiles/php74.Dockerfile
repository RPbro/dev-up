#
# php 7.4.14-fpm-alpine 镜像编译文件
#

FROM php:7.4.14-fpm-alpine

LABEL maintainer="Chao Lyu <lc91926@gmail.com>"

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /tmp/composer
ENV COMPOSER_PKG "composer-2.0.9.phar"

ENV PEAR_PROXY ""
ENV PHP_EXT_IGBINARY_PKG "igbinary-3.2.1.tgz"
ENV PHP_EXT_PSR_PKG "psr-1.0.1.tgz"
ENV PHP_EXT_PHALCON_PKG "phalcon-4.1.0.tgz"
ENV PHP_EXT_PROTOBUF_PKG "protobuf-3.14.0.tgz"
ENV PHP_EXT_GRPC_PKG "grpc-1.34.0.tgz"
ENV PHP_EXT_REDIS_PKG "redis-5.3.3.tgz"
ENV PHP_EXT_MONGODB_PKG "mongodb-1.9.0.tgz"

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
    && apk add bash vim git autoconf gcc g++ make pcre-dev re2c libstdc++ tzdata openssl zlib-dev linux-headers freetype-dev libjpeg-turbo-dev libpng-dev libzip-dev \
    && docker-php-ext-configure gd --with-jpeg --with-freetype \
    && docker-php-ext-install -j$(nproc) opcache pdo_mysql gd zip sockets \
    && if [ "$PEAR_PROXY" != "" ] ; then pear config-set http_proxy $PEAR_PROXY ; fi \
    && pecl install /tmp/pkg/$PHP_EXT_IGBINARY_PKG \
    && pecl install /tmp/pkg/$PHP_EXT_PSR_PKG \
    && pecl install /tmp/pkg/$PHP_EXT_PHALCON_PKG \
    && pecl install /tmp/pkg/$PHP_EXT_PROTOBUF_PKG \
    && pecl install /tmp/pkg/$PHP_EXT_GRPC_PKG \
    && pecl install /tmp/pkg/$PHP_EXT_REDIS_PKG \
    && pecl install /tmp/pkg/$PHP_EXT_MONGODB_PKG \
    && docker-php-ext-enable igbinary psr phalcon protobuf grpc redis mongodb \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && apk del autoconf gcc g++ make pcre-dev re2c tzdata openssl \
    && rm -rf /tmp/pkg