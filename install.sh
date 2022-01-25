
# Create user gns3-user with password "password"
sudo useradd -s /bin/bash -d /home/gns3-user -m gns3-user
echo -e "password\npassword" | sudo passwd gns3-user
#sudo usermod -a -G adm,cdrom,sudo,dip,plugdev,lpadmin,lxd,sambashare,ubridge,libvirt gns3-user

# 
sudo apt -y upgrade
sudo apt -y install net-tools
sudo apt -y install openssh-server
# sudo service ssh status
# ref: https://docs.gns3.com/docs/getting-started/installation/linux 
sudo add-apt-repository ppa:gns3/ppa -y
sudo apt -y install gns3-gui gns3-server
sudo apt -y install konsole

#virbr0 should have been created by GNS3 installation. This change IP address making a new config file
sudo mv default.xml /etc/libvirt/qemu/networks/

sudo mkdir -p /home/gns3-user/GNS3/images/QEMU
sudo mkdir -p /home/gns3-user/GNS3/appliances
sudo mkdir -p /home/gns3-user/GNS3/projects
sudo mkdir -p /home/gns3-user/.config/GNS3/2.2/

#download OS10 images
sudo wget https://www.dropbox.com/s/o789mvxwdb10hqk/OS10_GNS3.tgz -P /home/gns3-user/GNS3
sudo tar xzvf /home/gns3-user/GNS3/OS10_GNS3.tgz -C /home/gns3-user/GNS3
sudo chmod -R 777 /home/gns3-user/GNS3/OS10_GNS3/

# download an example project (new no OOB issue)
# sudo wget https://www.dropbox.com/s/k461f8dov3wpf9s/1Single-Rack-OS10.gns3project -P /home/gns3-user/GNS3/

# Copy config files 
sudo cp /home/gns3-user/GNS3/OS10_GNS3/gns3_configs/* /home/gns3-user/.config/GNS3/2.2/

# Copy OS10 Virt images
sudo cp /home/gns3-user/GNS3/OS10_GNS3/OS10-platform-S5212F-10.5.3.0.44.vmdk /home/gns3-user/GNS3/images/
sudo cp /home/gns3-user/GNS3/OS10_GNS3/OS10-platform-S4128F-10.5.3.0.44.vmdk /home/gns3-user/GNS3/images/
sudo cp /home/gns3-user/GNS3/OS10_GNS3/OS10-Installer-10.5.3.0.44.vmdk /home/gns3-user/GNS3/images/
sudo cp /home/gns3-user/GNS3/OS10_GNS3/OS10-Disk-1.0.0.vmdk /home/gns3-user/GNS3/images/
sudo cp /home/gns3-user/GNS3/OS10_GNS3/config.img /home/gns3-user/GNS3/images/
sudo cp /home/gns3-user/GNS3/OS10_GNS3/OS10-platform-S5212F-10.5.3.0.44.vmdk /home/gns3-user/GNS3/appliances/
sudo cp /home/gns3-user/GNS3/OS10_GNS3/OS10-platform-S4128F-10.5.3.0.44.vmdk /home/gns3-user/GNS3/appliances/

# Copy first project
sudo cp -r /home/gns3-user/GNS3/OS10_GNS3/projects/* /home/gns3-user/GNS3/projects/

# All the files must be owned by gns3-user with 774 permissions
sudo chown -R gns3-user:gns3-user /home/gns3-user/GNS3/ /home/gns3-user/.config/GNS3/
sudo chown -R gns3-user:gns3-user /home/gns3-user/GNS3/projects
sudo chmod -R 777 /home/gns3-user/GNS3/
sudo chmod -R 777 /home/gns3-user/.config/GNS3/
sudo chmod -R 777 /home/gns3-user/.config

# Assign all the groups to user gns3-user
sudo usermod -a -G adm,cdrom,sudo,dip,plugdev,lpadmin,lxd,sambashare,ubridge,libvirt,wireshark gns3-user

# Install DHCP0 and bind it to virbr0
sudo apt -y install isc-dhcp-server
sudo cp -p /home/gns3-user/GNS3/OS10_GNS3/dhcpd.conf /etc/dhcp/
sudo cp -p /home/gns3-user/GNS3/OS10_GNS3/isc-dhcp-server /etc/default/
sudo chown root:root /etc/dhcp/dhcpd.conf
sudo chown root:root /etc/default/isc-dhcp-server
sudo chmod 644 /etc/dhcp/dhcpd.conf
sudo chmod 644 /etc/default/isc-dhcp-server
sudo systemctl restart isc-dhcp-server.service


# setup permissions to ubridge
# sudo chmod 777 /usr/bin/ubridge

echo
echo ------------------------------------------------------------------------------------------------------
echo ------------------------------------------------------------------------------------------------------
echo -------------------------------------- Thats all folks "!!" ------------------------------------------
echo ------------------------------------------------------------------------------------------------------
echo ------------------ This is an automatic script -------------------------------------------------------
echo ------------------------------------------------------------------------------------------------------
echo ------------------------------------------------- Dell NETWORKING ------------------------------------
echo -----------------valerio.martini@gmail.com------------------------------------------------------------
echo -----------------marcello.savino@gmail.com------------------------------------------------------------
echo The system will now restart in 30 seconds
sleep 5
echo The system will now restart in 25 seconds
sleep 5
echo The system will now restart in 20 seconds
sleep 5
echo The system will now restart in 15 seconds
sleep 5
echo The system will now restart in 10 seconds
sleep 1
echo The system will now restart in 9 seconds
sleep 1
echo The system will now restart in 8 seconds
sleep 1
echo The system will now restart in 7 seconds
sleep 1
echo The system will now restart in 6 seconds
sleep 1
echo The system will now restart in 5 seconds
sleep 1
echo The system will now restart in 4 seconds
sleep 1
echo The system will now restart in 3 seconds
sleep 1
echo The system will now restart in 2 seconds
sleep 1
echo The system will now restart in 1 second
sleep 1
echo The system will now reboot. Please log in with user "gns3-user" and password "password" to start using GNS3
sudo reboot
