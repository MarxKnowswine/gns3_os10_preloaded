
# gns3_os10_preloaded
Currently incomplete project 


This projects aims to automate the installation of a GNS3 2.2 server on a fresh install UBUNTU 20.4 LTS.
It will:
- Install GNS3 server. Minimal interaction is needed (will work on this)
- Create a dedicated user "gns3-user" with password "password"
- Install GNS3 client
- Automatically import configuration file
- Automatically import OS10 10.5.3 images

# Prerequisites:
- If Ubuntu is a VM, remember to enable CPU/hardware virtualization
- GNS3 is quite demanding, usually each image takes 2GB RAM. Minimum: 4 vCPUs, 16 GB RAM, 500GB HD


Missing:
- upload OS10_GNS3 images on Dropbox or similar
