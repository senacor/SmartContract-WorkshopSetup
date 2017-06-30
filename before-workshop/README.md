# What you have to do before the workshop starts
This repo provides setup instructions for the Smart Contract workshops we provide. This part is to be done before the workshop starts.

## Do the 4-step setup

1. Install VirtualBox: https://www.virtualbox.org/wiki/Downloads
2. Install VirtualBox Extensions: https://www.virtualbox.org/wiki/Downloads (click on the Extensions link and install the Extension pack)
    * to install the extension start VirtualBox as admin/root and go to File->Settings->Extensions
3. Install Vagrant: https://www.vagrantup.com/downloads.html 
4. run this command in terminal: ```vagrant box add dakami/ethdev```

The command will download a virtual machine box file to your computer. After the download finished you are done.

All the other stuff (provisioning of the machine, project setup, chainsync) will be done together in the workshop.

## Additional information (optional)

You can read this but you don't have to. 

### Setup Requirements 

The setup we propose will provide you with an lubuntu machine (with GUI) that inclues all the necessary tools we use during the workshop. 

The machine is vagrant managed so you can adapt it to your needs, easily remove and recreate it.

* About ~10GB of free disk space. 
* VirtualBox
* Vagrant

### Alternative setup possibilities
You can also setup everything locally (not recommended) or alter the base machine we use.

Note: You should calculate an additional ~2GB for syncing the rinkeby testnet (will be done together in the workshop).

Setup was tested on: Windows10 machine, Mac

### Notes and further instructions

Note: We will only use the Rinkeby testnet (and local testrpc) in the workshop, so you don't have to worry too much about long synchronization times when syncing the net. I don't integrate the prod-chain in my dev-environments. I have a machine on AWS for handling that. More later ;) 

Note: The machine includes a complete Ethereum development setup (truffle, testrpc, geth). Not testnets synced yet - this we can do together in the workshop. 

Note: If box-download from hashicorp's atlas server is slow (below 500k is slow) then complain here: https://github.com/mitchellh/vagrant/issues/5319 

If you want to do look into the `alternative-setup/provision-lubuntu` folder.

### Troubleshooting

#### Problem: "[...] error 104"

This is a download error - hashicorp's atlas server and the connections to it are sometimes not that stable... If you get this it means that the connections was interrupted and the download was aborted. You can just run it again ("vagrant box add dakami/ethdev"); it should resume the download at the point where it stopped.
Note: It might help to plug your computer by cable.