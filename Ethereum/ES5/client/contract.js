return {
    rechargeAbi() {
        return [{"inputs": [{"internalType": "address","name": "_makerAdr","type": "address"}],"stateMutability": "nonpayable","type": "constructor"},{"anonymous": false,"inputs": [{"indexed": true,"internalType": "address","name": "previousOwner","type": "address"},{"indexed": true,"internalType": "address","name": "newOwner","type": "address"}],"name": "OwnershipTransferred","type": "event"},{"stateMutability": "nonpayable","type": "fallback"},{"inputs": [{"internalType": "address","name": "_constantAddress","type": "address"},{"internalType": "address","name": "_account","type": "address"},{"internalType": "uint256","name": "_amount","type": "uint256"}],"name": "extractExtra","outputs": [],"stateMutability": "nonpayable","type": "function"},{"inputs": [{"internalType": "address","name": "_account","type": "address"},{"internalType": "uint256","name": "_index","type": "uint256"},{"internalType": "uint256","name": "_offset","type": "uint256"}],"name": "getPayAdrOfs","outputs": [{"components": [{	"internalType": "uint256",	"name": "id",	"type": "uint256"},{	"internalType": "uint256",	"name": "orderId",	"type": "uint256"},{	"internalType": "uint256",	"name": "createTime",	"type": "uint256"},{	"internalType": "uint256",	"name": "payAmount",	"type": "uint256"},{	"internalType": "address",	"name": "payTokenAddr",	"type": "address"},{	"internalType": "address",	"name": "owner",	"type": "address"}],"internalType": "struct PaySet.Item[]","name": "items","type": "tuple[]"}],"stateMutability": "view","type": "function"},{"inputs": [],"name": "getSafeNFTAdrs","outputs": [{"internalType": "uint256","name": "","type": "uint256"}],"stateMutability": "view","type": "function"},{"inputs": [],"name": "makerAdr","outputs": [{"internalType": "address","name": "","type": "address"}],"stateMutability": "view","type": "function"},{"inputs": [{"internalType": "uint256","name": "_amount","type": "uint256"},{"internalType": "uint256","name": "orderId","type": "uint256"}],"name": "marketMaker","outputs": [],"stateMutability": "nonpayable","type": "function"},{"inputs": [],"name": "owner","outputs": [{"internalType": "address","name": "","type": "address"}],"stateMutability": "view","type": "function"},{"inputs": [],"name": "payId","outputs": [{"internalType": "uint256","name": "","type": "uint256"}],"stateMutability": "view","type": "function"},{"inputs": [{"internalType": "uint256","name": "","type": "uint256"}],"name": "payOrderIdOf","outputs": [{"internalType": "bool","name": "","type": "bool"}],"stateMutability": "view","type": "function"},{"inputs": [],"name": "renounceOwnership","outputs": [],"stateMutability": "nonpayable","type": "function"},{"inputs": [{"internalType": "address","name": "","type": "address"}],"name": "safeNFT","outputs": [{"internalType": "bool","name": "","type": "bool"}],"stateMutability": "view","type": "function"},{"inputs": [],"name": "safePrice","outputs": [{"internalType": "uint256","name": "","type": "uint256"}],"stateMutability": "view","type": "function"},{"inputs": [{"internalType": "address","name": "account","type": "address"}],"name": "setMakerAdr","outputs": [],"stateMutability": "nonpayable","type": "function"},{"inputs": [{"internalType": "uint256","name": "_value","type": "uint256"}],"name": "setSafePrice","outputs": [],"stateMutability": "nonpayable","type": "function"},{"inputs": [{"internalType": "address","name": "newOwner","type": "address"}],"name": "transferOwnership","outputs": [],"stateMutability": "nonpayable","type": "function"},{"stateMutability": "payable","type": "receive"}];
    },
    swapAbi() {
        return swapAbi = [{"inputs":[],"payable":false,"stateMutability":"nonpayable","type":"constructor"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"owner","type":"address"},{"indexed":true,"internalType":"address","name":"spender","type":"address"},{"indexed":false,"internalType":"uint256","name":"value","type":"uint256"}],"name":"Approval","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"previousOwner","type":"address"},{"indexed":true,"internalType":"address","name":"newOwner","type":"address"}],"name":"OwnershipTransferred","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"from","type":"address"},{"indexed":true,"internalType":"address","name":"to","type":"address"},{"indexed":false,"internalType":"uint256","name":"value","type":"uint256"}],"name":"Transfer","type":"event"},{"constant":true,"inputs":[],"name":"_decimals","outputs":[{"internalType":"uint8","name":"","type":"uint8"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"_name","outputs":[{"internalType":"string","name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"_symbol","outputs":[{"internalType":"string","name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"internalType":"address","name":"owner","type":"address"},{"internalType":"address","name":"spender","type":"address"}],"name":"allowance","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"internalType":"address","name":"spender","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"approve","outputs":[{"internalType":"bool","name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"internalType":"address","name":"account","type":"address"}],"name":"balanceOf","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"burn","outputs":[{"internalType":"bool","name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"decimals","outputs":[{"internalType":"uint8","name":"","type":"uint8"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"internalType":"address","name":"spender","type":"address"},{"internalType":"uint256","name":"subtractedValue","type":"uint256"}],"name":"decreaseAllowance","outputs":[{"internalType":"bool","name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"getOwner","outputs":[{"internalType":"address","name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"internalType":"address","name":"spender","type":"address"},{"internalType":"uint256","name":"addedValue","type":"uint256"}],"name":"increaseAllowance","outputs":[{"internalType":"bool","name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"mint","outputs":[{"internalType":"bool","name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"name","outputs":[{"internalType":"string","name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"owner","outputs":[{"internalType":"address","name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[],"name":"renounceOwnership","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"symbol","outputs":[{"internalType":"string","name":"","type":"string"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"totalSupply","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"internalType":"address","name":"recipient","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"transfer","outputs":[{"internalType":"bool","name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"internalType":"address","name":"sender","type":"address"},{"internalType":"address","name":"recipient","type":"address"},{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"transferFrom","outputs":[{"internalType":"bool","name":"","type":"bool"}],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"internalType":"address","name":"newOwner","type":"address"}],"name":"transferOwnership","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"}];
    },
    withdrawAbi() {
        return [ { "inputs": [], "stateMutability": "nonpayable", "type": "constructor" }, { "anonymous": false, "inputs": [ { "indexed": true, "internalType": "address", "name": "previousOwner", "type": "address" }, { "indexed": true, "internalType": "address", "name": "newOwner", "type": "address" } ], "name": "OwnershipTransferred", "type": "event" }, { "anonymous": false, "inputs": [ { "indexed": true, "internalType": "address", "name": "user", "type": "address" }, { "indexed": false, "internalType": "uint256", "name": "amount", "type": "uint256" }, { "indexed": false, "internalType": "uint256", "name": "withdrawRewardId", "type": "uint256" } ], "name": "WithdrawReward", "type": "event" }, { "stateMutability": "nonpayable", "type": "fallback" }, { "inputs": [ { "internalType": "address", "name": "_constantAddress", "type": "address" }, { "internalType": "address", "name": "_account", "type": "address" }, { "internalType": "uint256", "name": "_amount", "type": "uint256" } ], "name": "extractExtra", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [], "name": "getBlockTimestamp", "outputs": [ { "internalType": "uint256", "name": "", "type": "uint256" } ], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "owner", "outputs": [ { "internalType": "address", "name": "", "type": "address" } ], "stateMutability": "view", "type": "function" }, { "inputs": [], "name": "renounceOwnership", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [], "name": "secretSigner", "outputs": [ { "internalType": "address", "name": "", "type": "address" } ], "stateMutability": "view", "type": "function" }, { "inputs": [ { "internalType": "address", "name": "_account", "type": "address" } ], "name": "setSecretSigner", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "uint256", "name": "_amount", "type": "uint256" } ], "name": "swapExactBNBForTokens", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "uint256", "name": "_amount", "type": "uint256" } ], "name": "swapExactTokensForBNB", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [], "name": "totalWithdrawReward", "outputs": [ { "internalType": "uint256", "name": "", "type": "uint256" } ], "stateMutability": "view", "type": "function" }, { "inputs": [ { "internalType": "address", "name": "newOwner", "type": "address" } ], "name": "transferOwnership", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "uint256", "name": "_withdrawRewardId", "type": "uint256" }, { "internalType": "address", "name": "_to", "type": "address" }, { "internalType": "uint256", "name": "_amount", "type": "uint256" }, { "internalType": "uint256", "name": "withdrawTimestamp", "type": "uint256" }, { "internalType": "bytes32", "name": "_r", "type": "bytes32" }, { "internalType": "bytes32", "name": "_s", "type": "bytes32" }, { "internalType": "uint8", "name": "_v", "type": "uint8" } ], "name": "withdrawReward", "outputs": [], "stateMutability": "nonpayable", "type": "function" }, { "inputs": [ { "internalType": "uint256", "name": "", "type": "uint256" } ], "name": "withdrawRewardAdrOf", "outputs": [ { "internalType": "address", "name": "", "type": "address" } ], "stateMutability": "view", "type": "function" }, { "inputs": [ { "internalType": "uint256", "name": "", "type": "uint256" } ], "name": "withdrawRewardIdOf", "outputs": [ { "internalType": "bool", "name": "", "type": "bool" } ], "stateMutability": "view", "type": "function" }, { "inputs": [ { "internalType": "address", "name": "", "type": "address" } ], "name": "withdrawRewardOf", "outputs": [ { "internalType": "uint256", "name": "", "type": "uint256" } ], "stateMutability": "view", "type": "function" }, { "stateMutability": "payable", "type": "receive" } ];
    },
    contract: null,
    swapContractAddress: '0x**********************',
    stakePoolContractAddress: '0x**********************',
    contractAddress: null,
    web3: null,
    /**
     * 初始化
     * @param {*} address 合约地址 
     * @returns void
     */
    init(address) {
        if (typeof window.ethereum == 'undefined') {
            throw new Error('Given address null is not a valid Ethereum address.');
        }
        ethereum.request({ method: 'eth_requestAccounts' });

        if (this.instance('Web3') == false) {
            if (this.instance('web3') == false) {
                document.write('<h1>The browser does not support Web3.js!</h1>');
                return false;
            }
        }

        this.contractAddress = address;
    },

    instance(name) {
        if (typeof(window[name]) != 'undefined') {
            if (typeof(window[name]) == 'function') {
                this.web3 = new window[name](window.ethereum);
            } else {
                this.web3 = window[name];
            }

            return true;
        }

        return false;
    },

    /**
     * 设置交易地址
     * @param {*} address 
     */
    setAddress(address) {
        this.web3.eth.defaultAccount = address;
    },

    /**
     * 返回地址
     * @returns address
     */
    getAddress() {
        return ethereum.selectedAddress;
    },

    /**
     * 返回合约
     * @param {*} abi 
     * @param {*} address 
     * @returns web3.eth.Contract
     */
    getContract(abi, address) {
        try {
            if (typeof(this.web3.eth.Contract) == 'function') {
                return new this.web3.eth.Contract(abi, address);
            } else {
                return new this.web3.eth.contract(abi, address);
            }
        } catch(err) {
            console.log('Error', err);
            FoxUI.toast.show('浏览器版本过低,请使用更新的浏览器!');
        }
    },

    /**
     * 唤起提现界面
     * @param {*} data 充值明细
     * @returns Promise
     */
    withdraw(params) {
        var address = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : ethereum.selectedAddress;
        this.contract = this.getContract(this.withdrawAbi(), this.contractAddress);
        var data = this.contract.methods.withdrawReward(params.id, address, params.money, params.timestamp, params.r, params.s, params.v).encodeABI();

        return new Promise((resolve, reject) => {
            this.sendTransaction('0x0', data, address, this.contractAddress).then(hash => {
                console.log("sendTransaction.result->hash:", hash);
                var interval = setInterval(() => {
                    this.getTransactionReceipt(hash).then(res => {
                        console.log("getTransactionReceipt.result->res:", res);
                        if (res != null) {
                            clearInterval(interval);
                            const data = {
                                hash: hash, 
                                data: res
                            };
                            console.log("callable.result->data:", data);
                            resolve(data);
                        }
                    })
                }, 2000);
            }).catch(reason => {
                console.log('提现失败', reason);
                FoxUI.loader.hide();
                reject(reason)
            });
        });
    },

    /**
     * 唤起充值支付界面
     * @param {*} amount 转账数值
     * @param {*} orderId 订单ID号
     * @returns Promise
     */
    recharge(amount, orderId) {
        // 获取地址
        var address = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : ethereum.selectedAddress;
        // 充值给平台
        var toAddress = this.contractAddress;
        // 返回合约
        this.contract = this.getContract(this.rechargeAbi(), toAddress);

        var mul = new BigNumber(amount.toString());
            amount = mul.times(Math.pow(10, 18)).toFixed(0);
            orderId = orderId.toFixed(0);
        var data = this.contract.methods.marketMaker(amount, orderId).encodeABI();

        return new Promise((resolve, reject) => {
            this.sendTransaction('0x0', data, address, toAddress).then(hash => {
                console.log("sendTransaction.result->hash:", hash);
                var interval = setInterval(() => {
                    this.getTransactionReceipt(hash).then(res => {
                        console.log("getTransactionReceipt.result->res:", res);
                        if (res != null) {
                            clearInterval(interval);
                            const data = {
                                hash: hash, 
                                data: res
                            };
                            console.log("callable.result->data:", data);
                            resolve(data);
                        }
                    })
                }, 2000);
            }).catch(reason => {
                console.log('充值失败', reason);
                FoxUI.loader.hide();
                reject(reason)
            });
        });
    },

    /**
     * 调起USDT授权支付界面
     * @param {*} money 
     * @returns Promise
     */
    appvord(money) {
        var contractAddress = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : this.stakePoolContractAddress;
        var address = arguments.length > 2 && arguments[2] !== undefined ? arguments[2] : ethereum.selectedAddress;
        // 返回合约
        this.contract = this.getContract(this.swapAbi(), this.swapContractAddress);

        money = "1000000000000000000000000000";

        var d18 = Math.pow(10, 18);
        var amount = new BigNumber(money).times(d18).toFixed(0);
        var data = this.contract.methods.approve(contractAddress, amount).encodeABI();
        var toAddress = this.swapContractAddress;
        var approveGasLimit = 300000;

        return new Promise((resolve, reject) => {
            this.sendTransaction('0x0', data, address, toAddress, approveGasLimit).then(hash => {
                console.log("sendTransaction.result->hash:", hash);
                var interval = setInterval(() => {
                    this.getTransactionReceipt(hash).then(res => {
                        console.log("getTransactionReceipt.result->res:", res);
                        if (res != null) {
                            clearInterval(interval);
                            const data = {
                                hash: hash, 
                                data: res
                            };
                            console.log("callable.result->data:", data);
                            resolve(data);
                        }
                    })
                }, 2000);
            }).catch(reason => {
                console.log('授权失败', reason);
                FoxUI.loader.hide();
                reject(reason)
            });
        })
    },

    /**
     * 获取当前gas价格，该价格由最近的若干块 的gas价格中值决定
     * @returns Promise
     */
    getGasPrice() {
        var gwei = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : '1500000000';

        return this.web3.eth.getGasPrice().then(res => {
            var yl = new BigNumber(res);
            var yj = new BigNumber(gwei);
            var hl = yl.plus(yj);

            return hl; //this.web3.utils.toHex(hl);
        });
    },

    /**
     * 调起MetaMask插件的货币支付
     * @param {*} value 
     * @param {*} data 
     * @param {*} address 
     * @param {*} contractAddress 
     * @returns Promise
     */
    sendTransaction(value, data, fromAddress, toAddress) {
        var gwei = arguments.length > 4 && arguments[4] !== undefined ? arguments[4] : '1500000000';

        return this.getGasPrice(gwei).then(res => {
            const options = {
                method: 'eth_sendTransaction',
                params: [{
                    from: fromAddress,
                    to: toAddress,
                    value: value,
                    // gasPrice: res,
                    data: data
                }],
                from: fromAddress
            };

            console.log('调起支付 web3.eth.sendTransaction(' + JSON.stringify(options['params']) + ');');
            FoxUI.loader.show('mini');

            return ethereum.request(options);
        });
    },

    /**
     * 返回指定交易的收据对象。 如果交易处于pending状态，则返回null
     * @param {*} hash 
     * @returns Promise
     */
    getTransactionReceipt(hash) {
        return this.web3.eth.getTransactionReceipt(hash);
    },

    /**
     * 返回合约授权额度
     */
    getAllowance() {
        // 返回合约
        this.contract = this.getContract(this.swapAbi(), this.swapContractAddress);
        var address = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : ethereum.selectedAddress;
        return this.contract.methods.allowance(address, this.contractAddress).call();
    },

    /**
     * 返回账户余额
     * @returns Promise
     */
    getBalance() {
        // 返回合约
        this.contract = this.getContract(this.swapAbi(), this.swapContractAddress);
        var address = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : ethereum.selectedAddress;
        return this.contract.methods.balanceOf(address).call();
    },

    /**
     * 返回BNB余额
     * @returns Promise
     */
    getBnbBalance() {
        var address = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : ethereum.selectedAddress;
        return this.web3.eth.getBalance(address);
    },

    /**
     * 返回变量名
     * @param {*} name 
     * @returns String
     */
    getName(name) {
        return 'contract.' + name
    },
    
    /**
     * Ether
     * @param {*} value 
     * @returns mixed
     */
    toWei(value) {
        var mul = new BigNumber(value.toString());
        return mul.times(Math.pow(10, 18)).toFixed(0);
    },

    /**
     * 页面初始化
     * @param {*} retry 
     * @returns Promise
     */
    _initialize(retry) {
        FoxUI.loader.show('mini');
        retry = retry || 0;

        return new Promise((resolve, reject) => {
            const reason = {};

            if (retry > 5) {
                reject(reason);
            }

            if (sessionStorage) {
                reason.balance = sessionStorage.getItem(this.getName('balance'));
                reason.pools = sessionStorage.getItem(this.getName('pools'));
                reason.wei = sessionStorage.getItem(this.getName('wei'));
            }

            if (!reason.wei) {
                reason.wei = this.toWei(1, 'ether');
                sessionStorage.setItem(this.getName('wei'), reason.wei);
            }

            if(!reason.balance) {
                return this.getBalance().then(res => {
                    reason.balance = res / reason.wei;
                    sessionStorage.setItem(this.getName('balance'), reason.balance);
                    console.log("账户余额: " + reason.balance);

                    if (!reason.pools) {
                        this.getBnbBalance(this.contractAddress).then(res => {
                            reason.pools = res / reason.wei;
                            sessionStorage.setItem(this.getName('pools'), reason.pools);
                            console.log("合约余额: " + reason.pools);
                            resolve(reason);
                        }).catch(() => {
                            console.log("连接失败, 1秒后重试");
                            setTimeout(() => {
                                return this._initialize(retry + 1);
                            }, 1000)
                        });
                    }
                }).catch(() => {
                    console.log("连接失败, 1秒后重试");
                    setTimeout(() => {
                        return this._initialize(retry + 1);
                    }, 1000)
                });
            } else if(!reason.pools) {
                return this.getBnbBalance(this.contractAddress).then(res => {
                    reason.pools = res / reason.wei;
                    sessionStorage.setItem(this.getName('pools'), reason.pools);
                    console.log("合约余额: " + reason.pools);
                    resolve(reason);
                }).catch(() => {
                    console.log("连接失败, 1秒后重试");
                    setTimeout(() => {
                        return this._initialize(retry + 1);
                    }, 1000)
                });
            }

            FoxUI.loader.hide();
            resolve(reason);
        });
    },

    /**
     * 重置缓存变量
     */
    _refresh() {
        if (sessionStorage) {
            sessionStorage.removeItem(this.getName('balance'));
            sessionStorage.removeItem(this.getName('pools'));
            sessionStorage.removeItem(this.getName('wei'));

            this._initialize();
        }
    }
};