#!/bin/bash
# Riverbed Community Toolkit
# SteelConnect-EX Analytics VM Initialization script

log_path="/etc/bootLog.txt"
if [ -f "$log_path" ]
then
    echo "Cloud Init script already ran earlier during first time boot.." >> $log_path
else
    touch $log_path
VanIP="${van_mgmt_ip}"
SSHKey="${sshkey}"
KeyDir="/home/versa/.ssh"
KeyFile="/home/versa/.ssh/authorized_keys"
DirManagementIP="${dir_mgmt_ip}"
hostname_dir="${hostname_dir}"
PrefixLength=`echo "${ctrl_net}"| cut -d'/' -f2`
echo "Starting cloud init script..." > $log_path

echo "Modifying /etc/network/interface file.." >> $log_path
cp /etc/network/interfaces /etc/network/interfaces.bak
cat > /etc/network/interfaces << EOF
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto eth0
iface eth0 inet dhcp

# The secondary network interface
auto eth1
iface eth1 inet static
	address ${van_ctrl_ip}/$PrefixLength
EOF
echo -e "Modified /etc/network/interface file. Refer below new interface file content:\n`cat /etc/network/interfaces`" >> $log_path

echo "Adding static routes to /etc/rc.local" >> $log_path
cp /etc/rc.local /etc/rc.local.bak
cat > /etc/rc.local << EOF
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.
while [ "$(ip link show eth1 up)" == "" ]; do sleep 1; done
/sbin/ip route add ${overlay_net} via ${controller_ip}
exit 0
EOF
echo -e "Modified /etc/rc.local file. Routes added:\n`cat /etc/rc.local`" >> $log_path

echo "Modifying /etc/hosts file.." >> $log_path
cp /etc/hosts /etc/hosts.bak
cat > /etc/hosts << EOF
127.0.0.1           localhost
$VanIP         		 ${hostname_van}
$DirManagementIP         ${hostname_dir}

# The following lines are desirable for IPv6 capable hosts cloudeinit
::1localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
EOF
echo -e "Modified /etc/hosts file. Refer below new hosts file content:\n`cat /etc/hosts`" >> $log_path

echo -e "Modifying /etc/hostname file.." >> $log_path
hostname ${hostname_van}
cp /etc/hostname /etc/hostname.bak
cat > /etc/hostname << EOF
${hostname_van}
EOF
echo -e "Hostname modified to : `hostname`" >> $log_path

echo -e "Injecting ssh key into versa user.\n" >> $log_path
if [ ! -d "$KeyDir" ]; then
    echo -e "Creating the .ssh directory and injecting the SSH Key.\n" >> $log_path
    sudo mkdir $KeyDir
sudo echo $SSHKey >> $KeyFile
sudo chown versa:versa $KeyDir
sudo chown versa:versa $KeyFile
sudo chmod 600 $KeyFile
elif ! grep -Fq "$SSHKey" $KeyFile; then
    echo -e "Key not found. Injecting the SSH Key.\n" >> $log_path
    sudo echo $SSHKey >> $KeyFile
    sudo chown versa:versa $KeyDir
    sudo chown versa:versa $KeyFile
    sudo chmod 600 $KeyFile
else
    echo -e "SSH Key already present in file: $KeyFile.." >> $log_path
fi

echo -e "Adding script to copy certificates from director after instance boot up." >> $log_path
cat > /tmp/get_cert.sh << EOF
#!/bin/bash
sudo sshpass -p versa123 scp  -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null admin@$DirManagementIP:/var/versa/vnms/data/certs/versa_director_client.cer /opt/versa/var/van-app/certificates >> $log_path
echo -e "Installing the certificates in Analytics.\n" >> $log_path
sudo /opt/versa/scripts/van-scripts/van-vd-cert-install.sh /opt/versa/var/van-app/certificates/versa_director_client.cer $hostname_dir >> $log_path
sudo python /opt/versa/scripts/van-scripts/vansetup.py --force –skip-interactive >> $log_path
EOF
sudo chmod 0755 /tmp/get_cert.sh
crontab -l > /tmp/orig_crontab
echo "`date +%M --date='5 minutes'` `date +%H` `date +%d` `date +%m` * sudo bash /tmp/get_cert.sh; sudo crontab -l | grep -v get_cert.sh | crontab " >>  /tmp/orig_crontab
sudo crontab /tmp/orig_crontab
fi
