pragma solidity ^0.5.0;

contract Loan {
    //放贷人
    struct Lender {
        address addr;
        uint balance;
        string name;
        address[] borrowers;
    }

    Lender[] private lenders;

    mapping (address => uint) balances;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    constructor() public {} 

    // 贷款
    function lendMoney(address receiver, int a) public payable returns(bool sufficient) {
        require(a > 0,"money must be positive integer");
        uint amount = uint(a);
        int index = findLender(receiver);
        if(index>=0) {
            uint idx = uint(index);
            if(lenders[idx].balance < amount) return false;
            lenders[idx].balance -= amount;
            lenders[idx].borrowers.push(msg.sender);
            balances[msg.sender] += amount;
            emit Transfer(msg.sender, receiver, amount);
            return true;
        }
        return false;
    }

    // 借贷人余额
    function getBalance(address addr) public view returns(uint) {
        return balances[addr];
    }

    // 添加放贷人
    function addLender(address a,int b,string memory s) public returns(bool status) {
        address[] memory addre;
        require(b>0,"money must be positive integer");

        int st = findLender(a);
        require(st==-1,"the lender already exist!");

        Lender memory lender = Lender({
            addr: a,
            balance: uint(b),
            name: s,
            borrowers: addre
        });
        lenders.push(lender);
        return true;
    }

    // 查询放贷人
    function findLender(address a) public view returns(int index) {
        for(uint i = 0; i < lenders.length; ++i){
            if(lenders[i].addr == a){
                return int(i);
            }
        }

        return -1;
    }

    // 获得放贷人数量
    function getLendersNum() public view returns(uint n) {
        return lenders.length;
    }

    // 获得放贷人余额
    function getLendersMoney(address addr) public view returns(int m) {
        Lender memory lender;
        int index = findLender(addr);
        if(index>0){
            return int(lender.balance);
        } else {
            return -1;
        }
    }

    // 获得放贷人列表
    function getLendersList(uint index) public view returns(address, uint, string memory){
        return (lenders[index].addr,lenders[index].balance,lenders[index].name);
    }

}