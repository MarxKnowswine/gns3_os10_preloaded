
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


echo ------------------------------------------------------------------------------------------------------
echo Downloading OS10/SONiC images, project and configuration
echo ------------------------------------------------------------------------------------------------------
sudo wget https://www.dropbox.com/s/fltqikrv20w7jb1/gns3_images_configs.tar.gz -P /home/gns3-user

echo ------------------------------------------------------------------------------------------------------
echo Copying OS10/SONiC images and GNS3 config files
echo ------------------------------------------------------------------------------------------------------
sudo tar xzvf /home/gns3-user/gns3_images_configs.tar.gz -C /home/gns3-user

# download an example project (new no OOB issue)
# sudo wget https://www.dropbox.com/s/k461f8dov3wpf9s/1Single-Rack-OS10.gns3project -P /home/gns3-user/GNS3/

echo ------------------------------------------------------------------------------------------------------
echo Setting up correct permissions
echo ------------------------------------------------------------------------------------------------------

# All the files must be owned by gns3-user with 774 permissions
sudo chown -R gns3-user:gns3-user /home/gns3-user/GNS3/ /home/gns3-user/.config/GNS3/
sudo chown -R gns3-user:gns3-user /home/gns3-user/GNS3/projects
sudo chmod -R 777 /home/gns3-user/GNS3/
sudo chmod -R 777 /home/gns3-user/.config/GNS3/
sudo chmod -R 777 /home/gns3-user/.config

# Assign all the groups to user gns3-user
sudo usermod -a -G adm,cdrom,sudo,dip,plugdev,lpadmin,lxd,sambashare,ubridge,libvirt,wireshark gns3-user

# Installing Ansible repo through https://github.com/val3r1o/os10-startup-ansible
echo
echo
echo ------------------------------------------------------------------------------------------------------
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
#git clone https://github.com/val3r1o/os10-backup-restore
#rm os10-backup-restore/templates/*
#cp os10/* os10-backup-restore/templates/
#rm os10-backup-restore/inventory
#cp os10/inventory os10-backup-restore/
sudo cp -r os10/ /home/gns3-user/
sudo cp -r sonic/ /home/gns3-user/
sudo chown -R gns3-user:gns3-user /home/gns3-user/os10
sudo chown -R gns3-user:gns3-user /home/gns3-user/sonic
sudo chmod -R 774 /home/gns3-user/os10
sudo chmod -R 774 /home/gns3-user/sonic


echo
echo ------------------------------------------------------------------------------------------------------
echo -------------------------------------- Thats all folks "!!" ------------------------------------------
echo ------------------------------------------------------------------------------------------------------
echo "1) Log in with the new user gns3-user (password is: password)"
echo "2) Launch GNS3 and import OS10 or Sonic Project (File -> Open Project -> /home/gns3-user/GNS3/projects)"
echo "If you want to run OS10 lab:"
echo "3) Once you start the devices, wait at least 10 minutes for them to install OS10 (just the first time)"
echo "4) Go in /home/gns3-user/os10-backup-restore: cd /home/gns3-user/os10-backup-restore"
echo "If you want to run SONiC lab"
echo "3) Go in /home/gns3-user/sonic: cd /home/gns3-user/sonic"
echo "4) Launch the ansible script to push the config ./ansible_deploy.sh"
echo ------------------------------------------------------------------------------------------------------
echo ------------------------------------------------- Dell NETWORKING ------------------------------------
echo -----------------valerio.martini@gmail.com------------------------------------------------------------
echo -----------------marcello.savino@gmail.com------------------------------------------------------------

