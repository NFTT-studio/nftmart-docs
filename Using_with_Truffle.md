# Interacting with NFTMart Using Truffle

## Introduction

This guide walks through the process of deploying a Solidity-based smart
contract to a NFTMart node using [Truffle](https://www.trufflesuite.com/), a
commonly used development tool for smart contracts on Ethereum. Given NFTMart
Ethereum compatibility features, Truffle can be used directly with a NFTMart
node.

## Checking Prerequisites

We need to install Node.js (we'll use v15.x) and the npm package manager. You
can download directly from [Node.js](https://nodejs.org/en/download/) or in your
terminal:

Ubuntu

```
curl -sL https://deb.nodesource.com/setup_15.x | sudo -E bash -

sudo apt install -y nodejs
```

MacOS

```
# You can use homebrew (https://docs.brew.sh/Installation)
brew install node

# Or you can use nvm (https://github.com/nvm-sh/nvm)
nvm install node
```

## Running a Development Node

To set up a NFTMart development node, you can follow tutorial of _Setting Up a
Local NFTMart Node_.

## Deploying a Contract to NFTMart Using Truffle

To use most Truffle commands, you need to run them against an existing Truffle
project. So the first step is to create a Truffle project.

You can create a bare project template, but for those just getting started, you
can use [Truffle Boxes](https://www.trufflesuite.com/boxes), which are example
applications and project templates. We'll use the
[MetaCoin box](https://www.trufflesuite.com/boxes/metacoin), which creates a
token that can be transferred between accounts.

Let's start, follow the steps below.

1.Create a new directory for your Truffle project:

`mkdir -p metacoin; cd metacoin`

2.Download ("unbox") the MetaCoin box:

`truffle unbox metacoin`

Once this operation is completed, you'll now have a project structure with the
following items:

**contracts/**: Directory for Solidity contracts **migrations/**: Directory for
scriptable deployment files **test/**: Directory for test files for testing your
application and contracts **truffle-config.js**: Truffle configuration file

3. Create package.json, then configure the network in the truffle-config.js file
   :

```
$ cat > package.json <<EOF && npm install
{
   "name": "metacoin",
   "version": "1.0.0",
   "dependencies": {
      "@openzeppelin/contracts": "^4.5.0",
      "@truffle/hdwallet-provider": "^1.2.2",
      "truffle": "^5.1.66"
   }
}
EOF
```

```
$ cat > truffle-config.js <<EOF
const HDWalletProvider = require('@truffle/hdwallet-provider');
// NFTMart Node Development Account Gerald
// address: 0x6Be02d1d3665660d22FF9624b7BE0551ee1Ac91b
const privateKeyDev =
   '99B3C12287537E38C90A9219D4CB074A89A16E9CDB20BF85728EBD97C343E342';

module.exports = {
   networks: {
      // Moonbeam Development Network
      development: {
         provider: () => {
            if (!privateKeyDev.trim()) {
               throw new Error(
                  'Please enter a private key with funds, you can use the default one'
               );
            }
            return new HDWalletProvider(
               privateKeyDev,
               'http://localhost:9933/'
            );
         },
         network_id: '*',
      },
   },
   // Solidity 0.5 Compiler
   compilers: {
      solc: {
         version: '^0.5',
      },
   },
   plugins: ['truffle-plugin-verify'],
};
EOF
```

Note that this is slightly different from
[Ganache](https://www.trufflesuite.com/ganache). The **from** parameter must be
configured here. The account `0x19E7E376E7C213B7E7e7e46cc70A5dD086DAff2A` is
pre-funded , and it's corresponding private key is also stored on the node.

Also, you should make sure you have enough token in your account. The Gerald
account comes with enough initial fund for testing purpose.

4.Compile the Truffle project

To compile a Truffle project, change to the root of the directory where the
project is located and then type the following into a terminal:

```
/metacoin $ truffle compile

Compiling your contracts...
===========================
??? Fetching solc version list from solc-bin. Attempt #1
??? Fetching solc version list from solc-bin. Attempt #1
> Compiling ./contracts/ConvertLib.sol
> Compiling ./contracts/MetaCoin.sol
> Compiling ./contracts/Migrations.sol
> Artifacts written to /home/aaron/MetaCoin/build/contracts
> Compiled successfully using:
   - solc: 0.5.17+commit.d19bba13.Emscripten.clang
```

5.Deploy the Truffle project

To deploy the Truffle project, execute `truffle migrate`:

```
/metacoin $ truffle migrate


Compiling your contracts...
===========================
??? Fetching solc version list from solc-bin. Attempt #1
??? Fetching solc version list from solc-bin. Attempt #1
> Everything is up to date, there is nothing to compile.


Starting migrations...
======================
> Network name:    'development'
> Network id:      12191
> Block gas limit: 60000000 (0x3938700)


1_initial_migration.js
======================

   Deploying 'Migrations'
   ----------------------
   > transaction hash:    0x41a30adc57db5c2708b82b71b986649e330c998159f6e4c510bd47bd6da7ec97
   > Blocks: 0            Seconds: 0
   > contract address:    0xDc552396caEc809752fED0c5E23fd3983766e758
   > block number:        249
   > block timestamp:     1649757912
   > account:             0x6Be02d1d3665660d22FF9624b7BE0551ee1Ac91b
   > balance:             9998032.3222110515
   > gas used:            165475 (0x28663)
   > gas price:           2.5000045 gwei
   > value sent:          0 ETH
   > total cost:          0.0004136882446375 ETH

   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:     0.0004136882446375 ETH


2_deploy_contracts.js
=====================

   Deploying 'ConvertLib'
   ----------------------
   > transaction hash:    0x35c2f3deb276f8786dc87fd616ac753f18c2e1fab8a469f3037c803d6794e7b6
   > Blocks: 0            Seconds: 4
   > contract address:    0xD81C7319c85fcd6e1F0893b3988BeBab6247Adbc
   > block number:        251
   > block timestamp:     1649757924
   > account:             0x6Be02d1d3665660d22FF9624b7BE0551ee1Ac91b
   > balance:             9997679.324075656
   > gas used:            95458 (0x174e2)
   > gas price:           2.5000045 gwei
   > value sent:          0 ETH
   > total cost:          0.000238645429561 ETH


   Linking
   -------
   * Contract: MetaCoin <--> Library: ConvertLib (at address: 0xD81C7319c85fcd6e1F0893b3988BeBab6247Adbc)

   Deploying 'MetaCoin'
   --------------------
   > transaction hash:    0x647a7b72ecb4a6da9f2af6ce5f6e4f1ac74f408f674bb78fbaf70aa6564795bc
   > Blocks: 0            Seconds: 4
   > contract address:    0x596fB37d99bd679d1af76fBCB658f7a1a31A1205
   > block number:        252
   > block timestamp:     1649757930
   > account:             0x6Be02d1d3665660d22FF9624b7BE0551ee1Ac91b
   > balance:             9996957.6602766635
   > gas used:            288665 (0x46799)
   > gas price:           2.5000045 gwei
   > value sent:          0 ETH
   > total cost:          0.0007216637989925 ETH

   > Saving migration to chain.
   > Saving artifacts
   -------------------------------------
   > Total cost:     0.0009603092285535 ETH

Summary
=======
> Total deployments:   3
> Final cost:          0.001373997473191 ETH
```

6.Interacting with your contracts

Contract abstractions are the bread and butter of interacting with Ethereum
contracts from Javascript. In short, contract abstractions are wrapper code that
makes interaction with your contracts easy, in a way that lets you forget about
the many engines and gears executing under the hood. Truffle uses its own
contract abstraction via the
[@truffle/contract](https://github.com/trufflesuite/truffle/tree/master/packages/contract)
module, and it is this contract abstraction that's described below.

```solidity
pragma solidity >=0.4.25 <0.6.0;

import "./ConvertLib.sol";

// This is just a simple example of a coin-like contract.
// It is not standards compatible and cannot be expected to talk to other
// coin/token contracts. If you want to create a standards-compliant
// token, see: https://github.com/ConsenSys/Tokens. Cheers!

contract MetaCoin {
    mapping (address => uint) balances;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    constructor() public {
        balances[tx.origin] = 10000;
    }

    function sendCoin(address receiver, uint amount) public returns(bool sufficient) {
        if (balances[msg.sender] < amount) return false;
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Transfer(msg.sender, receiver, amount);
        return true;
    }

    function getBalanceInEth(address addr) public view returns(uint){
        return ConvertLib.convert(getBalance(addr),2);
    }

    function getBalance(address addr) public view returns(uint) {
        return balances[addr];
    }
}
```

Now, let's look at the Javascript object called `MetaCoin` provided for us by
Truffle, as made available in the
[Truffle console](https://www.trufflesuite.com/docs/truffle/getting-started/using-truffle-develop-and-the-console):

```
truffle(development)> let instance = await MetaCoin.deployed()
truffle(development)> instance


   ...

    methods: {
      sendCoin: [Function: bound _createTxObject],
      '0x90b98a11': [Function: bound _createTxObject],
      'sendCoin(address,uint256)': [Function: bound _createTxObject],
      getBalanceInEth: [Function: bound _createTxObject],
      '0x7bd703e8': [Function: bound _createTxObject],
      'getBalanceInEth(address)': [Function: bound _createTxObject],
      getBalance: [Function: bound _createTxObject],
      '0xf8b2cb4f': [Function: bound _createTxObject],
      'getBalance(address)': [Function: bound _createTxObject]
    },
    events: {
      Transfer: [Function: bound ],
      '0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef': [Function: bound ],
      'Transfer(address,address,uint256)': [Function: bound ],
      allEvents: [Function: bound ]
    },
    _address: '0x08425D9Df219f93d5763c3e85204cb5B4cE33aAa',

        
 ...
```

Making a transaction:

There are three functions on the MetaCoin contract that we can execute. If you
analyze each of them, you'll see that `sendCoin` is the only function that aims
to make changes to the network. The goal of `sendCoin` is to "send" some Meta
coins from one account to the next, and these changes should persist.

When calling `sendCoin`, we'll execute it as a transaction. In the following
example, we'll send 10 Meta coin from one account to another, in a way that
persists changes on the network:

```
truffle(development)> let accounts = await web3.eth.getAccounts()
undefined
truffle(development)> instance.sendCoin("0x6Be02d1d3665660d22FF9624b7BE0551ee1Ac91b", 10, {from: accounts[0]})
{
  tx: '0xf080c9d277f78bb29cb5a5619c1c5f4bdc79e426d0fb3f7d259928fe973384dc',
  receipt: {
    blockHash: '0x02aae907afd086a36d0b3f417fd3b205b9c1c757a72b2e20da83666d2e36e9cb',
    blockNumber: 40,
    contractAddress: null,
    cumulativeGasUsed: 47308,
    from: '0x19e7e376e7c213b7e7e7e46cc70a5dd086daff2a',
    gasUsed: 47308,
    logs: [ [Object] ],
    logsBloom: '0x80000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008000000000000800000000000000000000000000000000000000000000000000000000020000000000000000000000010000000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000002000000000000000020000800000000000000002000000000000000000000000000000000000000000000000000000000000000000000000000000000004000000000008000000000000000000000000',
    status: true,
    to: '0x08425d9df219f93d5763c3e85204cb5b4ce33aaa',
    transactionHash: '0xf080c9d277f78bb29cb5a5619c1c5f4bdc79e426d0fb3f7d259928fe973384dc',
    transactionIndex: 0,
    rawLogs: [ [Object] ]
  },
  logs: [
    {
      address: '0x08425D9Df219f93d5763c3e85204cb5B4cE33aAa',
      blockHash: '0x02aae907afd086a36d0b3f417fd3b205b9c1c757a72b2e20da83666d2e36e9cb',
      blockNumber: 40,
      logIndex: 0,
      removed: false,
      transactionHash: '0xf080c9d277f78bb29cb5a5619c1c5f4bdc79e426d0fb3f7d259928fe973384dc',
      transactionIndex: 0,
      transactionLogIndex: '0x0',
      id: 'log_1a8b84e8',
      event: 'Transfer',
      args: [Result]
    }
  ]
}
```

Making a call:

Continuing with MetaCoin, notice the `getBalance` function is a great candidate
for reading data from the network. It doesn't need to make any changes, as it
just returns the MetaCoin balance of the address passed to it. Let's give it a
shot:

```
truffle(development)> let balance = await instance.getBalance(accounts[0])
undefined
truffle(development)>  balance.toNumber()
9990
```
