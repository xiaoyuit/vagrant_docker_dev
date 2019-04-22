FROM redis:4.0.9-alpine
USER root

COPY ["conf/redis.conf","/etc/redis/redis.conf"]

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
	&& apk update \
	&& apk add \
        curl bash tree tzdata shadow vim \
    && rm -rf /var/cache/apk/* \
    && usermod -u 1000 redis \
    && groupmod -g 1000 redis \
	&& cp -r -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
	&& echo "alias ll='ls -alF'" >> /root/.bashrc \
	&& echo "alias l='ls -CF'" >> /root/.bashrc \
	&& echo "echo -n never > /sys/kernel/mm/transparent_hugepage/enabled" >> /root/.bashrc \
	&& echo "echo 1 > /proc/sys/vm/overcommit_memory" >> /root/.bashrc

WORKDIR /root