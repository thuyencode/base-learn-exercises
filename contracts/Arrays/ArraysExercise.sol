// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ArraysExercise {
    uint[] public numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    uint[] public timestamps;
    address[] public senders;

    uint8 private afterY2KCount;

    function getNumbers() external view returns (uint[] memory) {
        return numbers;
    }

    function appendToNumbers(uint[] calldata _toAppend) external {
        for (uint i; i < _toAppend.length; i++) {
            numbers.push(_toAppend[i]);
        }
    }

    function saveTimestamp(uint _unixTimestamp) external {
        timestamps.push(_unixTimestamp);
        senders.push(msg.sender);

        if (_unixTimestamp > 946702800) {
            afterY2KCount++;
        }
    }

    function afterY2K()
        external
        view
        returns (uint[] memory _timestamps, address[] memory _senders)
    {
        uint index = 0;

        _timestamps = new uint[](afterY2KCount);
        _senders = new address[](afterY2KCount);

        for (uint i; i < timestamps.length; i++) {
            if (timestamps[i] > 946702800) {
                _timestamps[index] = timestamps[i];
                _senders[index] = senders[i];

                index++;
            }
        }
    }

    function resetNumbers() public {
        delete numbers;

        uint8 length = 10;
        numbers = new uint[](length);

        for (uint i; i < length; i++) {
            numbers[i] = i + 1;
        }
    }

    function resetSenders() public {
        delete senders;
    }

    function resetTimestamps() public {
        afterY2KCount = 0;
        delete timestamps;
    }
}
