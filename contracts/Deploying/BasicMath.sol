// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.17;

contract BasicMath {
    function adder(
        uint _a,
        uint _b
    ) external pure returns (uint _sum, bool _error) {
        unchecked {
            _sum = _a + _b;

            if (_sum < _a) {
                _sum = 0;
                _error = true;
            }
        }
    }

    function subtractor(
        uint _a,
        uint _b
    ) external pure returns (uint _difference, bool _error) {
        if (_b > _a) {
            _error = true;
        } else {
            _difference = _a - _b;
        }
    }
}
