import contract from 'truffle-contract'
import LoanContract from '@contracts/Loan.json'

const Loan = {

    contract: null,

    instance: null,

    init: function () {
        let self = this

        return new Promise(function (resolve, reject) {
            self.contract = contract(LoanContract)
            self.contract.setProvider(window.web3.currentProvider)

            self.contract.deployed().then(instance => {
                self.instance = instance
                resolve()
            }).catch(err => {
                reject(err)
            })
        })
    },

    getBalance: function (address) {
        let self = this

        return new Promise((resolve, reject) => {
            self.instance.getBalance.call(
                address || window.web3.eth.defaultAccount,
                { from: window.web3.eth.accounts[0] }
            ).then(balance => {
                resolve(balance)
            }).catch(err => {
                reject(err)
            })
        })
    },

    getLender: function (index) {
        let self = this

        return new Promise((resolve, reject) => {
            self.instance.getLendersList.call(
                index, { from: window.web3.eth.accounts[0] }
            ).then(result => {
                var lender={};
                lender.address=result[0];
                lender.balance=result[1].toNumber();
                lender.name=result[2];
                resolve(lender)
            }).catch(err => {
                reject(err)
            })
        })
    },

    getLendersNum: function () {
        let self = this

        return new Promise((resolve, reject) => {
            self.instance.getLendersNum.call(
                { from: window.web3.eth.accounts[0] }
            ).then(result => {
                resolve(result)
            }).catch(err => {
                reject(err)
            })
        })
    },

    getBalance: function () {
        let self = this

        return new Promise((resolve, reject) => {
            self.instance.getBalance.call(
                window.web3.eth.accounts[0], { from: window.web3.eth.accounts[0] }
            ).then(result => {
                resolve(result)
            }).catch(err => {
                reject(err)
            })
        })
    },

    addLender: function(params){
        let self = this

        return new Promise((resolve, reject) => {
            self.instance.addLender(
                params.address, parseInt(params.balance),params.name, { from: window.web3.eth.accounts[0] }
            ).then(result => {
                resolve(result)
            }).catch(err => {
                reject(err)
            })
        })
    },

    lendMoney: function(params){
        let self = this

        return new Promise((resolve, reject) => {
            self.instance.lendMoney(
                params.address, parseInt(params.borrowMoney), { from: window.web3.eth.accounts[0] }
            ).then(result => {
                resolve(result)
            }).catch(err => {
                reject(err)
            })
        })
    }

}

export default Loan
