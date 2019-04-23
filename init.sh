#!/usr/bin/env bash
sudo sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g;s/security.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list

sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g;s/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

sudo service ssh restart > /dev/null 2>&1

echo root:vagrant | sudo chpasswd root
