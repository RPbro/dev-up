#
# alpine 3.10 nginx镜像编译文件
#

FROM alpine:3.10

LABEL maintainer="Chao Lyu <lc91926@gmail.com>"

RUN echo "http://mirrors.aliyun.com/alpine/v3.10/main" > /etc/apk/repositories \
    && echo "http://mirrors.aliyun.com/alpine/v3.10/community" >> /etc/apk/repositories \
    && apk update \
    && apk add nginx-mod-http-lua lua5.1-cjson tzdata \
    && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "alias \"ll=ls -lh\" " >> /root/.bashrc \
    && rm -rf /etc/nginx/conf.d/* \
    && apk del tzdata
