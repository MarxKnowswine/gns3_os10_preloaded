
# gns3_os10_preloaded

This projects aims to automate the installation of a GNS3 2.2 server on a fresh install UBUNTU 20.4 LTS.
It will:
- Install GNS3 server. Minimal interaction is needed (will work on this)
- Create a dedicated user "gns3-user" with password "password"
- Install GNS3 client
- Automatically import configuration file
- Automatically import OS10 10.5.3 images
- Install a DHCP server on virbr0 to assign an IP address to OOB interfaces
- (Optional) Copy a pre-built and pre-wired project with two OS 10 switches

# Current state
- GNS is correctly installed, configuration and images are working as expected.

# Prerequisites:
- If Ubuntu is a VM, remember to enable CPU/hardware virtualization
- Ubuntu needs a valid IP address and DNS (Internet connection is needed)
- GNS3 is quite demanding, usually each image takes 2GB RAM. Minimum: 4 vCPUs, 16 GB RAM, 500GB HD

# How to launch
sudo apt update && sudo apt upgrade</br>
sudo apt -y install git</br>
git clone https://github.com/MarxKnowswine/gns3_os10_preloaded.git</br>
cd gns3_os10_preloaded</br>
sudo chmod 755 install.sh</br>
./install.sh

# Notes:
- When prompted whether non-root users should be allowed to use wireshark and ubridge, select ‘Yes’ both times
- The system will restart in order to make new virbr0 config loaded
