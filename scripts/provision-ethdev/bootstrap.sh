#!/usr/bin/env bash

# get the SenacorSlackDapp project
mkdir repos
cd repos
git clone https://github.com/senacor/SmartContractSlackDapp.git


# install sublime text (optional - if you no like then comment it)
sudo add-apt-repository ppa:webupd8team/sublime-text-3
sudo apt-get update
sudo apt-get install sublime-text-installer

## NOTE: auto-install of sublime package control and ethereum package does not work yet
# install package control
# mkdir -p "/home/vagrant/.config/sublime-text-3/Installed Packages"
# cd "/home/vagrant/.config/sublime-text-3/Installed Packages" && curl -O https://packagecontrol.io/Package%20Control.sublime-package
# mv "./Package%20Control.sublime-package" "./Package Control.sublime-package"
# # create folder structure
# mkdir -p "/home/vagrant/.config/sublime-text-3/Packages/User/"
# cd "/home/vagrant/.config/sublime-text-3/Packages/User/"
# # add Ethereum package
# echo '{' > Package\ Control.sublime-settings
# echo '"bootstrapped": true,' >> Package\ Control.sublime-settings
# echo '"in_process_packages":' >> Package\ Control.sublime-settings
# echo '[' >> Package\ Control.sublime-settings
# echo '],' >> Package\ Control.sublime-settings
# echo '"installed_packages":' >> Package\ Control.sublime-settings
# echo '[' >> Package\ Control.sublime-settings
# echo '"Ethereum"' >> Package\ Control.sublime-settings
# echo ']' >> Package\ Control.sublime-settings
# echo '}' >> Package\ Control.sublime-settings