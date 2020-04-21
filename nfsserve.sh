#!/bin/sh

sudo dnf update -y

/bin/dnf install man-pages -y
/bin/dnf install nfs-utils -y
systemctl start nfs-server.service
systemctl enable nfs-server.service


/bin/mkdir /home/share1
/bin/mkdir /home/share2

echo "/home/share1 192.168.32.0/24(rw,sync,no_root_squash)" > /etc/exports
echo "/home/share2 192.168.32.0/24(rw,sync,no_root_squash)" >> /etc/exports

/sbin/exportfs -a

/bin/dnf install python3 -y
/bin/dnf install python3-pip -y
/bin/dnf install expect -y

sudo -u vagrant cat <<EOD >~vagrant/keygen.exp
#! /usr/bin/expect
set force_conservative 0
set timeout -1
spawn ssh-keygen
match_max 100000
expect -exact "Generating public/private rsa key pair.\r
Enter file in which to save the key (/home/vagrant/.ssh/id_rsa): "
send -- "\r"
expect -exact "\r
Enter passphrase (empty for no passphrase): "
send -- "vagrant\r"
expect -exact "\r
Enter same passphrase again: "
send -- "vagrant\r"
expect eof
EOD
#sleep 30
chown vagrant ~vagrant/keygen.exp
sudo -u vagrant chmod +x ~vagrant/keygen.exp
sudo -u vagrant ~vagrant/keygen.exp

/bin/dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
/bin/dnf -y install  --enablerepo epel-playground  ansible