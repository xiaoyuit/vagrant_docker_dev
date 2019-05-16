FROM alpine:3.9.4
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update \
    && apk add \
    	git \
    	nodejs \
    && rm -rf /var/cache/apk/* \
    # 自定义命令
    && echo "alias ll='ls -alF'" >> /root/.bashrc \
    && echo "alias l='ls -CF'" >> /root/.bashrc \
    && source /root/.bashrc

EXPOSE 1229 1116
WORKDIR /socketlog