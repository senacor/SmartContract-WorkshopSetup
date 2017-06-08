#!/usr/bin/env bash

# IMORTANT you have to check the right version before running this!
# For the future: add some kind of parser for this... (the install via npm somehow does not work...)
BROWSERSOLIDITYVERSION='9dda96a'

# install curl and git
sudo apt-get update
sudo apt-get install -y curl git

# install geth (Ethereum-Go, Command-Line client)
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt-get update
sudo apt-get install -y geth

# install NodeJs
# source: https://nodejs.org/en/download/package-manager/
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get update
sudo apt-get install -y nodejs
sudo apt-get install -y npm

# truffle framework
sudo npm install -g truffle

# install testrpc
sudo npm install -g ethereumjs-testrpc

# install browser solidity locally to have a stable offline environment
mkdir browser-solidity
cd browser-solidity
wget 'https://github.com/ethereum/browser-solidity/raw/gh-pages/remix-'"$BROWSERSOLIDITYVERSION"'.zip'
unzip remix-"$BROWSERSOLIDITYVERSION".zip
rm remix-"$BROWSERSOLIDITYVERSION".zip

