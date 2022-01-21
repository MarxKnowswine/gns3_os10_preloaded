
# Create user gns3-user with password "password"
sudo useradd -s /bin/bash -d /home/gns3-user -m gns3-user
echo -e "password\npassword" | sudo passwd gns3-user
usermod -a -G adm,cdrom,sudo,dip,plugdev,lpadmin,lxd,sambashare,ubridge,libvirt gns3-user

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
sudo mkdir -p /home/gns3-user/.config/GNS3/2.2/

#download OS10 images
sudo wget https://www.dropbox.com/s/if1kndaqobys8a5/OS10_GNS3.tgz -P /home/gns3-user/GNS3

# download an example project (new no OOB issue)
# sudo wget https://www.dropbox.com/s/k461f8dov3wpf9s/1Single-Rack-OS10.gns3project -P /home/gns3-user/GNS3/

# Copy config files 
sudo cp /home/gns3-user/GNS3/OS10_GNS3/gns_configs/* /home/gns3-user/.config/GNS3/2.2/

# Copy OS10 Virt images
sudo cp /home/gns3-user/GNS3/OS10_GNS3/OS10-platform-S5212F-10.5.3.0.44.vmdk /home/gns3-user/GNS3/images/
sudo cp /home/gns3-user/GNS3/OS10_GNS3/OS10-platform-S4128F-10.5.3.0.44.vmdk /home/gns3-user/GNS3/images/
sudo cp /home/gns3-user/GNS3/OS10_GNS3/OS10-Installer-10.5.3.0.44.vmdk /home/gns3-user/GNS3/images/
sudo cp /home/gns3-user/GNS3/OS10_GNS3/OS10-Disk-1.0.0.vmdk /home/gns3-user/GNS3/images/
sudo cp /home/gns3-user/GNS3/OS10_GNS3/config.img /home/gns3-user/GNS3/images/
sudo cp /home/gns3-user/GNS3/OS10_GNS3/OS10-platform-S5212F-10.5.3.0.44.vmdk /home/gns3-user/GNS3/appliances/
sudo cp /home/gns3-user/GNS3/OS10_GNS3/OS10-platform-S4128F-10.5.3.0.44.vmdk /home/gns3-user/GNS3/appliances/

# All the files must be owned by gns3-user with 664 permissions
sudo chown -R gns3-user:gns3-user /home/gns3-user/GNS3/ /home/gns3-user/.config/GNS3/
sudo chmod -R 664 /home/gns3-user/GNS3/
sudo chmod -R 664 /home/gns3-user/.config/GNS3/

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
