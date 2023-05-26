#!/bin/bash

# Update system and install required packages
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y openssh-server libopenscap8 systemd-journal-remote libpam-pwquality aide
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install iptables-persistent

sudo sed -i 's/ENCRYPT_METHOD SHA512/ENCRYPT_METHOD yescrypt/' /etc/login.defs	

sudo sed -i 's/Ubuntu 22.04.1 LTS \n \l/Authorized uses only. All activity may be monitored and reported./' /etc/issue
sudo sed -i 's/Ubuntu 22.04.1 LTS/Authorized uses only. All activity may be monitored and reported./' /etc/issue.net

sudo sed -i 's/#Compress=yes/Compress=yes/' /etc/systemd/journald.conf
sudo sed -i 's/#Storage=auto/Storage=persistent/' /etc/systemd/journald.conf

sudo apt-get remove -y telnet
sudo apt-get remove -y rsync

sudo systemctl mask --now apport.service

sudo chmod 0700 /etc/cron.d
sudo chmod 0700 /etc/cron.daily
sudo chmod 0700 /etc/cron.hourly
sudo chmod 0700 /etc/cron.monthly
sudo chmod 0700 /etc/cron.weekly
sudo chmod 0600 /etc/crontab

sudo chmod 0600 /etc/ssh/sshd_config

sudo sed -i 's/# dcredit = 0/dcredit = -1/' /etc/systemd/journald.conf
sudo sed -i 's/# lcredit = 0/lcredit = -1/' /etc/systemd/journald.conf
sudo sed -i 's/# ucredit = 0/ucredit = -1/' /etc/systemd/journald.conf
sudo sed -i 's/# ocredit = 0/ocredit = -1/' /etc/systemd/journald.conf
sudo sed -i 's/# minclass = 0/minclass = 4/' /etc/systemd/journald.conf
sudo sed -i 's/# minlen = 8/minlen = 14/' /etc/systemd/journald.conf

sudo chmod 600 /boot/grub/grub.cfg

sudo touch /etc/modprobe.d/usb-storage.conf
config_file1="/etc/modprobe.d/usb-storage.conf"
line1="install usb-storage /bin/true"
sudo echo "$line1" >> "$config_file1"

sudo touch /etc/modprobe.d/cramfs.conf
config_file2="/etc/modprobe.d/cramfs.conf"
line2="install cramfs /bin/true"
sudo echo "$line2" >> "$config_file2"

sudo mkdir /dev/shm
config_file3="/etc/fstab"
line3="tmpfs /dev/shm tmpfs defaults,nodev,noexec,nosuid 0 0"
sudo echo "$line3" >> "$config_file3"
sudo mount -o remount /dev/shm

sudo sed -i 's/UMASK		022/UMASK		027/' /etc/login.defs

sudo chmod 0640 /var/log/alternatives.log
sudo chmod 0640 /var/log/lastlog
sudo chmod 0640 /var/log/ubuntu-advantage.log
sudo chmod 0640 /var/log/vmware-network.log
sudo chmod 0640 /var/log/dpkg.log
sudo chmod 0640 /var/log/ubuntu-advantage-timer.log
sudo chmod 0640 /var/log/vmware-network.2.log
sudo chmod 0640 /var/log/faillog
sudo chmod 0640 /var/log/wtmp
sudo chmod 0640 /var/log/bootstrap.log
sudo chmod 0640 /var/log/btmp
sudo chmod 0640 /var/log/vmware-network.1.log

config_file4="/etc/sysctl.d/10-network-security.conf"
line4="net.ipv4.conf.all.log_martians = 1"
line5="kernel.randomize_va_space = 2"
sudo sysctl -w net.ipv4.conf.all.log_martians=1
sudo echo "$line4" >> "$config_file4"
sudo sysctl -w kernel.randomize_va_space=2
sudo echo "$line5" >> "$config_file4"

echo "------------------------------"
echo "Security implementation completed!"