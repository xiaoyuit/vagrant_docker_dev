#!/usr/bin/env bash
# 替换阿里云源
sudo sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g;s/security.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list
# 开启密码登录并开启root账号登录
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g;s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
sudo service ssh restart > /dev/null 2>&1
# 设置root账号密码
echo root:vagrant | sudo chpasswd root
# 安装docker
sudo curl -fsSL "https://get.docker.com/" | bash -s -- --mirror Aliyun > /dev/null 2>&1
sudo mkdir -p /etc/docker/
sudo cat > /etc/docker/daemon.json <<EOF
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
EOF
# 开启docker远程api
sudo sed -i 's/ExecStart=\/usr\/bin\/dockerd -H fd:\/\//ExecStart=\/usr\/bin\/dockerd -H tcp:\/\/10.0.0.10:2375 -H fd:\/\//g' /lib/systemd/system/docker.service
sudo systemctl daemon-reload
sudo service docker restart
# 安装docker-compose
# https://github.com/docker/compose
# curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo cp /vagrant/lib/docker-compose-Linux-x86_64 /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose
