
# Create user gns3-user with password "password"
sudo useradd -s /bin/bash -d /home/gns3-user -m gns3-user
echo -e "password\npassword" | sudo passwd gns3-user
echo ------------------------------------------------------------------------------------------------------
echo Installing GNS3 server and GUI
echo ------------------------------------------------------------------------------------------------------
sudo apt update
sudo apt -y upgrade
sudo apt -y install net-tools openssh-server
# sudo service ssh status
# ref: https://docs.gns3.com/docs/getting-started/installation/linux 
sudo add-apt-repository ppa:gns3/ppa -y
sudo apt -y install gns3-gui gns3-server konsole

#virbr0 should have been created by GNS3 installation. This change IP address making a new config file
echo ------------------------------------------------------------------------------------------------------
echo Modifying virbr0 IP address and definying DHCP server 
echo ------------------------------------------------------------------------------------------------------
sudo virsh net-destroy default
sudo virsh net-undefine default
sudo mv default.xml /etc/libvirt/qemu/networks/
sudo virsh net-define /etc/libvirt/qemu/networks/default.xml
sudo virsh net-start default
sudo virsh net-autostart default


sudo mkdir -p /home/gns3-user/GNS3/images/QEMU
sudo mkdir -p /home/gns3-user/GNS3/appliances
sudo mkdir -p /home/gns3-user/GNS3/projects
sudo mkdir -p /home/gns3-user/.config/GNS3/2.2/

#download OS10 images
echo ------------------------------------------------------------------------------------------------------
echo Downloading OS10 images, project and configuration
echo ------------------------------------------------------------------------------------------------------
sudo wget https://www.dropbox.com/s/o789mvxwdb10hqk/OS10_GNS3.tgz -P /home/gns3-user/GNS3
sudo tar xzvf /home/gns3-user/GNS3/OS10_GNS3.tgz -C /home/gns3-user/GNS3
sudo chmod -R 777 /home/gns3-user/GNS3/OS10_GNS3/

# download an example project (new no OOB issue)
# sudo wget https://www.dropbox.com/s/k461f8dov3wpf9s/1Single-Rack-OS10.gns3project -P /home/gns3-user/GNS3/

# Copy config files 
echo ------------------------------------------------------------------------------------------------------
echo Copying GNS3 config files
echo ------------------------------------------------------------------------------------------------------
sudo cp /home/gns3-user/GNS3/OS10_GNS3/gns3_configs/* /home/gns3-user/.config/GNS3/2.2/

# Copy OS10 Virt images
echo ------------------------------------------------------------------------------------------------------
echo Copying OS10 images
echo ------------------------------------------------------------------------------------------------------
sudo cp /home/gns3-user/GNS3/OS10_GNS3/OS10-platform-S5212F-10.5.3.0.44.vmdk /home/gns3-user/GNS3/images/
sudo cp /home/gns3-user/GNS3/OS10_GNS3/OS10-platform-S4128F-10.5.3.0.44.vmdk /home/gns3-user/GNS3/images/
sudo cp /home/gns3-user/GNS3/OS10_GNS3/OS10-Installer-10.5.3.0.44.vmdk /home/gns3-user/GNS3/images/
sudo cp /home/gns3-user/GNS3/OS10_GNS3/OS10-Disk-1.0.0.vmdk /home/gns3-user/GNS3/images/
sudo cp /home/gns3-user/GNS3/OS10_GNS3/config.img /home/gns3-user/GNS3/images/
sudo cp /home/gns3-user/GNS3/OS10_GNS3/OS10-platform-S5212F-10.5.3.0.44.vmdk /home/gns3-user/GNS3/appliances/
sudo cp /home/gns3-user/GNS3/OS10_GNS3/OS10-platform-S4128F-10.5.3.0.44.vmdk /home/gns3-user/GNS3/appliances/

# Copy first project
echo ------------------------------------------------------------------------------------------------------
echo Copying built-in project
echo ------------------------------------------------------------------------------------------------------
sudo cp -r /home/gns3-user/GNS3/OS10_GNS3/projects/* /home/gns3-user/GNS3/projects/

# All the files must be owned by gns3-user with 774 permissions
sudo chown -R gns3-user:gns3-user /home/gns3-user/GNS3/ /home/gns3-user/.config/GNS3/
sudo chown -R gns3-user:gns3-user /home/gns3-user/GNS3/projects
sudo chmod -R 777 /home/gns3-user/GNS3/
sudo chmod -R 777 /home/gns3-user/.config/GNS3/
sudo chmod -R 777 /home/gns3-user/.config

# Assign all the groups to user gns3-user
sudo usermod -a -G adm,cdrom,sudo,dip,plugdev,lpadmin,lxd,sambashare,ubridge,libvirt,wireshark gns3-user

# Installing Ansible repo through https://github.com/val3r1o/os10-startup-ansible

var="x"
while [ "$var" != "y" ] && [ "$var" != "n" ]
do
        echo Do you wish to install ansible and all dependencies? Type y or n
        read var

        if [ "$var" == "y" ]
                then
                        git clone https://github.com/val3r1o/os10-startup-ansible
                        cd os10-startup-ansible
                        sed -n -e :a -e '1,9!{P;N;D;};N;ba' initialize.sh > initialize2.sh
                        chmod +x initialize2.sh
                        ./initialize2.sh
                        cd ..
        fi
        if [ "$var" == "n" ]
                then echo "Ok I won't install ansible"
        fi
        if [ "$var" != "n" ] && [ "$var" != "y" ]
                then echo "Ops, you probably made a typo"
        fi
done

# Cloning https://github.com/val3r1o/os10-backup-restore project to push configuration to the two nodes
#cd ..
#git clone https://github.com/val3r1o/os10-backup-restore
#rm os10-backup-restore/templates/*
#cp leaf-1.j2 os10-backup-restore/templates/
#cp leaf-2.j2 os10-backup-restore/templates/
#sudo cp -r os10-backup-restore /home/gns3-user/
#sudo chown -R gns3-user:gns3-user /home/gns3-user/os10-backup-restore
#sudo chmod -R 774 /home/gns3-user/os10-backup-restore


echo
echo ------------------------------------------------------------------------------------------------------
echo -------------------------------------- Thats all folks "!!" ------------------------------------------
echo ------------------------------------------------------------------------------------------------------
echo "1) Log in with the new user gns3-user (password is: password)"
echo "2) Launch GNS3 and import OS10-rack.gns3 project (File -> Open Project -> /home/gns3-user/GNS3/projects)"
echo "3) Wait at least 10 minutes for the two devices to install OS10 (just the first time)"
echo "4) Go in /home/gns3-user/os10-backup-restore: cd /home/gns3-user/os10-backup-restore"
echo "5) Launch the ansible playbook to push config into the two devices: ansible-playbook pushconfig.yml"
echo ------------------------------------------------------------------------------------------------------
echo ------------------------------------------------- Dell NETWORKING ------------------------------------
echo -----------------valerio.martini@gmail.com------------------------------------------------------------
echo -----------------marcello.savino@gmail.com------------------------------------------------------------

