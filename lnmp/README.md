# docker-lnmp

#### 项目介绍
docker 构建lnmp环境

#### 软件架构

| 软件 | 版本 | 备注 |
| ------ | ------ | ------ |
| docker-compose | 1.22.0 |  |
| nginx | 1.14.0-alpine | |
| mysql | 5.7.25 | |
| php | 7.2.5-fpm-alpine3.7 | |
| redis | 4.0.9-alpine | |
| vsftpd | 3.0.3 | |

#### 安装教程

1. 设置目录权限
```
chown -R 1000:1000 wwwroot logs data conf
```
2. 执行初始化
```
docker-compose up
```
如有问题，修改文件后，重建服务
```
docker-compose up --build
```
后台启动
```
docker-compose start -d
```
3. 安装完成
* mysql账号/密码:root/root
* redis无密码
* vsftpd账号/密码:ftproot/ftproot

4. 删除容器及镜像
```
docker images|grep none|awk {'print $3'}|xargs docker rmi
docker images|grep lnmp|awk {'print $3'}|xargs docker rmi
docker ps -a|grep -v 'CONTAINER ID'|awk {'print $1'}|xargs docker rm
```

5. 清理日志及数据文件
```
rm -R data/mysql/*
rm -R data/redis/*
find logs/ -name *.log|xargs rm -rf
```

#### 使用说明

1. 创建并启动容器
```
docker-compose up
```
2. 停止并删除容器、网络、图像和卷
```
docker-compose down
```
3. 建立或重建服务
```
docker-compose build
```
或者
```
docker-compose up --build
```
4. 在正在运行的容器中执行命令
```
docker-compose exec
```
5. 进入正在运行的容器
```
docker-compose exec -it 容器NAMES /bin/bash
```
6. 列出镜像
```
docker-compose images
```
7. 列出容器
```
docker-compose ps
```
8. 列出全部容器，包含暂停的
```
docker-compose ps -a
```
9. 重启服务
```
docker-compose restart
```
10. 删除容器
```
docker-compose rm 容器ID
```
11. 删除镜像
```
docker-compose rmi 镜像ID
```
12. 启动服务
```
docker-compose start
```
13. 重启服务
```
docker-compose restart
```
14. 停止服务
```
docker-compose stop
```
15. 显示运行过程
```
docker-compose top
```
16. 暂停服务
```
docker-compose unpause
```
17. 显示Docker-Compose版本信息
```
docker-compose version
```
18. 执行一个自动销毁的容器
```
docker run --rm -it nginx:1.14.0-alpine /bin/bash
```

#### 参与贡献

1. Fork 本项目
2. 新建 Feat_xxx 分支
3. 提交代码
4. 新建 Pull Request

