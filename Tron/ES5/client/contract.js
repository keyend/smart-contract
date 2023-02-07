return {
    _: null,
    _data : {},
    _readyStateId: 0,
    contracts: {
        swap: {
            address: ''
        },
        usdt: {
            address: ''
        },
        token: {
            address: ''
        },
    },

    /**
     * 初始化
     * @returns void
     */
    init(params) {
        if (typeof window.tronWeb == 'undefined') {
            throw new Error('Given address null is not a valid tronWeb address.');
        }

        this._ = window.tronWeb;

        if (params != undefined && !params.issue) {
            this.install();
        }
    },

    update(data) {
        console.log(data);
    },

    /**
     * Install
     * @returns void
     */
    install() {
        var maps = {token: ['issue','name','symbol','totalSupply'], swap: ['unitprice','liquidity','slip','amplitude']};
        var result = {};

        Object.keys(maps).map(key => {
            maps[key].forEach(value => {
                this.getAttr(key, value).then(() => {
                    result[value] = this.data(value);

                    if (value == 'issue') {
                        result[value] = this._.address.fromHex(result[value]);
                    } else if(value == 'totalSupply') {
                        result[value] = this.toDecimal(result[value]);
                    } else if(typeof(result[value]) != 'string') {
                        result[value] = result[value].toString();
                    }

                    if (this._readyStateId == 0) {
                        this.update(result);
                    }
                })
            })
        });
    },

    /**
     * 返回精度
     * @returns int8
     */
    decimals() {
        return 6;
    },

    /**
     * 返回单位长度
     * @returns int8
     */
    place() {
        return Math.pow(10, this.decimals());
    },

    /**
     * 返回地址
     * @returns address
     */
    getAddress() {
        return this._.defaultAddress.base58;
    },

    /**
     * 转换值为十进制
     * @param {*} value 
     */
    toDecimal(value) {
        return value.toString() / this.place();
    },

    /**
     * 设置返回值
     * @param {*} name 
     * @param {*} value 
     */
    data(name, value) {
        if (undefined == value) {
            if (!this._data.hasOwnProperty(name)) {
                return null;
            }

            return this._data[name];
        }

        this._data[name] = value;
    },

    /**
     * 返回合约操作
     * @param {*} name 
     */
    async trigger(name, fn) {
        let contract = await this._.contract().at(this.contracts[name].address), value;
        if(arguments.length > 3) {
            value = await contract[fn](...arguments[2]).send(arguments[3]);
        } else if (arguments.length > 2) {
            value = await contract[fn](...arguments[2]).call();
        } else {
            value = await contract[fn]().call();
        }

        return value;
    },

    /**
     * 返回发行数据
     * @returns integer
     */
    getAttr(contractName, name) {
        this._readyStateId += 1;
        return new Promise((resolve, reject) => {
            this.trigger(contractName, name).then(value => {
                this._readyStateId -= 1;
                this.data(name, value);
                resolve(value);
            }).catch(err => reject(err))
        });
    },

    /**
     * 返回USDT授权数
     * @returns integer
     */
    getAllowance() {
        return new Promise((resolve, reject) => {
            this.trigger('usdt', 'allowance', [this.getAddress(), this.contracts['swap'].address]).then(res => {
                let value = this.toDecimal(res) * 1000;
                this.data('allowance', value);
                resolve(value);
            }).catch(err => reject(err))
        });
    },

    /**
     * 返回USDT账户余额
     * @returns integer
     */
    getUsdtBalance() {
        return new Promise((resolve, reject) => {
            this.trigger('usdt', 'balanceOf', [this.getAddress()]).then(res => {
                let value = this.toDecimal(res) * 1000;
                this.data('usdt', value);
                resolve(value);
            }).catch(err => reject(err))
        });
    },

    /**
     * 返回代币账户余额
     * @returns integer
     */
    getBalance() {
        return new Promise((resolve, reject) => {
            this.trigger('swap', 'balanceOf').then(res => {
                let value = this.toDecimal(res);
                this.data('balance', value);
                resolve(value);
            }).catch(err => reject(err))
        });
    },

    /**
     * 调起USDT授权支付界面
     * @param {*} money 
     * @returns Promise
     */
    appvord(money) {
        return new Promise((resolve, reject) => {
            this.trigger('usdt', 'approve', [this.contracts['swap'].address, money], [{
                feeLimit: 1000000
            }]).then(res => {
                this.getAllowance().then(() => {
                    resolve(res);
                })
            }).catch(err => reject(err))
        });
    },

    /**
     * 提交买入之前操作
     * @param {*} amount 
     */
    beforeRecharge(amount) {
        var predictUnitprice = this.data('unitprice');
        var balance = this.data('usdt');
        var predictRealmoney = predictUnitprice * amount;
        var allowance = this.data('allowance');
        var isAppvord = predictRealmoney <= allowance;
        var finalAmount = amount * this.place();
        var appvordMoney = '1000000000000';
        var result = { hash: '', value: finalAmount };

        return new Promise((resolve, reject) => {
            if (predictUnitprice === null || balance === null || allowance === null) {
                reject('授权错误');
                return false;
            }

            if (balance < predictRealmoney) {
                reject('USDT余额不足');
                return false;
            }

            if (!isAppvord) {
                this.appvord(appvordMoney).then((res) => {
                    console.log('appvord', res);
                    result.hash = res;
                    resolve(result);
                }).catch(err => reject(err));
            } else {
                resolve(result);
            }
        });
    },

    /**
     * 提交卖出之前操作
     * @param {*} amount 
     */
    beforeWithdraw(amount) {
        var balance = this.data('balance');
        var finallyAmount = amount * this.place();

        return new Promise((resolve, reject) => {
            if (balance === null) {
                reject('授权错误');
                return false;
            }

            if (balance < amount) {
                reject('余额不足');
                return false;
            }

            resolve(finallyAmount);
        });
    },

    /**
     * 唤起充值界面
     * @param {*} amount 买入代币数值
     * @returns Promise
     */
    recharge(amount) {
        return new Promise((resolve, reject) => {
            this.trigger('swap', 'recharge', [amount], [{
                feeLimit: 1000000
            }]).then(res => resolve(res)).catch(error => reject(error))
        });
    },

    /**
     * 唤起提现界面
     * @param {*} amount 
     */
    withdraw(amount) {
        return new Promise((resolve, reject) => {
            this.trigger('swap', 'withdraw', [amount], [{
                feeLimit: 1000000
            }]).then(res => resolve(res)).catch(error => reject(error))
        });
    }
}