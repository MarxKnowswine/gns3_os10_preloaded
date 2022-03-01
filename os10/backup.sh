
echo ------------------------------------------------------------------------------------------------------
echo ------------------ This is an automatic backup -------------------------------------------------------
echo ------------------------------------------------------------------------------------------------------
echo ------------------------------------------------- Dell NETWORKING ------------------------------------
echo ------------------------------------------------------------------------------------------------------

# a git account and git running on the node is needed. https://docs.github.com/en 
# cd os10-config-backup/
#change the name as your project needs, check EVPN multisite or EVPN DCI for further examples 
ansible-playbook -i inventory copyconfig.yml

git status
git pull
read -p "Enter Your user.name: " n
read -p "Enter Your user.mail: " m
# echo "Name: ${n}!"
# echo "Mail: ${m}!"
echo ----- THIS IS WHO YOUR ARE ------------------------------------
git config --global user.email "${m}"
git config --global user.name "${n}"
git config --global user.email
git config --global user.name
echo ----- WHICH BRANCH IS ACTIVE ------------------------------------
git branch -a 

read -p "Enter Your new project (branch) " b
git checkout -b "${b}"

echo ----- WHICH BRANCH IS ACTIVE now ------------------------------------
git branch -a 

git add .
git commit -a -m "automatic update"

git push -u origin "${b}"

echo ----- NEW STATUS ------------------------------------
git status

echo
echo ------------------------------------------------------------------------------------------------------
echo ------------------------------------------------------------------------------------------------------
echo -------------------------------------- Thats all folks "!!" ------------------------------------------
echo ------------------------------------------------------------------------------------------------------
echo ------------------ This is an automatic script -------------------------------------------------------
echo ------------------------------------------------------------------------------------------------------
echo ------------------------------------------------- Dell NETWORKING ------------------------------------
echo -----------------valerio.martini@gmail.com------------------------------------------------------------
echo ------------------------------------------------------------------------------------------------------
