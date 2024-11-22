#!/bin/bash

# 检查是否以 root 用户运行
if [[ $EUID -ne 0 ]]; then
   echo "此脚本必须以 root 用户运行。"
   exit 1
fi

echo "正在安装 vsftpd..."
dnf install -y vsftpd

# 备份原始配置文件
if [ ! -f /etc/vsftpd/vsftpd.conf.orig ]; then
    cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.orig
fi

echo "正在配置 vsftpd..."
cat <<EOL > /etc/vsftpd/vsftpd.conf
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022
dirmessage_enable=YES
xferlog_enable=YES
connect_from_port_20=YES
pasv_enable=YES
pasv_min_port=30000
pasv_max_port=30100
xferlog_std_format=YES
ftpd_banner=欢迎使用 FTP 服务。
chroot_local_user=YES
allow_writeable_chroot=YES
listen=NO
listen_ipv6=YES
userlist_enable=YES
userlist_file=/etc/vsftpd/user_list
userlist_deny=NO
EOL

# 添加 FTP 用户
read -p "请输入要创建的 FTP 用户名：" ftpuser
if id "$ftpuser" &>/dev/null; then
    echo "用户 $ftpuser 已存在。"
else
    useradd -m $ftpuser
    passwd $ftpuser
fi

# 将用户添加到 vsftpd 用户列表
echo $ftpuser > /etc/vsftpd/user_list

echo "正在启动 vsftpd 服务..."
systemctl enable vsftpd
systemctl restart vsftpd

echo "正在配置防火墙..."
firewall-cmd --permanent --add-service=ftp
firewall-cmd --permanent --add-port=30000-30100/tcp
firewall-cmd --reload

echo "vsftpd 安装和配置已完成。"
