// 调用Node.js提供的http模块
var http = require('http');
var url = require('url');
var Web3 = require('web3');

// 创建人
var rootAddress = '0x';
var rootPassphrase = '';
// 提现合约地址
var withdrawAddress = '';
// 签名用户私钥
var privateKey = "";
// 引入WEB3对象
// https://mainnet.infura.io/v3/*******
var web3 = new Web3('https://bsc-dataseed1.defibit.io:443');
// 签名方法
var extension = {
     response: null,
     request: null,
     get: null,
     /**
      * 初始化
      * @param {*} response 
      */
     init(req, response) {
          this.response = response;
          this.request = req;
          this.get = url.parse(req.url, true).query;

          var pathname = url.parse(req.url).pathname.split('/');
          var std = null;
          if (pathname[0] == '') pathname.shift();

          this.response.writeHead(200, {'Content-Type' : 'application/json'});

          pathname.forEach(v => {
               console.log(v);
               if (std == null) {
                    if (typeof this[v] != 'undefined') {
                         std = this[v]
                    } else {
                         this.error('Not Found!', 404);
                    }
               } else {
                    if (typeof std[v] != 'undefined') {
                         std = std[v];
                    } else {
                         this.error('Not Found!', 404);
                    }
               }
          });

          console.log(std, pathname);

          if (std != null) {
               std.call(this, this.get);
          }
     },
     /**
      * 返回签名信息
      * @param {*} orderId 
      * @param {*} address 
      * @param {*} money 
      * @param {*} timestamp 
      * @returns json
      */
     signature(orderId, address, money, timestamp) {
          var _byte = web3.utils.encodePacked(orderId, address, money, timestamp);
          var _hash = web3.utils.sha3(_byte);
          var _sign = web3.eth.accounts.sign(_hash, privateKey);

          return _sign;
     },
     /**
      * 提现合约ABI
      * @returns abi
      */
     withdrawAbi() {
          return [ { "inputs": [], "stateMutability": "nonpayable", "type": "constructor" }, { "anonymous": false, "inputs": [ { "indexed": true, "internalType": "address", "name": "previousOwner", "type": "address" }, { "indexed": true, "internalType": "address", "name": "newOwner", "type": "address" } ], "name": "OwnershipTransferred", "type": "event" }, { "anonymous": false, "inputs": [ { "indexed": true, "internalType": "address", "name": "user", "type": "address" }, { "indexed": false, "internalType": "uint256", "name": "amount", "type": "uint256" }, { "indexed": false, "internalType": "uint256", "name": "withdrawRewardId", "type": "uint256" } ], "name": "WithdrawReward", "type": "event" }, { "stateMutability": "nonpayable", "type": "fallback" }, { "inputs": [ { "internalType": "address", "name": "_constantAddress", "type": "address" }, { "internalType": "address", "name": "_account", "type": "address" }, { "internalType": "uint256", "name": "_amount", "type": "uint256" } ], "name": "extractExtra", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [], "name": "getBlockTimestamp", "outputs": [ { "internalType": "uint256", "name": "", "type": "uint256" } ], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "owner", "outputs": [ { "internalType": "address", "name": "", "type": "address" } ], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "renounceOwnership", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [], "name": "secretSigner", "outputs": [ { "internalType": "address", "name": "", "type": "address" } ], "stateMutability": "view", "type": "function" }, { "inputs": [ { "internalType": "address", "name": "_account", "type": "address" } ], "name": "setSecretSigner", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "uint256", "name": "_amount", "type": "uint256" } ], "name": "swapExactBNBForTokens", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "uint256", "name": "_amount", "type": "uint256" } ], "name": "swapExactTokensForBNB", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [], "name": "totalWithdrawReward", "outputs": [ { "internalType": "uint256", "name": "", "type": "uint256" } ], "stateMutability": "view", "type": "function" }, { "inputs": [ { "internalType": "address", "name": "newOwner", "type": "address" } ], "name": "transferOwnership", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "uint256", "name": "_withdrawRewardId", "type": "uint256" }, { "internalType": "address", "name": "_to", "type": "address" }, { "internalType": "uint256", "name": "_amount", "type": "uint256" }, { "internalType": "uint256", "name": "withdrawTimestamp", "type": "uint256" }, { "internalType": "bytes32", "name": "_r", "type": "bytes32" }, { "internalType": "bytes32", "name": "_s", "type": "bytes32" }, { "internalType": "uint8", "name": "_v", "type": "uint8" } ], "name": "withdrawReward", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "uint256", "name": "", "type": "uint256" } ], "name": "withdrawRewardAdrOf", "outputs": [ { "internalType": "address", "name": "", "type": "address" } ], "stateMutability": "view", "type": "function" }, { "inputs": [ { "internalType": "uint256", "name": "", "type": "uint256" } ], "name": "withdrawRewardIdOf", "outputs": [ { "internalType": "bool", "name": "", "type": "bool" } ], "stateMutability": "view", "type": "function" }, { "inputs": [ { "internalType": "address", "name": "", "type": "address" } ], "name": "withdrawRewardOf", "outputs": [ { "internalType": "uint256", "name": "", "type": "uint256" } ], "stateMutability": "view", "type": "function" }, { "stateMutability": "payable", "type": "receive" } ];
     },
     /**
      * 输出错误
      * @param {*} errMsg 
      * @param {*} code 
      */
     error(errMsg, code) {
          code = code || 0;
          this.response.write(JSON.stringify({"code": 0, "msg": errMsg, "data": null}));
          this.response.end();
     },
     /**
      * 输出成功
      * @param {*} data 
      */
     success(data) {
          this.response.write(JSON.stringify({"code": 1, "msg": 'success', "data": data}));
          this.response.end();
     },
     api: {
          infinity1() {
               web3.eth.personal.unlockAccount(rootAddress, rootPassphrase).then(res => {
                    console.log('personal.lockAccount', res);
                    web3.eth.personal.getAccounts(res => {
                         this.success(res);
                    });
               });
               // var contract = web3.eth.contract(this.withdrawAbi(), withdrawAddress);
          },
          sign(data) {
               try {
                    if (typeof data['id'] == 'undefined') {
                         this.error("参数错误：ID不能为空");
                    } else if(typeof data['address'] == 'undefined') {
                         this.error("参数错误：发送地址不能为空");
                    } else if(typeof data['money'] == 'undefined') {
                         this.error("参数错误：金额不能为空");
                    } else if(typeof data['timestamp'] == 'undefined') {
                         this.error("参数错误：时间戳不能为空");
                    }

                    var res = this.signature(data['id'], data['address'], data['money'], data['timestamp']);

                    this.success(res);
               } catch(e) {
                    this.error("签名错误:" + e);
               }
          }
     }
};

http.createServer( function (req, res) {
     extension.init(req, res);
     res.end();
}).listen(3000);

console.log("HTTP Server is listening at port 3000");