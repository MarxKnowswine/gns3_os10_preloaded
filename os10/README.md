# Ansible Backup and Restore OS10 Project
This repository has 2 main functions:
Backup file from OS10 nodes to save locally and sync on GitHub</br>
Restore file from GitHub and push to OS10 nodes

Backup.sh is a script to launch BOTH local back-up and sync on your github repository (account needed)
You can decide to use only the Ansible playbook and skip the script if github sync is not of inyterest.

The Ansible Palybook (copyconfig.yml) is made to create automatic backup of all switches on local folder /config  
It save the file in .txt with date/time tag but also in jinja format under /templates

The Ansible Playbook (pushconfig.yml) is made to push the jinja configuration to all OS10 switches 
This repository is coming with 2 jinja templates as example and can be "pushed" to OS10 nodes as first step. 
Please check if the configuration example is aligned to what is needed.

# How To Use it (backup)

1-
Install Git and clone the project

sudo apt update </br>
sudo apt -y install git </br>
git clone https://github.com/val3r1o/os10-backup-restore.git </br>

2-
FORK this Repository on your own Github  so you can sync on your own space</br>
Change the branch name based on your project</br>
Please check the file -> Create-Github-account.txt</br>

3-
When ready run:

sudo chmod 755 backup.sh </br>
./backup.sh</br>
if local backup and github sync is needed or 

ansible-playbook -i inventory copyconfig.yml</br>
if only local backup is needed

All configurations are stored on this local folder:
/configs
/templates

# How To Use it (restore)

Run the Ansible playbook to push the configs under /templates (jinja template) into your OS10 node
This example uses the dellos.dellos-copy-config role to push the configuration file into the device

1-
ansible-playbook -i inventory pushconfig.yml


# note

Please review https://github.com/val3r1o/os10-startup-ansible to create control node right way

Please note on git auth changes August 2021 - single password not accepted anymore
https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token
