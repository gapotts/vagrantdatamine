#!/bin/sh
if [ -z ${SSH_AUTH_SOCK} ]; then
  eval `ssh-agent`
else
  echo ${SSH_AUTH_SOCK}
fi
export SSH_AUTH_SOCK
echo 'export SSH_AUTH_SOCK='"$SSH_AUTH_SOCK" >> .bashrc
/vagrant/ssh-add.exp
