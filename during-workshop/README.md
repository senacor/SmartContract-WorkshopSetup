# SmartContract-Workshop
This repo provides instructions for the Smart Contract workshops we provide. 

It is assumed that you did the steps in the folder ```before-workshop``` already.

## Running and shutting down the machine

### First startup of machine

To run the machine you have to use the ```Vagrantfile``` and ```bootstrap.sh``` provisioning script provided in [SmartContractWorkshop-VM folder](https://github.com/senacor/SmartContract-WorkshopSetup/tree/master/during-workshop/SmartContractWorkshop-VM)!
Don't just run ```vagrant init``` with the ethdev machine, it will not provision as wanted. 

1. Clone this repository. 
2. Navigate to folder ```SmartContractWorkshop-VM``` in your terminal.
3. run command: ```vagrant up```
4. Wait until the command line output finishes (provisioning will be done headless).
5. run command: ```vagrant halt```
6. Wait until the machine was "gracefully shut down"
7. run command (again): ```vagrant up```
8. The machine will start up with GUI now.
9. Log in with password ```vagrant```

Note:  Instead of cloning the repository (step 1) you can also create an empty folder and copy the Vagrantfile and the bootstrap.sh file into it. Vagrant needs these 2 files to manage the machine.

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

Note: The box files are stored in the ```.vagrant.d``` folder in your user provile. The unpacked VirtualBox machines are stored in VirtualBox's default VM folder. Usually that is the folder ```VirtualBox VMs``` in your user profile.

### Troubleshooting

#### Problem: "[...] USB 2.0 Ports [...]"

Make sure you installed the VirtualBox Extension Pack! See setup in ```before-workshop```.

#### Problem: "the guest extensions on this machine do not match the installed version of VirtualBox"

Note that this problem will just appear when you run the "vagrant up" command. Adding the machine should not result in problems.

If you get the warning, that "the guest extensions on this machine do not match the installed version of VirtualBox" when you run "vagrant up" you should be able to ignoe it. Note that your shared folder (folder shared between host and guest machine) might not work properly - but that's not a big problem.

#### "No provider found (...)" or similar error message

If you receive an error on machine startup, that tells you that "no provided can be found" (or similar) then make sure you have the latest version of VirtualBox installed. 

#### The setup is stuck ("hangs")

Most important question: Are you on a Lenovo notebook?

*If yes:* 

Most likely your ["hardware virtualization" is deactivated in BIOS](https://stackoverflow.com/questions/34907910/vagrant-up-hangs-at-ssh-auth-method-private-key). 

1. Access your BIOS and activate "hardware virtualization". 
2. Try again, it should work now.

*If no:*

1. Check if you your internet connection works properly
2. Wait for about ~5 minutes to see if an error appears.
3. Once an error appears: google it

All the "hang" we encountered so far were caused by the hardware virtualization deactivated problem.

## First Steps with Ethereum

The following tools are pre-installed in the ethdev machine:

1. **[geth](https://geth.ethereum.org/)**: The Ethereum-go client
2. **[remix browser-solidity](https://github.com/ethereum/browser-solidity)**: "IDE" to write, compile and deploy contracts (off-line version installed, see ```~/browser-solidity/index.html```). You find the online version here: https://ethereum.github.io/browser-solidity
3. **[truffle framework](http://truffleframework.com/)**: A development framework for contracts and DApps.
4. **Sublime Text**: Installation includes the "ethereum package" that provides syntax highlighting for ```.sol``` files.
5. **Chrome Browser**: Unfortunately Firefox is not that good supported by browser-solidity, thus Chrome was added for better look and feel.

### Important Links - in order of importance ;)

- geth startup commands (command line options): https://github.com/ethereum/go-ethereum/wiki/Command-Line-Options
- geth JavaScript console commands: https://github.com/ethereum/go-ethereum/wiki/JavaScript-Console
- Info and transaction/address lookup on the testnet: https://rinkeby.etherscan.io/
- Solidity documentation: https://solidity.readthedocs.io
- Ethereum foundation website: https://www.ethereum.org
- Ethereum blog: https://blog.ethereum.org/ 
- Ethereum Stack-Exchange: https://ethereum.stackexchange.com/
- Ethereum on reddit: https://www.reddit.com/r/ethereum/
- Ethereum Classic: https://ethereumclassic.github.io/

### Starting geth and syncing the Rinkeby testnet

Open terminal and run:
```
geth --rinkeby console
```

If you want to pipe the log output to another terminal then open 2 terminals. Run ``ps`` in the first terminal and check the number you get in the tty column (pts/2). Then run this in the second terminal (where ```X``` is the terminal number you retrieved by the ```ps``` command in the first terminal):
```
geth --rinkeby console 2>>/dev/pts/X
```

#### Useful geth javascript-console commands

##### Accounts

Before you can do anything on the rinkeby testnet you need an account to operate.
An account is basically just a key pair. The address of your account is derived from the public key of the account. The private key is encrypted with the password you provide. Create a new account like this:
```
personal.newAccount(PASSWORD_PASSWORD)
```

Note: When operating on the testnet feel free to use relatively simple passwords; this makes it easier when unlocking the account. For the main-net (productive chain) be sure to use a good (especially long) password!

Retrieve array with your accounts:
``` 
eth.accounts
```

Retrieve the address of your primary account (also used as address for mining rewards):
```
eth.coinbase
```

Set your ```coinbase``` (needed for mining, but also makes it easier to use):
```
miner.setEtherbase(eth.accounts[ACCOUNT_INDEX])
```

Unlock your account (its useful to provide a lot of time when developing, then you don't have to unlock again and again):
```
personal.unlockAccount(ACCOUNT_ADDRESS, PASSWORD, TIME_IN_SECONDS)
```

See your account balance (standard unit is Wei):
```
eth.getBalance(eth.coinbase)
```

If you want to see your balance in Ether you can wrap the command like this:
```
web3.fromWei(eth.getBalance(eth.coinbase))
```

##### Sending Transaction

If you want to send a mony transaction you can do that like this (standard unit for the value is in Wei!):
```
eth.sendTransaction({from: eth.coinbase, to: 'SOME_ADDRESS', value: SOME_VALUE})
```

If you don't want to enter the amount in Wei you can do it in Ether and wrap it like this:
```
eth.sendTransaction({from: eth.coinbase, to: 'SOME_ADDRESS', value: web3.toWei(1)})
```


##### geth RPC

Expose the geth RPC-interface (so it can be accessed by browser-solidity, etc.). Note that ```"web3,net,eth,personal"``` marks the modules that will be exposed. Usually you don't have to expose the ```personal``` module, but since we need it exposed for the DApp presented in the workshop it is part of the string here:
```
admin.startRPC("127.0.0.1", 8545, "*", "web3,net,eth,personal")
```

### Remix browser-solidity explained

Browser-solidity is an IDE that allows you to write, compile and deploy solidity code. In the most recent versions it even offers code completion now. Note that browser-solidity is not a full-blown IDE (like eclipse or IntelliJ IDEA) but it offers some nice features especially for Solidity programming. Feel free to install the text editor (or IDE) of your choice instead.

**IMPORTANT:** 

- Note that the "Value" field (where you enter ether to be sent to the contract upon creation) is not in Wei but in Ether! You can enter floating point numbers there! 
- However, parameters to functions are usually passed in Wei (unless you implement conversion in the contract)! 
- Note that you will have to wrap long numbers passed as parameters with hyphans like this: ```"1000000000000000"```

#### Deploying code to testrpc and testnet

One feature that makes browser-solidity nice, is the possibility to connect it to your local geth-client (or testrpc) by selecting ```Web3 Provider``` instead of ```JavaScript VM``` in the ```Execution environment``` section of the ```Contract``` tab in browser-solidity's management console.

#### Use browser solidity with your local computer's workspace

Through the npm extension ```remixd``` you can create a link between a folder on your local disk and your offline solidity installation. Note that solidity has to be available offline. In the virtual machine this setup is provided.

In order to create a link between your local contract folder and browser-solidity do this:

1. Open a terminal and run: ```remixd -S [PATH_TO_CONTRACT_FOLDER]```, for the VM you can run: ```remixd -S /home/vagrant/repos/SmartContractSlackDapp/smart-contract/lottery/contracts```
2. Navigate to the ```browser-solidity``` folder and open ```index.html``` in your Chrome browser.
3. Wait until the page has properly loaded.
4. Press the link icon ("Connect to localhost") in the toolbar ontop of the left sidebar.
5. A pop-up window will open, press ```Connect```
6. The link icon should turn green and the ```localhost``` folder should appear in the left sidebar.

Note: The path has to be a real path and not a sym-link!

Note: When you open a contract file it will auto-compile. Once you start editing the file the auto-compile functionality might be annoying as it might block the editor. You can just turn auto-compile off in the "Compile" tab of the left side-bar.


### "Hello-World" Solidity Contract: The Greeter

The solidity compiler is the one most in use for the Ethereum EVM. There are other languages and other compilers but our tutorial is based on solidity. Checkout the [solidity documentation](http://solidity.readthedocs.io/en/latest/) for reference.

One of the most common "Hello-World" examples is the ["Greeter" example offered on the website of the Ethereum foundation](https://www.ethereum.org/greeter)

Here is the code of the Greeter example:
```
pragma solidity ^0.4.5;

contract mortal  {
    /* Define variable owner of the type address*/
    address owner;

    /* this function is executed at initialization and sets the owner of the contract */
    function mortal() public { owner = msg.sender; }

    /* Function to recover the funds on the contract */
    function kill() public { if (msg.sender == owner) selfdestruct(owner); }
}

contract greeter is mortal {
    /* define variable greeting of the type string */
    string greeting;

    /* this runs when the contract is executed */
    function greeter(string _greeting) public {
        greeting = _greeting;
    }

    /* main function */
    function greet() public constant returns (string) {
        return greeting;
    }
}
```

**Challenge:** Add another function that lets anyone in the network change the greeting.

Here is the adapted example with the additional function that allows anyone to change the greeting:
```
pragma solidity ^0.4.5;

contract mortal  {
    /* Define variable owner of the type address*/
    address owner;

    /* this function is executed at initialization and sets the owner of the contract */
    function mortal() public { owner = msg.sender; }

    /* Function to recover the funds on the contract */
    function kill() public { if (msg.sender == owner) selfdestruct(owner); }
}

contract greeter is mortal {
    /* define variable greeting of the type string */
    string greeting;

    /* this runs when the contract is executed */
    function greeter(string _greeting) public {
        greeting = _greeting;
    }

    /* main function */
    function greet() public constant returns (string) {
        return greeting;
    }
    
    function changeGreeting(string _newGreeting) public {
        greeting = _newGreeting;
    }
}
```

It is recommended to use browser-solidity to compile the contract. This will give you the following deployment code in the browser-solidity "contract" tab of the management console:
```
var _greeting = /* var of type string here */ ;
var greeterContract = web3.eth.contract([{"constant":false,"inputs":[],"name":"kill","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"greet","outputs":[{"name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_newGreeting","type":"string"}],"name":"changeGreeting","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"inputs":[{"name":"_greeting","type":"string"}],"payable":false,"stateMutability":"nonpayable","type":"constructor"}]);
var greeter = greeterContract.new(
   _greeting,
   {
     from: web3.eth.accounts[0], 
     data: '0x6060604052341561000f57600080fd5b6040516104c73803806104c783398101604052808051820191905050336000806101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055508060019080519060200190610081929190610088565b505061012d565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f106100c957805160ff19168380011785556100f7565b828001600101855582156100f7579182015b828111156100f65782518255916020019190600101906100db565b5b5090506101049190610108565b5090565b61012a91905b8082111561012657600081600090555060010161010e565b5090565b90565b61038b8061013c6000396000f30060606040526000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff16806341c0e1b514610053578063cfae321714610068578063d28c25d4146100f657600080fd5b341561005e57600080fd5b610066610153565b005b341561007357600080fd5b61007b6101e4565b6040518080602001828103825283818151815260200191508051906020019080838360005b838110156100bb5780820151818401526020810190506100a0565b50505050905090810190601f1680156100e85780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b341561010157600080fd5b610151600480803590602001908201803590602001908080601f0160208091040260200160405190810160405280939291908181526020018383808284378201915050505050509190505061028c565b005b6000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff1614156101e2576000809054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16ff5b565b6101ec6102a6565b60018054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156102825780601f1061025757610100808354040283529160200191610282565b820191906000526020600020905b81548152906001019060200180831161026557829003601f168201915b5050505050905090565b80600190805190602001906102a29291906102ba565b5050565b602060405190810160405280600081525090565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f106102fb57805160ff1916838001178555610329565b82800160010185558215610329579182015b8281111561032857825182559160200191906001019061030d565b5b509050610336919061033a565b5090565b61035c91905b80821115610358576000816000905550600101610340565b5090565b905600a165627a7a723058206a503d970fe4c7605bc3f7a55f437bfd8e2d957aa3666f7d1d23aa30d06fc4eb0029', 
     gas: '4700000'
   }, function (e, contract){
    console.log(e, contract);
    if (typeof contract.address !== 'undefined') {
         console.log('Contract mined! address: ' + contract.address + ' transactionHash: ' + contract.transactionHash);
    }
 })
 ```
 
 You should fill in your greeting; something like this:
 ```
 var _greeting = "Zuuuuup";
``` 
 
The contract-definition is done by calling ```web3.eth.contract(CONTRACT_ABI)``` (as seen in the second line of the deployment code above). You also find the ABI (application binary interface) of the contract in the management console of browser-solidity in the fields marked with "interface"; pretty-printed it looks like this:
```
[
    {
        "constant": false,
        "inputs": [],
        "name": "kill",
        "outputs": [],
        "payable": false,
        "type": "function"
    },
    {
        "constant": true,
        "inputs": [],
        "name": "greet",
        "outputs": [
            {
                "name": "",
                "type": "string"
            }
        ],
        "payable": false,
        "type": "function"
    },
    {
        "constant": false,
        "inputs": [
            {
                "name": "_newGreeting",
                "type": "string"
            }
        ],
        "name": "changeGreeting",
        "outputs": [],
        "payable": false,
        "type": "function"
    },
    {
        "inputs": [
            {
                "name": "_greeting",
                "type": "string"
            }
        ],
        "payable": false,
        "type": "constructor"
    }
]

```

The ABI defines the interface of your contract; it defines all function-signatures that the contract offers.

With ```var greeter = greeterContract.new(...)``` you deploy the byte-code of your contract to the blockchain. This is called a "contract creation". After the contract was mined you can access the contract at the dedicated contract address that you received when you triggered the deployment transaction. The instance of the contract will then be held in the ```greeter``` variable.

If you want to retrieve an already existing instance of a contract you can use the ```at(CONTRACT_ADDRESS)``` function instead of ```new(...)```:
```
var greeter = greeterContract.at(CONTRACT_ADR);
```

Once you hold the instance of the contract in the ```greeter``` variable you can access the greeting like this:
```
greeter.greet()
```

The more unified way of just calling a function is using the ```call()``` function specifically:
```
greeter.greet.call()
```

If you want to change the greeting you have to trigger a transaction against the ```changeGreeting```function of the contract:
```
greeter.changeGreeting.sendTransaction("new greeting string", {from: YOUR_ADDRESS})
```

For simplicity you can just replace ```YOUR_ADDRESS``` with ```eth.coinbase```. Note that you will have to unlock the account before sending you can trigger a transaction from that account!

### testrpc explained

testrpc is a tool that simulates a ledger for you. It is used for testing contracts locally (unit testing).

### Truffle explained

For details please refer to the [truffle documentation](http://truffleframework.com/docs/)!

Create and empty folder for your (test) project and navigate to the new folder in your terminal.
Open another terminal and run the ```testrpc```.
Note: You can also use any network that is synced by geth for deployment. But this is not recommended, because it is very time intensive. You should just deploy to a real network (e.g. rinkeby-testnet, main-net) when your contracts were already tested thoroughly on your local machine using testrpc.

#### Project that includes contracts only

In this setup you get an environment with contracts and tests for the contracts set up. No DApp included.

Create the project:
```
truffle unbox 
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

This setup includes the contract setup (as above) and additionally integrates a DApp with the contract setup.

Setup with DApp:
```
truffle unbox webpack
```

The commands for running the contracts are the same as in the contract-only setup.

Additionally you get a DApp example set up that you can run in several profiles (lint, dev, build). For additional information check the documentation.



### Running the Senacor Smart Contract Lottery

A detailed description can be found in the [SenacorSmartContractLottery's repo](https://github.com/senacor/SmartContractSlackDapp).

Quick-Guide for the lotter contract:

The lottery contract is located in the folder ```SmartContractSlackDapp/smart-contract/lottery/contracts```. The contract project is set up as truffle project, you can use ```truffle compile```, ```truffle migrate``` and ```truffle test``` in the folder ```SmartContractSlackDapp/smart-contract/lottery```.

```Lottery.sol``` contains the lottery contract, ```LotteryEventDefition```  the events defined for the contracts. The ```Migrations.sol``` file is part of the truffle setup.


#### Setting up and running the DApp

It is assumed that you already have an accout on the network you want to play, that holds Ether. This account will serve as the "admin-account". This is to be configured in the ```.env```file (see step 5 and 6).
It is also assumed that you already created a slack team, a slack bot in that team and a google account used for sending the account emails.

1. Start geth and sync chain.
2. Expose geth's RPC: ```admin.startRPC("127.0.0.1", 8545, "*", "web3,net,eth,personal")```
3. Open browser-solidity and connect to geth (select ```Web3 Provider``` in dropdown ```Execution environment``` in the ```Contract``` tab; confirm the 2 popups)
4. Load, compile and deploy the ```Lottery.sol``` contract (you will also have to open ```LotteryEventDefinitions.sol``` in browser-solidity to be able to compile)
5. Navigate to folder ```nodeserver/app/``` and create a file named: ```.env``` 
6. Take a look at ```.env_example``` to configure your ```.env``` file.
7. run ```npm install```
8. run ```npm start```

