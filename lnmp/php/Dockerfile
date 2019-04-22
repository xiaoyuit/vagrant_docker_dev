FROM php:7.2.5-fpm-alpine3.7

COPY ["packages/swoole-src-4.0.3.tar.gz","/tmp/swoole-src-4.0.3.tar.gz"]
COPY ["packages/redis-4.0.2.tgz","/tmp/redis.tar.gz"]
COPY ["packages/xdebug-2.7.1.tar.gz","/tmp/xdebug-2.7.1.tar.gz"]

COPY ["conf/php/php.ini","/usr/local/etc/php/php.ini"]
COPY ["conf/php-fpm.conf","/usr/local/etc/php-fpm.conf"]
COPY ["conf/php-fpm.d/www.conf","/usr/local/etc/php-fpm.d/www.conf"]

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
    && apk update \
    && apk add \
        curl bash tree tzdata shadow vim \
        libpng-dev \
        freetype-dev \
        libjpeg-turbo-dev \
        libstdc++ \
    && rm -rf /var/cache/apk/* \
    && usermod -u 1000 www-data \
    && groupmod -g 1000 www-data \
    # MAC系统需要增加
    # && usermod -G staff www-data \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
        zip \
        pcntl \
        pdo_mysql \
        opcache \
        mysqli \
        mbstring \
    # redis扩展
    && tar xfz /tmp/redis.tar.gz \
    && rm -r /tmp/redis.tar.gz \
    && mkdir -p /usr/src/php/ext \
    && mv redis-4.0.2 /usr/src/php/ext/redis \
    && docker-php-ext-install redis \
    # swoole扩展
    && tar xfz /tmp/swoole-src-4.0.3.tar.gz \
    && rm -r /tmp/swoole-src-4.0.3.tar.gz \
    && mkdir -p /usr/src/php/ext \
    && mv swoole-src-4.0.3 /usr/src/php/ext/swoole \
    && docker-php-ext-install swoole \
    # xdebug扩展
    && tar xfz /tmp/xdebug-2.7.1.tar.gz \
    && rm -r /tmp/xdebug-2.7.1.tar.gz \
    && mkdir -p /usr/src/php/ext \
    && mv xdebug-2.7.1 /usr/src/php/ext/xdebug \
    && docker-php-ext-install xdebug \
    # 清理临时文件
    && rm -rf /usr/src/php \
    # 安装composer
    && php -r "readfile('http://install.phpcomposer.com/installer');" | php -- --install-dir=/bin/ --filename=composer \
    && composer config -g repo.packagist composer https://packagist.laravel-china.org \
    # 设置时区
    && cp -r -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    # 自定义命令
    && echo "alias ll='ls -alF'" >> /root/.bashrc \
    && echo "alias l='ls -CF'" >> /root/.bashrc

WORKDIR /root