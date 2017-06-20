# SmartContract-Workshop
This repo provides instructions for the Smart Contract workshops we provide. 

It is assumed that you did the steps in the folder ```before-workshop``` already.

## Running and shutting down the machine

### First startup of machine

To run the machine you have to use the ```Vagrantfile``` and ```bootstrap.sh``` provisioning script provided in folder ```provision-ethdev```!
Don't just run ```vagrant init``` with the ethdev machine, it will not provision as wanted. 

1. Create an empty new folder. You can name it however you like, suggestion: ```EthereumWorkshop```
2. Download the ```Vagrantfile``` and ```bootstrap.sh``` files from folder ```provision-ethdev``` into the new folder.
3. Navigate to the folder in your local terminal (command line).
4. run command: ```vagrant up```
5. Wait until the command line output finishes (provisioning will be done headless).
6. run command: ```vagrant halt```
7. Wait until the machine was "gracefully shut down"
8. run command (again): ```vagrant up```
9. The machine will start up with GUI now.
10. Log in with password ```vagrant```
11. Ignore the popup of sublime-text, wait until it closes itself.

Note: Intead of creating a new folder and downloading the files (step 1-3) you can also just clone this repo, navigate to the ```provision-ethdev``` folder and then go on with step 4.

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

#### Problem: "[...] USB 2.0 Ports [...]"

Make sure you installed the VirtualBox Extension Pack! See setup in ```before-workshop```.

#### Problem: "the guest extensions on this machine do not match the installed version of VirtualBox"

Note that this problem will just appear when you run the "vagrant up" command. Adding the machine should not result in problems.

If you get the warning, that "the guest extensions on this machine do not match the installed version of VirtualBox" when you run "vagrant up" you should be able to ignoe it. Note that your shared folder (folder shared between host and guest machine) might not work properly - but that's not a big problem.



## First Steps with Ethereum

The following tools are pre-installed in the ethdev machine:

1. **[geth](https://geth.ethereum.org/)**: The Ethereum-go client
2. **[remix browser-solidity](https://github.com/ethereum/browser-solidity)**: "IDE" to write, compile and deploy contracts (offle version installed, see ```~/browser-solidity/index.html```). You find the online version here: https://ethereum.github.io/browser-solidity
3. **[truffle framework](http://truffleframework.com/)**: A development framework for contracts and DApps.
4. **Sublime Text**: Installation includes the "ethereum package" that provides syntax highlighting for ```.sol``` files.
5. **Chrome browse**: Unfortunately Firefox is not that good supported by browser-solidity, thus Chrome was added for better look and feel.

### Important Links - in order of importance ;)

- geth startup commands (command line options): https://github.com/ethereum/go-ethereum/wiki/Command-Line-Options
- geth JavaScript console commands: https://github.com/ethereum/go-ethereum/wiki/JavaScript-Console
- Info and transaction/address lookup on the testnet: https://rinkeby.etherscan.io/
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

If you want to pipe the log output to another terminal then open 2 terminals. Run ``ps`` in the first terminal and check the number you get. Then run this in the second terminal (where ```X``` is the terminal number you retrieved by the ```ps``` command in the first terminal):
```
get --rinkeby console 2>>/dev/pts/X
```

### Useful geth javascript-console commands

#### Accounts

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

#### Sending Transaction

If you want to send a mony transaction you can do that like this (standard unit for the value is in Wei!):
```
eth.sendTransaction({from: eth.coinbase, to: 'SOME_ADDRESS', value: SOME_VALUE})
```

If you don't want to enter the amount in Wei you can do it in Ether and wrap it like this:
```
eth.sendTransaction({from: eth.coinbase, to: 'SOME_ADDRESS', value: web3.toWei(1)})
```


#### geth RPC

Expose the geth RPC-interface (so it can be accessed by browser-solidity, etc.). Note that ```"web3,net,eth,personal"``` marks the modules that will be exposed. Usually you don't have to expose the ```personal``` module, but since we need it exposed for the DApp presented in the workshop it is part of the string here:
```
admin.startRPC("127.0.0.1", 8545, "*", "web3,net,eth,personal")
```

### remix browser-solidity explained

Browser-solidity is an IDE that allows you to (write, ) compile and deploy solidity code. Note that it does not offer code-complesion - it is a quite simple tool. If you want a better IDE for writing your code you can use the pre-installed sublime-text or you can install the text editor (or IDE) of your choice.

What makes browser-solidity nice, is the possiblity to connect it to your local geth-client (or testrpc) by selecting ```Web3 Provider``` instead of ```JavaScript VM``` in the ```Execution environment``` section of the ```Contract``` tab in browser-solidity's management console.

**IMPORTANT:** 

- Note that the "Value" field (where you enter ether to be sent to the contract upon creation) is not in Wei but in Ether! You can enter floating point numbers there! 
- However, parameters to functions are usually passed in Wei (unless you implement conversion in the contract)! 
- Note that you will have to wrap long numbers passed as parameters with hyphans like this: ```"1000000000000000"```


### "Hello-World" Solidity Contract: The Greeter

One of the most common "Hello-World" examples is the ["Greeter" example offered on the website of the Ethereum foundation](https://www.ethereum.org/greeter)

Here is the code of the Greeter example:
```
contract mortal {
    /* Define variable owner of the type address*/
    address owner;

    /* this function is executed at initialization and sets the owner of the contract */
    function mortal() { owner = msg.sender; }

    /* Function to recover the funds on the contract */
    function kill() { if (msg.sender == owner) selfdestruct(owner); }
}

contract greeter is mortal {
    /* define variable greeting of the type string */
    string greeting;

    /* this runs when the contract is executed */
    function greeter(string _greeting) public {
        greeting = _greeting;
    }

    /* main function */
    function greet() constant returns (string) {
        return greeting;
    }
}
```

**Challange:** Add another function that lets anyone in the network change the greeting.

Here is the adapted example with the additional function that allows anyone to change the greeting:
```
contract mortal {
    /* Define variable owner of the type address*/
    address owner;

    /* this function is executed at initialization and sets the owner of the contract */
    function mortal() { owner = msg.sender; }

    /* Function to recover the funds on the contract */
    function kill() { if (msg.sender == owner) selfdestruct(owner); }
}

contract greeter is mortal {
    /* define variable greeting of the type string */
    string greeting;

    /* this runs when the contract is executed */
    function greeter(string _greeting) public {
        greeting = _greeting;
    }

    /* main function */
    function greet() constant returns (string) {
        return greeting;
    }
    
    function changeGreeting(string _newGreeting) {
        greeting = _newGreeting;
    }
}
```

It is recommended to use browser-solidity to compile the contract. This will give you the following deployment code in the browser-solidity "contract" tab of the management console:
```
var _greeting = /* var of type string here */ ;
var greeterContract = web3.eth.contract([{"constant":false,"inputs":[],"name":"kill","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"greet","outputs":[{"name":"","type":"string"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_newGreeting","type":"string"}],"name":"changeGreeting","outputs":[],"payable":false,"type":"function"},{"inputs":[{"name":"_greeting","type":"string"}],"payable":false,"type":"constructor"}]);
var greeter = greeterContract.new(
   _greeting,
   {
     from: web3.eth.accounts[0], 
     data: '0x6060604052341561000c57fe5b6040516104d13803806104d1833981016040528080518201919050505b5b33600060006101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055505b806001908051906020019061008292919061008a565b505b5061012f565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f106100cb57805160ff19168380011785556100f9565b828001600101855582156100f9579182015b828111156100f85782518255916020019190600101906100dd565b5b509050610106919061010a565b5090565b61012c91905b80821115610128576000816000905550600101610110565b5090565b90565b6103938061013e6000396000f30060606040526000357c0100000000000000000000000000000000000000000000000000000000900463ffffffff16806341c0e1b514610051578063cfae321714610063578063d28c25d4146100fc575bfe5b341561005957fe5b610061610156565b005b341561006b57fe5b6100736101ea565b60405180806020018281038252838181518152602001915080519060200190808383600083146100c2575b8051825260208311156100c25760208201915060208101905060208303925061009e565b505050905090810190601f1680156100ee5780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b341561010457fe5b610154600480803590602001908201803590602001908080601f01602080910402602001604051908101604052809392919081815260200183838082843782019150505050505091905050610293565b005b600060009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff163373ffffffffffffffffffffffffffffffffffffffff1614156101e757600060009054906101000a900473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff16ff5b5b565b6101f26102ae565b60018054600181600116156101000203166002900480601f0160208091040260200160405190810160405280929190818152602001828054600181600116156101000203166002900480156102885780601f1061025d57610100808354040283529160200191610288565b820191906000526020600020905b81548152906001019060200180831161026b57829003601f168201915b505050505090505b90565b80600190805190602001906102a99291906102c2565b505b50565b602060405190810160405280600081525090565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f1061030357805160ff1916838001178555610331565b82800160010185558215610331579182015b82811115610330578251825591602001919060010190610315565b5b50905061033e9190610342565b5090565b61036491905b80821115610360576000816000905550600101610348565b5090565b905600a165627a7a723058206d7215a3c178eae9bf6eed3ccd1b9c81f113d03e42ac30d93d3261d19b5888ca0029', 
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

With ```var greeter = greeterContract.new(...)``` you deploy the bytecode of your contract to the blockchain. This is called a "contract creation". After the contract was mined you can access the contract at the dedicated contract address that you recieved when you triggered the deployment transaction. The instance of the contract will then be held in the ```greeter``` variable.

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
npm run build
```

```
npm run dev
```


### Running the Senacor Smart Contract Lottery

A detailed description can be found in the [SenacorSmartContractLottery's repo](https://github.com/senacor/SmartContractSlackDapp).

Quick-Guide:

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
