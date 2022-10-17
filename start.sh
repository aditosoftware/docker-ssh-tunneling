#!/bin/sh
if [ ! -f /ssh/ssh_host_rsa_key ]
  then
    ssh-keygen -t rsa -b 4096 -f /ssh/ssh_host_rsa_key -N ''
fi
chmod 400 /ssh/*
chown root:root /ssh/*

echo "ForceCommand echo this account can only be used for tunneling" > /etc/ssh/sshd_config
echo "HostKey /ssh/ssh_host_rsa_key" >> /etc/ssh/sshd_config
echo "PermitOpen ${SSH_PERMITOPEN}" >> /etc/ssh/sshd_config
echo "AllowUsers ${SSH_USER}" >> /etc/ssh/sshd_config
if ! [ -z "$SSH_PORT" ]
  then
    echo "Port ${SSH_PORT}" >> /etc/ssh/sshd_config
fi

ln -s -f /ssh/ssh_host_rsa_key /etc/ssh/ssh_host_rsa_key
ln -s -f /ssh/ssh_host_rsa_key.pub /etc/ssh/ssh_host_rsa_key.pub

adduser -D -H ${SSH_USER}
echo "${SSH_USER}:${SSH_PASSWORD}" | chpasswd

/usr/sbin/sshd -D
