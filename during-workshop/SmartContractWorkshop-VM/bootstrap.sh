#!/usr/bin/env bash

## install newest version of geth
echo "##################################################"
echo "Update geth to newest version"
echo "##################################################"
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo add-apt-repository -y ppa:ethereum/ethereum-dev
sudo apt-get update
sudo apt-get -y install geth
mkdir -p .ethereum/rinkeby/
sudo chown -R vagrant:vagrant .ethereum/

# get the SenacorSlackDapp project
echo "##################################################"
echo "CLONE: SenacorSlackDapp"
echo "##################################################"
mkdir repos
cd repos
git clone https://github.com/senacor/SmartContractSlackDapp.git

echo "##################################################"
echo "Make vagrant user owner of the repo"
echo "##################################################"
cd /home/vagrant/
sudo chown -R vagrant:vagrant repos
sudo chown -R vagrant:vagrant repos/SmartContractSlackDapp/.git

# install sublime text (optional - if you no like then comment it)
echo "##################################################"
echo "INSTALL: Sublime text"
echo "##################################################"
sudo add-apt-repository ppa:webupd8team/sublime-text-3
sudo apt-get update
sudo apt-get install -y sublime-text-installer
cp /usr/share/applications/sublime-text.desktop /home/vagrant/Desktop/

## NOTE: auto-install of sublime package control and ethereum package does not work yet
# install package control
echo "##################################################"
echo "ADD: Sublime Package Control and Ethereum Package"
echo "##################################################"
mkdir -p "/home/vagrant/.config/sublime-text-3/Installed Packages"
cd "/home/vagrant/.config/sublime-text-3/Installed Packages" && curl -O https://packagecontrol.io/Package%20Control.sublime-package
mv "./Package%20Control.sublime-package" "./Package Control.sublime-package"
# create folder structure
mkdir -p "/home/vagrant/.config/sublime-text-3/Packages/User/"
cd "/home/vagrant/.config/sublime-text-3/Packages/User/"
# add Ethereum package
echo '{' > Package\ Control.sublime-settings
#echo '"bootstrapped": true,' >> Package\ Control.sublime-settings
#echo '"in_process_packages":' >> Package\ Control.sublime-settings
#echo '[' >> Package\ Control.sublime-settings
#echo '],' >> Package\ Control.sublime-settings
echo '"installed_packages":' >> Package\ Control.sublime-settings
echo '[' >> Package\ Control.sublime-settings
echo '"Ethereum"' >> Package\ Control.sublime-settings
echo ']' >> Package\ Control.sublime-settings
echo '}' >> Package\ Control.sublime-settings
echo "##################################################"
echo "CONFIGURE: Rights on package control and stuff"
echo "##################################################"
chown -R vagrant:vagrant "/home/vagrant/.config/"
# Note: starting sublime-text (using subl) in command line does not work (just fails)

# create desktop shortcuts
ln -s /home/vagrant/browser-solidity/ /home/vagrant/Desktop/
ln -s /home/vagrant/repos/SmartContractSlackDapp/ /home/vagrant/Desktop/
#ln -s /home/vagrant/.ethereum/ /home/vagrant/Desktop/
#mv /home/vagrant/Desktop/.ethereum /home/vagrant/Desktop/ethereum
chown -R vagrant:vagrant /home/vagrant/Desktop/

# add autostart folder
mkdir -p /home/vagrant/.config/autostart/
# add desktop file that will start up the sublime text package setup script (see below)
#echo "#!/usr/bin/env xdg-open" >> /home/vagrant/.config/autostart/sublime-setup.desktop
echo "[Desktop Entry]" >> /home/vagrant/.config/autostart/sublime-setup.desktop
echo "Version=1.0" >> /home/vagrant/.config/autostart/sublime-setup.desktop
echo "Type=Application" >> /home/vagrant/.config/autostart/sublime-setup.desktop
echo "Terminal=true" >> /home/vagrant/.config/autostart/sublime-setup.desktop
echo "Exec=/home/vagrant/Desktop/sublime-text-install-script.sh" >> /home/vagrant/.config/autostart/sublime-setup.desktop
echo "X-GNOME-Autostart-enabled=true" >> /home/vagrant/.config/autostart/sublime-setup.desktop

# prepare startup script for sublime text package setup (start sublime, wait, close it, start it again, wait, close it)
# Note: This is needed because it cannot be done through ssh; sublime won't start up without GUI
# Note: The script will clean itself up after first run.
echo "#!/usr/bin/env bash" >> /home/vagrant/Desktop/sublime-text-install-script.sh
echo "subl" >> /home/vagrant/Desktop/sublime-text-install-script.sh
echo "sleep 5" >> /home/vagrant/Desktop/sublime-text-install-script.sh
echo "killall sublime_text" >> /home/vagrant/Desktop/sublime-text-install-script.sh
echo "subl" >> /home/vagrant/Desktop/sublime-text-install-script.sh
echo "sleep 5" >> /home/vagrant/Desktop/sublime-text-install-script.sh
echo "killall sublime_text" >> /home/vagrant/Desktop/sublime-text-install-script.sh
# cleanup the .profile file (remove the start entry for the script)
echo "sudo rm /home/vagrant/.config/autostart/sublime-setup.desktop" >> /home/vagrant/Desktop/sublime-text-install-script.sh
# self-destruct the script after execution
echo 'sudo rm -- "$0"' >> /home/vagrant/Desktop/sublime-text-install-script.sh
chmod +x /home/vagrant/Desktop/sublime-text-install-script.sh

