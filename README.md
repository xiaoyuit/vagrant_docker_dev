# Vagrant+Docker本地开发环境搭建

## 一、下载所需软件
### 1）VirtualBox
Mac
```
https://download.virtualbox.org/virtualbox/5.2.28/VirtualBox-5.2.28-130011-OSX.dmg
```
Windows
```
https://download.virtualbox.org/virtualbox/5.2.28/VirtualBox-5.2.28-130011-Win.exe
```
### 2）Vagrant
Mac
```
https://releases.hashicorp.com/vagrant/2.2.4/vagrant_2.2.4_x86_64.dmg
```
Windows
```
https://releases.hashicorp.com/vagrant/2.2.4/vagrant_2.2.4_x86_64.msi
```
### 3）ubuntu18.04 vagrant box
```
https://app.vagrantup.com/ubuntu/boxes/bionic64/versions/20190419.0.0/providers/virtualbox.box
```

## 二、安装Vagrant环境
##### 1）安装VirtualBox及Vagrant
##### 2）导入ubuntu18.04 box
```
vagrant box add ubuntu18.04 virtualbox.box
```
##### 3）查看box
```
vagrant box list
```
##### 4）初始化box
```
vagrant init ubuntu18.04
```
##### 5）替换指定Vagrantfile
##### 6）启动vagrant
```
vagrant up
vagrant destroy
vagrant ssh-config
```
##### 7）开启ssh密码登录（默认只能使用秘钥登录）
```
vim /etc/ssh/sshd_config
```
修改
```
PasswordAuthentication no
```
为
```
PasswordAuthentication yes
```
##### 8）开启ssh root账号登录
修改
```
#PermitRootLogin prohibit-password
```
为
```
PermitRootLogin yes
```
重启ssh
```
service ssh restart
```
##### 9）设置root账号密码
```
sudo su
passwd
```
##### 10）更新源（替换为阿里源）
```
sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g;s/security.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list
```

## 三、安装docker及docker-compose
##### 1）安装docker
```
curl -fsSL "https://get.docker.com/" | bash -s -- --mirror Aliyun
```
##### 2）修改docker配置
```
mkdir -p /etc/docker/
```
```
vim /etc/docker/daemon.json
```
```
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "registry-mirrors": ["https://fz5yth0r.mirror.aliyuncs.com"],
  "storage-driver": "overlay2",
  "storage-opts": [
    "overlay2.override_kernel_check=true"
  ],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m",
    "max-file": "3"
  }
}
```
##### 3）重启docker
```
service docker restart
```
##### 4）查看docker版本信息
```
docker version
```
##### 5）安装docker-compose
```
curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```

## 四、安装lnmp
##### 1、进入容器
```
cd /vagrant/lnmp
```
##### 2、创建lnmp
```
docker-compose build
```
##### 3、运行
```
docker-compose up
```
##### 4、后台运行
```
docker-compose up -d
```
##### 5、清理lnmp
```
docker ps -a|grep -v 'CONTAINER ID'|awk {'print $1'}|xargs docker rm
docker images|grep none|awk {'print $3'}|xargs docker rmi
docker images|grep lnmp|awk {'print $3'}|xargs docker rmi
```
##### 6、删除相关文件
```
rm -R data/mysql/*
rm -R data/redis/*
find logs/ -name *.log|xargs rm -rf
```
##### 7、进入一个容器
```
docker exec -it lnmp_mysql_1 /bin/bash
```
##### 8、查看容器详情
```
docker inspect lnmp_mysql_1
```
##### 9、启动一个自删除的容器
```
docker run --rm -it debian:9.5-slim /bin/bash
```
##### 10、补充:
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

## 五、配置phpstorm
##### 1、开启容器远程API
```
vim /lib/systemd/system/docker.service
```
修改
```
ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
```
添加-H tcp://10.0.0.10:2375 
```
ExecStart=/usr/bin/dockerd -H tcp://10.0.0.10:2375  -H fd:// --containerd=/run/containerd/containerd.sock
```
重启docker
```
systemctl daemon-reload
service docker restart
```
##### 2、配置xdebug
打开 settings -> Languages & Frameworks -> PHP -> Debug -> xdebug -> Debug port，配置端口号，和php.ini中的xdebug.remote_port 对应 比如:9000
##### 3、配置DGBp Proxy
配置 settings-> Languages & Frameworks -> PHP -> Debug -> DBGp Proxy 比如：
```
IDE key：PHPSTORM
Host：10.0.0.10
Port：9001
```
##### 4、配置server
添加server，主要配置项目目录所在的路径的映射关系。右边是项目在vagrant中的路径。
##### 5、配置运行环境
点击Run-> Edit Configurations
点左上角+号，选择PHP Web Page
server那一栏选择刚才配置的server
然后点击Run-> Start Listening for PHP Debug Connections 就可以开始设断点调试了
