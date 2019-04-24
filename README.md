# Vagrant+Docker本地开发环境搭建

## 软件信息

| 软件 | 版本 | 备注 |
| ------ | ------ | ------ |
| nginx | 1.14.0-alpine | |
| mysql | 5.7.25 | |
| php | 7.2.5-fpm-alpine3.7 | |
| redis | 4.0.9-alpine | |
| vsftpd | 3.0.3 | |

## 安装方式
### 一、下载所需软件
#### 1）VirtualBox
Mac
```
https://download.virtualbox.org/virtualbox/5.2.28/VirtualBox-5.2.28-130011-OSX.dmg
```
Windows
```
https://download.virtualbox.org/virtualbox/5.2.28/VirtualBox-5.2.28-130011-Win.exe
```
#### 2）Vagrant
Mac
```
https://releases.hashicorp.com/vagrant/2.2.4/vagrant_2.2.4_x86_64.dmg
```
Windows
```
https://releases.hashicorp.com/vagrant/2.2.4/vagrant_2.2.4_x86_64.msi
```
#### 3）ubuntu18.04 vagrant box
```
https://app.vagrantup.com/ubuntu/boxes/bionic64/versions/20190419.0.0/providers/virtualbox.box
```

### 二、安装Vagrant环境
#### 1）安装VirtualBox及Vagrant
#### 2）导入ubuntu18.04 box
```
vagrant box add ubuntu18.04 virtualbox.box
```
#### 3）查看box
```
vagrant box list
```
#### 4）初始化box
在目标目录执行
```
vagrant init ubuntu18.04
```
#### 5）替换Vagrantfile
#### 6）启动vagrant
```
vagrant up
```

## 三、安装lnmp
#### 1、进入容器
```
cd /vagrant/lnmp
```
#### 2、创建lnmp
```
docker-compose build
```
#### 3、后台运行
```
docker-compose start -d
```
| 软件 | 账号 | 密码 |
| ------ | ------ | ------ |
| mysql | root | root |
| redis | root | root |
| vsftpd | root | root |

### 四、配置phpstorm
#### 1、配置xdebug
打开 settings -> Languages & Frameworks -> PHP -> Debug -> xdebug -> Debug port，配置端口号，和php.ini中的xdebug.remote_port 对应 比如:9000
#### 2、配置DGBp Proxy
配置 settings-> Languages & Frameworks -> PHP -> Debug -> DBGp Proxy 比如：
```
IDE key：PHPSTORM
Host：10.0.0.10
Port：9001
```
#### 3、配置server
添加server，主要配置项目目录所在的路径的映射关系。右边是项目在vagrant中的路径。
#### 4、配置运行环境
点击Run-> Edit Configurations
点左上角+号，选择PHP Web Page
server那一栏选择刚才配置的server
然后点击Run-> Start Listening for PHP Debug Connections 就可以开始设断点调试了

## 其他
### 一、常用命令
#### 1、vagrant命令
启动并提供vagrant环境
```
vagrant up
```
通过ssh链接容器（默认只支持秘钥链接方式，Vagrantfile文件已开启账号密码链接，并启用了root账号链接）
```
vagrant ssh
```
重新启动vagrant容器，并加载新的Vagrantfile
```
vagrant reload
```
停止vagrant容器
```
vagrant halt
```
停止并删除vagrant容器
```
vagrant destroy
```
打印OpenSSH配置信息
```
vagrant ssh-config
```
打印vagrant容器信息
```
vagrant status
```
更新vagrant插件
```
vagrant plugin update
```
#### 2、重建服务
```
docker-compose up --build
```
#### 3、清理lnmp
```
docker ps -a|grep -v 'CONTAINER ID'|awk {'print $1'}|xargs docker rm
docker images|grep none|awk {'print $3'}|xargs docker rmi
docker images|grep lnmp|awk {'print $3'}|xargs docker rmi
```
#### 4、删除相关文件
```
rm -R data/mysql/*
rm -R data/redis/*
find logs/ -name *.log|xargs rm -rf
```
#### 5、进入一个容器
```
docker exec -it lnmp_mysql_1 /bin/bash
```
#### 6、查看容器详情
```
docker inspect lnmp_mysql_1
```
#### 7、启动一个自删除的容器
```
docker run --rm -it nginx:1.14.0-alpine /bin/bash
```
#### 8、补充:
高版本的php-fpm,发现有个问题, 已经开始调试了,但是在无操作历时大概1分多钟的时间后,调试会自动终止,是进程管理器那边有个超时设置,时间一超, 就会终止掉php进程.
解决方案如下(超时配置成1小时):
1）apache module的情况下:
修改配置文件 httpd/conf.d/fcgid.conf
```
FcgidIOTimeout 3600
```
2）nginx php-fpm的情况下:
修改配置文件 php-fpm.conf
```
request_terminate_timeout = 3600
```
