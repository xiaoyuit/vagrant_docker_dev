FROM nginx:1.14.0-alpine

COPY ["conf/nginx.conf","/etc/nginx/nginx.conf"]

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
	&& apk update \
	&& apk add \
        curl bash tree tzdata shadow vim \
    && groupadd www-data \
    && useradd -g www-data -M -s /sbin/nologin www-data \
    && rm -rf /var/cache/apk/* \
    && usermod -u 1000 www-data \
    && groupmod -g 1000 www-data \
	&& cp -r -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
	&& echo "alias ll='ls -alF'" >> /root/.bashrc \
	&& echo "alias l='ls -CF'" >> /root/.bashrc


WORKDIR /root
