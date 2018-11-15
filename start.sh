if [ ! -f /ssh/ssh_host_rsa_key ]
  then
    ssh-keygen -t rsa -b 4096 -f /etc/ssh/ssh_host_rsa_key -N ''
  else 
    cp /ssh/ssh_host_rsa_key /etc/ssh/ssh_host_rsa_key
    cp /ssh/ssh_host_rsa_key.pub /etc/ssh/ssh_host_rsa_key.pub
fi

echo "ForceCommand echo this account can only be used for tunneling" > /etc/ssh/sshd_config
echo "HostKey /ssh/ssh_host_rsa_key" >> /etc/ssh/sshd_config
echo "PermitOpen ${SSH_PERMITOPEN}" >> /etc/ssh/sshd_config
echo "AllowUsers ${SSH_USER}" >> /etc/ssh/sshd_config

chmod 400 /etc/ssh/*
chown root:root /etc/ssh/*

adduser -D -H ${SSH_USER}
echo "${SSH_USER}:${SSH_PASSWORD}" | chpasswd

/usr/sbin/sshd -D