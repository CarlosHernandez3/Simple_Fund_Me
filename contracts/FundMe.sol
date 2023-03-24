// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "hardhat/console.sol";

error FundMe__InsufficientFunds(uint256 available, uint256 required);

contract FundMe {
    uint256 private immutable i_MinimumEth;
    mapping(address => uint256) public balance;

    constructor(uint256 MinimumEth) {
        i_MinimumEth = MinimumEth;
    }

    function Deposit() public payable {
        if (msg.value < i_MinimumEth) {
            revert FundMe__InsufficientFunds({
                available: balance[msg.sender],
                required: i_MinimumEth
            });
        }
        balance[msg.sender] += msg.value;
        console.log("You're new balance is `${balance[msg.sender]}`");
    }

    function Withdraw(uint256 amount) public payable {
        if (amount < balance[msg.sender]) {
            revert FundMe__InsufficientFunds({available: balance[msg.sender], required: amount});
        }
        balance[msg.sender] -= amount;
        console.log("You're new balance is `${balance[msg.sender]}`");
    }

    function Transfer(address to, uint256 amount) public payable {
        if (amount < balance[msg.sender]) {
            revert FundMe__InsufficientFunds({available: balance[msg.sender], required: amount});
        }
        balance[msg.sender] -= amount;
        balance[to] += amount;
        console.log("You're transfer was successful!");
    }
}
