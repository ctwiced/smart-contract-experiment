//SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract VendingMachine {
    address public owner;
    mapping(address => uint) public donutBalances;

    constructor() {
        owner = msg.sender;
        donutBalances[address(this)] = 100;
    }
// view means that this function is not gonna modify any data on the blockchain, but it can read data
    function getVendingMachineBalance() public view returns (uint) {
        return donutBalances[address(this)];
    }
// require statement takes two arguments (first one is some sort of condition that needs to be fulfilled) and the second is a statement that gets sent back if the requirement is not met
    function restock(uint amount) public {
        require(msg.sender == owner, "Only the owner can restock this machine");
        donutBalances[address(this)] += amount;
    }
// payable is used for any function that needs to receive ether
    function purchase(uint amount) public payable{
        require(msg.value >= amount * 2 ether, "You must pay at least 2 ether per donut");
        require(donutBalances[address(this)] >= amount, "Not enough donuts in stock to fulfill purchase request");
        donutBalances[address(this)] -= amount;
        donutBalances[msg.sender] += amount;
    }
}
