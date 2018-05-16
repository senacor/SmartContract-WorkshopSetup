# What you have to do before the workshop starts
This repo provides setup instructions for the Smart Contract workshops we provide. This part is to be done before the workshop starts.

## Do the 4-step setup

1. Install VirtualBox: https://www.virtualbox.org/wiki/Downloads
2. Install VirtualBox Extension Pack: https://www.virtualbox.org/wiki/Downloads (click on the Extensions link and save the Extension pack file)
    * to install the extension start VirtualBox as admin/root and go to File->Settings->Extensions
3. Install Vagrant: https://www.vagrantup.com/downloads.html 
4. run this command in terminal: ```vagrant box add dakami/ethdev```

The command will download a virtual machine box file to your computer. After the download finished you are done.

All the other stuff (provisioning of the machine, project setup, chainsync) will be done together in the workshop.

## Additional information (optional)

You can read this but you don't have to. 

### Setup Requirements 

The setup we propose will provide you with an lubuntu machine (with GUI) that includes all the necessary tools we use during the workshop. 

The machine is vagrant managed so you can adapt it to your needs, easily remove and recreate it.

* About ~10GB of free disk space. 
* VirtualBox
* Vagrant

### Troubleshooting

#### Keyboard layout

If you are using a Macbook or another computer with a specific keyboard layout you might want to change the virtual machine's keyboard layout accordingly. We are using a linux distribution called Lubuntu. In order to change the keyboard layout on Lubuntu follow these steps:

1. Right click the panel at the left bottom
2. Add Panel Items
3. Keyboard Layout Handler
4. Add new keyboard layout -> select "Mac Laptop" keyboard

#### Problem: "[...] error 104"

This is a download error - hashicorp's vagrant cloud (previously "atlas server") and the connections to it are sometimes not that stable... 
If you get this error it means that the connections was interrupted and the download was aborted. You can just run it again ("vagrant box add dakami/ethdev"); it should resume the download at the point where it stopped.

Note: It might help to plug your computer by cable.

### Alternative setup possibilities
You can also setup everything locally (not recommended) or alter the base machine we use.

Note: You should calculate an additional ~6GB for syncing the rinkeby testnet (will be done together in the workshop).

Setup was tested on: Windows10 machine, Mac

### Notes and further instructions

Note: We will only use the Rinkeby testnet (and local testrpc) in the workshop, so you don't have to worry too much about long synchronization times when syncing the net. Usually, production-chains should not be accessible from the dev-environment. Just imagine forgetting to switch networks and spending ether on mainchain ;) An AWS instance may be used to handle this problem, but there are also other possibilities you will hear about in the workshop :)

Note: The machine includes a complete Ethereum development setup (truffle, testrpc, geth). Testnets are not synced yet - we will do this together in the workshop. 

Note: If box-download from hashicorp's atlas server is slow (below 500k is slow) then complain here: https://github.com/mitchellh/vagrant/issues/5319 

If you want to do look into the `alternative-setup/provision-lubuntu` folder.
