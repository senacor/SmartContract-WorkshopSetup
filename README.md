# SmartContract-WorkshopSetup
This repo provides setup instructions for the Smart Contract workshops we provide. 

## Overview
The setup we propose will provide you with an lubuntu machine (with GUI) that inclues all the necessary tools we use during the workshop. The machine is vagrant managed so you can adapt it to your needs, easily remove and recreate it.

## Alternative setup possibilities
You can also setup everything locally (not recommended). If you want to do this you can use the `bootstrap.sh` script in the `scrips/provision-lubuntu` folder.

## Setup Requirements 

* About ~10GB of free disk space. 
* VirtualBox
* Vagrant

Setup was tested on: Windows10 machine, Mac

## Setup Before Workshop

1. Install VirtualBox + VirtualBox Extensions: https://www.virtualbox.org/wiki/Downloads
2. Install Vagrant: https://www.vagrantup.com/downloads.html 
3. run this command in terminal: vagrant box add dakami/ethdev

All the other stuff (provisioning of the machine, project setup, chainsync) we can do together in the workshop.

## Notes and further instructions

Note: We will only use the Rinkeby testnet (and local testrpc) in the workshop, so you don't have to worry too much about long synchronization times when syncing the net. I don't integrate the prod-chain in my dev-environments. I have a machine on AWS for handling that. More later ;) 

Note: The machine includes a complete Ethereum development setup (truffle, testrpc, geth). Not testnets synced yet - this we can do together in the workshop. 

Note: If box-download from hashicorp's atlas server is slow (below 500k is slow) then complain here: https://github.com/mitchellh/vagrant/issues/5319 

## Running the machine (to be done in workshop)

To run the machine you have to use the vagrant-file and bootstrip.sh script that will be provided in the workshop. Note that the machine is not provisioned yet; we will do that in the workshop. So don't invest too much time into playing around... 
If you really want to run the machine before the workshop to play around here are some useful things:

command for generating the Vagrantfile for machine startup: `vagrant init dakami/ethdev`


open the Vagrantfile and uncomment the section with the gui; it should look like this: 
```
  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = true
  
    # Customize the amount of memory on the VM:
    # vb.memory = "1024"
  end
```

Feel free to assign more memory as well; default in machine is set to 2048...

command for starting the machine: `vagrant up`

command for shutting the machine down (but keep it): `vagrant halt`

command for removing the machine completely: `vagrant destroy`


## Troubleshooting

### Problem: "[...] error 104"

This is a download error - hashicorp's atlas server and the connections to it are sometimes not that stable... If you get this it means that the connections was interrupted and the download was aborted. You can just run it again ("vagrant box add dakami/ethdev"); it should resume the download at the point where it stopped.
Note: It might help to plug your computer by cable.

### Problem: "the guest extensions on this machine do not match the installed version of VirtualBox"

Note that this problem will just appear when you run the "vagrant up" command. Adding the machine should not result in problems.

If you get the warning, that "the guest extensions on this machine do not match the installed version of VirtualBox" when you run "vagrant up" you should be able to ignoe it. Note that your shared folder (folder shared between host and guest machine) might not work properly - but that's not a big problem.
