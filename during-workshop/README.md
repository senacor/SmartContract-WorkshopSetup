# SmartContract-Workshop
This repo provides instructions for the Smart Contract workshops we provide. 

It is assumed that you did the steps in the folder ```before-workshop``` already.

## Running the machine (to be done in workshop)

To run the machine you have to use the ```Vagrantfile``` and ```bootstrap.sh``` provisioning script that is provided in folder ```provision-ethdev```. 

1. Create an empty new folder. You can name it however you like, suggestion: ```EthereumWorkshop```
2. Download the ```Vagrantfile``` and ```bootstrap.sh``` files into the new folder.
3. Navigate to the folder in your local terminal (command line).
4. run command: ```vagrant up```
5. Wait until the command line output finishes (provisioning will be done headless).
6. run command: ```vagrant halt```
7. Wait until the machine was "gracefully shut down"
8. run command (again): ```vagrant up```
9. The machine will start up with GUI now.
10. Log in with password ```vagrant```
11. Ignore the popup of sublime-text, wait until it closes itself.

## Testing Truffle

Just contract setup (including tests for contracts):
```
truffle init 
```

Setup with DApp:
```
truffle init webpack
```

## Troubleshooting

### Problem: "[...] USB 2.0 Ports [...]"

Make sure you installed the VirtualBox Extension Pack! See setup in ```before-workshop```.

### Problem: "the guest extensions on this machine do not match the installed version of VirtualBox"

Note that this problem will just appear when you run the "vagrant up" command. Adding the machine should not result in problems.

If you get the warning, that "the guest extensions on this machine do not match the installed version of VirtualBox" when you run "vagrant up" you should be able to ignoe it. Note that your shared folder (folder shared between host and guest machine) might not work properly - but that's not a big problem.
