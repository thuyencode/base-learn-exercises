// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ControlStructures {
    function fizzBuzz(
        uint _number
    ) external pure returns (string memory _result) {
        _result = "Splat";

        if (_number % 3 == 0) {
            _result = "Fizz";
        }

        if (_number % 5 == 0) {
            _result = string.concat(_result, "Buzz");
        }
    }

    error AfterHours(uint _time);

    function doNotDisturb(
        uint _time
    ) external pure returns (string memory _message) {
        assert(_time < 2400);

        if (_time < 800 || _time > 2200) {
            revert AfterHours(_time);
        }

        if (_time >= 1200 && _time <= 1259) {
            revert("At lunch");
        }

        if (_time >= 800 && _time <= 1199) {
            _message = "Morning!";
        }

        if (_time >= 1300 && _time <= 1799) {
            _message = "Afternoon!";
        }

        if (_time >= 1800 && _time <= 2200) {
            _message = "Evening";
        }
    }
}
