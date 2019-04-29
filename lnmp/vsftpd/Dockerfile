FROM debian:9.5-slim
USER root

COPY ["conf","/etc/vsftpd"]

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list \
    && sed -i 's/security.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list \
    && apt-get update \
    &&  apt-get install -y \
        procps \
        net-tools \
        libterm-readkey-perl \
        vim \
        db-util \
        vsftpd \
    && rm -r /var/lib/apt/lists/* \
    && usermod -u 1000 www-data \
    && groupmod -g 1000 www-data \
    && mkdir -p /var/run/vsftpd/empty \
    && mkdir -p /var/www \
    && bash /etc/vsftpd/update_users.sh \
    && cp /etc/vsftpd/vsftpd /etc/pam.d/vsftpd \
    && cp /etc/vsftpd/vsftpd.conf /etc/vsftpd.conf \
    && echo "alias ll='ls -alF'" >> /root/.bashrc \
    && echo "alias l='ls -CF'" >> /root/.bashrc
