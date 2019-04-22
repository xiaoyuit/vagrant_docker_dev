FROM mysql:5.7.25
USER root

COPY ["conf/local.cnf","/etc/mysql/mysql.conf.d/"]

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
	&& sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list \
	&& sed -i 's/security.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list \
	&& apt-get update \
	&& apt-get install -y \
		procps \
		net-tools \
		vim \
	&& rm -r /var/lib/apt/lists/* \
    && usermod -u 1000 mysql \
    && groupmod -g 1000 mysql \
    && chmod -R 644 /etc/mysql/mysql.conf.d/local.cnf \
	&& echo "alias ll='ls -alF'" >> /root/.bashrc \
	&& echo "alias l='ls -CF'" >> /root/.bashrc

