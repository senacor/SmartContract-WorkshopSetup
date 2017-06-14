# SmartContract-Workshop
This repo provides instructions for the Smart Contract workshops we provide. 

It is assumed that you did the steps in the folder ```before-workshop``` already.

## Running and shutting down the machine

### First startup of machine

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

### Startup and shutdown after first startup (including provisioning) is over

Shutdown the machine:
```
vagrant halt 
```

Start the machine (provisioning will not be done unless you say so explicitly):
```
vagrant up
```

### Manage the machine(s)

Update the machine's box to new version (it will show you when I released a new version of the box on the Atlas server):
```
vagrant box update
```

Show list of boxes currently available on this computer:
```
vagrant box list
```

Remove a box from computer:
```
vagrant box remove BOX_NAME [--box.version BOX_VERSION]
```

Note: The box files are stored in the ```.vagrant.d``` folder in your user provile. The upacked VirtualBox machines are stored in VirtualBox's default VM folder. Usually that is the folder ```VirtualBox VMs``` in yor user profile.

### Troubleshooting

##### Problem: "[...] USB 2.0 Ports [...]"

Make sure you installed the VirtualBox Extension Pack! See setup in ```before-workshop```.

##### Problem: "the guest extensions on this machine do not match the installed version of VirtualBox"

Note that this problem will just appear when you run the "vagrant up" command. Adding the machine should not result in problems.

If you get the warning, that "the guest extensions on this machine do not match the installed version of VirtualBox" when you run "vagrant up" you should be able to ignoe it. Note that your shared folder (folder shared between host and guest machine) might not work properly - but that's not a big problem.



## First Steps with Ethereum

The following tools are pre-installed in the ethdev machine:

1. **[geth](https://geth.ethereum.org/)**: The Ethereum-go client
2. **[remix browser-solidity](https://github.com/ethereum/browser-solidity)**: "IDE" to write, compile and deploy contracts (offle version installed). You find the online version here: https://ethereum.github.io/browser-solidity
3. **[truffle framework](http://truffleframework.com/)**: A development framework for contracts and DApps.
4. ** Sublime Text**: Installation includes the "ethereum package" that provides syntax highlighting for ```.sol``` files.

### Starting geth and syncing the Rinkeby testnet

Open terminal and run:
```
geth --rinkeby console
```

If you want to pipe the log output to another terminal then open 2 terminals. Run ``ps`` in the first terminal and check the number you get. Then run this in the second terminal (where ```X``` is the terminal number you retrieved by the ```ps``` command in the first terminal):
```
get --rinkeby console 2>>/dev/pts/X
```

### Useful geth javascript-console commands

Retrieve array with your accounts:
``` 
eth.accounts
```


Set your coinbase (needed for mining, but also makes it easier to use):
```
miner.setEtherbase(eth.accounts[ACCOUNT_INDEX])
```

Unlock your account (its useful to provide a lot of time when developing, then you don't have to unlock again and again):
```
personal.unlockAccount(ACCOUNT_ADDRESS, PASSWORD, TIME_IN_SECONDS)
```

### remix browser-solidity explained



IMPORTANT: Note that the "Value" field (where you enter ether to be sent to the contract upon creation) is not in Wei but in Ether! You can enter floating point numbers there!

### testrpc explained

testrpc is a tool that simulates a ledger for you. It is used for testing contracts locally (unit testing).

### Truffle explained

Create and empty folder for your (test) project and navigate to the new folder in your terminal.
Open another terminal and run the ```testrpc```.
Note: You can also use any network that is synced by geth for deployment. But this is not recommended, because it is very time intensive. You should just deploy to a real network (e.g. rinkeby-testnet, main-net) when your contracts were already tested thouroughly on your local machine using testrpc.

#### Project that includes contracts only

In this setup you get an environment with contracts and tests for the contracts set up. No DApp included.

Create the project:
```
truffle init 
```

Truffle will tell you the commands you can use once the project was set up. Here they are for reference:

Compile your contract(s):
```
truffle compile
```

Deploy your contract(s) to the network running at ```localhost:8585``` (usually it should be the testrpc running there):
```
truffle migrate
```

Run the test written for the contract(s):
``` 
truffle test
```


#### Project that includes contracts and DApp

This setup includes the contract setup (as above) and additionally integrates a DApp with the conract setup.

Setup with DApp:
```
truffle init webpack
```

The commands for running the contracts are the same as in the contract-only setup.

Additionally you can run the DApp by doing:
```
npm build
```

```
npm run dev
```


### Running the Senacor Smart Contract Lottery

A detailed description can be found in the SenacorSmartContractLottery's repo.

Quick-Guide:

It is assumed that you already have an accout on the network you want to play, that holds Ether. This account will serve as the "admin-account". This is to be configured in the ```.env```file (see step 5 and 6).
It is also assumed that you already created a slack team, a slack bot in that team and a google account used for sending messages.

1. Start geth and sync chain.
2. Expose geth's RPC: ```admin.startRPC("127.0.0.1", 8545, "*", "web3,net,eth,personal")```
3. Open browser-solidity and connect to geth (select ```web3 Provider``` in dropdown)
4. Load, compile and deploy the ```Lottery.sol``` contract (you will also have to open ```LotteryEventDefinitions.sol``` in browser-solidity to be able to compile)
5. Navigate to folder ```nodeserver/app/``` and create a file name: ```.env``` 
6. Take a look at ```.env_example``` to configure your ```.env``` file.
7. run ```npm install```
8. run ```npm start```  
