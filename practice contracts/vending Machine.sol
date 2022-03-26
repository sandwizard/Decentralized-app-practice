// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

contract VendingMachine{
    address public owner;
    mapping (address => uint) public donoughtBalance;

   
    constructor(){
        owner = msg.sender;
        donoughtBalance[address(this)] = 100;
    }
    
    function getVendingMachineBalance() public view returns (uint){
        return donoughtBalance[address(this)];
    }

    function restockVendingMachine(uint amount) public{
        require(msg.sender == owner, "only owner can restock this machine");
        donoughtBalance[address(this)]+= amount;
    }

    function purchase (uint amount) public payable {
        require(msg.value >= amount * 2 ether," must pay atleast 2 ether per donought");
        require(donoughtBalance[address(this)] >= amount,"not enough donoughts in machine");
        donoughtBalance[address(this)]-= amount;
        donoughtBalance[msg.sender] += amount;
    }

}