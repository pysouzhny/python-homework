pragma solidity ^0.5.0;

import "hardhat/console.sol";

contract JointSavings{

    address payable accountOne;
    address payable accountTwo;
    address payable lastToWithdraw;
    uint public lastWithdrawAmount;
    uint public contractBalance;
    
    constructor () public payable { }

    function withdraw(uint amount, address payable recipient) public {
        require(recipient == accountOne || recipient == accountTwo, "You don’t own this account!");
        require(address(this).balance <= amount, "Insufficient funds!");
        if(lastToWithdraw != recipient){
            lastToWithdraw = recipient;
        }
        recipient.transfer(amount);
        lastWithdrawAmount = amount;
        contractBalance = address(this).balance;
    }


    function deposit() public payable {
        contractBalance = address(this).balance;
    }

    function setAccounts( address payable account1, address payable account2) public{
        accountOne = account1;
        accountTwo = account2;
    
    }
    function() external payable {
    }
}