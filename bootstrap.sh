useradd  -mG wheel chef
echo itversity | passwd chef --stdin
sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config

sed -i "s/%wheel\tALL=(ALL)\tALL/# %wheel\tALL=(ALL)\tALL/g" /etc/sudoers
sed -i "s/# %wheel\tALL=(ALL)\tNOPASSWD: ALL/%wheel\tALL=(ALL)\tNOPASSWD: ALL/g" /etc/sudoers
yum install -y wget

service sshd restart
