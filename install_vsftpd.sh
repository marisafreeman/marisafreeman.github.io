#!/bin/bash

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root."
   exit 1
fi

echo "Installing vsftpd..."
dnf install -y vsftpd

# Backup the original configuration file
if [ ! -f /etc/vsftpd/vsftpd.conf.orig ]; then
    cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.orig
fi

echo "Configuring vsftpd..."
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
ftpd_banner=Welcome to the FTP service.
chroot_local_user=YES
allow_writeable_chroot=YES
listen=NO
listen_ipv6=YES
userlist_enable=YES
userlist_file=/etc/vsftpd/user_list
userlist_deny=NO
EOL

# Add FTP user
read -p "Please enter the FTP username to create: " ftpuser
if id "$ftpuser" &>/dev/null; then
    echo "User $ftpuser already exists."
else
    useradd -m $ftpuser
    passwd $ftpuser
fi

# Add the user to vsftpd user list
echo $ftpuser > /etc/vsftpd/user_list

echo "Starting vsftpd service..."
systemctl enable vsftpd
systemctl restart vsftpd

echo "Configuring firewall..."
firewall-cmd --permanent --add-service=ftp
firewall-cmd --permanent --add-port=30000-30100/tcp
firewall-cmd --reload

echo "vsftpd installation and configuration is complete."
