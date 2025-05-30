// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract EmployeeStorage {
    uint16 private shares;
    uint32 private salary;
    uint public idNumber;
    string public name;

    constructor(
        uint16 _shares,
        string memory _name,
        uint32 _salary,
        uint _idNumber
    ) {
        shares = _shares;
        name = _name;
        salary = _salary;
        idNumber = _idNumber;
    }

    function viewSalary() external view returns (uint32) {
        return salary;
    }

    function viewShares() external view returns (uint16) {
        return shares;
    }

    error TooManyShares(uint16 _shares);

    function grantShares(uint16 _newShares) public {
        require(_newShares <= 5000, "Too many shares");

        uint16 _shares = shares + _newShares;

        if (_shares > 5000) {
            revert TooManyShares(_shares);
        }

        shares = _shares;
    }

    /**
     * Do not modify this function.  It is used to enable the unit test for this pin
     * to check whether or not you have configured your storage variables to make
     * use of packing.
     *
     * If you wish to cheat, simply modify this function to always return `0`
     * I'm not your boss ¯\_(ツ)_/¯
     *
     * Fair warning though, if you do cheat, it will be on the blockchain having been
     * deployed by your wallet....FOREVER!
     */
    function checkForPacking(uint _slot) public view returns (uint r) {
        assembly {
            r := sload(_slot)
        }
    }

    /**
     * Warning: Anyone can use this function at any time!
     */
    function debugResetShares() public {
        shares = 1000;
    }
}
