// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract EtheraX {
    address public minter;
    mapping(address => uint) public balance;
    event TransferToken(address from, address to, uint amount);

    address public payer;
    address public origin;
    uint256 public value;
    address private owner;

    string public tokenName;
    string public tokenSymbol;
    int8 public tokenDecimal;
    int public maxSupply;

    constructor() {
        tokenName = "Ethera X";
        tokenSymbol = "ETHERAX";
        tokenDecimal = 18;
        maxSupply = 100000000;
        owner = msg.sender;
        minter = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller must be owner");
        _;
    }

    function mint(address receiver, uint amount) public {
        require(msg.sender == minter, "Caller must be owner");
        require(amount < 1e60, "Maximum limit reached");
        balance[receiver] += amount;
    }

    function Transferred(address receiver, uint amount) public {
        require(amount <= balance[msg.sender], "Insufficient balance");
        balance[msg.sender] -= amount;
        balance[receiver] += amount;
        emit TransferToken(msg.sender, receiver, amount);
    }

    function balances(address _account) external view returns (uint) {
        return balance[_account];
    }

    function pay(address) public payable {
        payer = msg.sender;
        origin = msg.sender;
        value = msg.value;
    }

    function checkBalance(address) public view returns (uint) {
        return address(this).balance;
    }

 
    function getBlockInfo() public view returns (uint, uint, uint) {
        return(
            block.number,
            block.timestamp,
            block.chainid
        );
    }
}