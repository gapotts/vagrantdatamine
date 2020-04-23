#!/bin/sh

dnf -y install https://repo.saltstack.com/py3/redhat/salt-py3-repo-latest.el8.noarch.rpm
dnf -y install salt-master
systemctl start salt-master.service
systemctl enable salt-master.service