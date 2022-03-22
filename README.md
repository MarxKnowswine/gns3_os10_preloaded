
# gns3_os10_preloaded

This projects aims to automate the installation of a GNS3 2.2 server on a fresh install UBUNTU 20.4 LTS.
It will:
- Install GNS3 server. Minimal interaction is needed (will work on this)
- Create a dedicated user "gns3-user" with password "password"
- Install GNS3 client
- Automatically import GNS3 configuration files
- Automatically import OS10 10.5.3.2 and Sonic 3.5 images
- Install a DHCP server on virbr0 to assign an IP address to OOB interfaces
- Copy two pre-built and pre-wired projects with OS 10 switches and Sonic switches
- (Optional) Install ansible and Dell Ansible roles (https://github.com/val3r1o/os10-startup-ansible)
- Optional Import a configuration via a second script (https://github.com/val3r1o/os10-backup-restore)

# Prerequisites:
- If Ubuntu is a VM, remember to enable CPU/hardware virtualization
- Ubuntu needs a valid IP address and DNS (Internet connection is needed)
- GNS3 is quite demanding, usually each image takes 2GB RAM. Minimum: 4 vCPUs, 16 GB RAM, 500GB HD

# How to launch
<strong>1) Install the environment</strong></br>
sudo apt update && sudo apt upgrade</br>
sudo apt -y install git</br>
git clone https://github.com/MarxKnowswine/gns3_os10_preloaded.git</br>
cd gns3_os10_preloaded</br>
sudo chmod 755 install.sh</br>
./install.sh</br>

# How to use
Once the installation is over
<strong>2) Create your own project or import the pre-built one</strong></br>
Run gns3 (via gnome terminal or GUI)</br>
If you want to import the pre-build project, just go on File -> Open Project -> /home/gns3-user/GNS3/projects/OS10_GNS3.gns3a
Once powered on the two switches, they will need at least 10 minutes to install the OS from scratch and a first reboot. The switches will take, respectively, 10.10.10.11(TOR-1) and 10.10.10.12(TOR-2)</br>
3) Import switches configuration via a script</br>


# Notes:
- This project has been developed starting from Val3r1o repository https://github.com/val3r1o/gns3-automation-fabric. It uses two other projects from the same user.
- When prompted whether non-root users should be allowed to use wireshark and ubridge, select ‘Yes’ both times
- Please check the output of the script. Sometimes Ubuntu repos are not working and unable to install GNS3 (it happened several times to me). In case of issue, just run again the script
