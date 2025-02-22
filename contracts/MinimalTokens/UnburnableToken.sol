// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract UnburnableToken {
    mapping(address => uint) public balances;
    mapping(address => bool) public claimed;
    uint public totalSupply;
    uint public totalClaimed;

    error TokensClaimed();
    error AllTokensClaimed();
    error UnsafeTransfer(address _to);

    constructor() {
        totalSupply = 100_000_000;
    }

    function claim() public {
        if (totalClaimed == totalSupply) {
            revert AllTokensClaimed();
        }

        if (claimed[msg.sender]) {
            revert TokensClaimed();
        }

        balances[msg.sender] = 1000;
        claimed[msg.sender] = true;
        totalClaimed += 1000;
    }

    function safeTransfer(address _to, uint _amount) public {
        if (_to == 0x0000000000000000000000000000000000000000) {
            revert UnsafeTransfer(_to);
        }

        if (_to.balance == 0) {
            revert UnsafeTransfer(_to);
        }

        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
    }
}
