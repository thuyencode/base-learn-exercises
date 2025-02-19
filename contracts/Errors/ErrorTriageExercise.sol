// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ErrorTriageExercise {
    function _absSubtractor(
        uint _a,
        uint _b
    ) private pure returns (uint _difference) {
        int a = int(_a);
        int b = int(_b);

        int difference = a - b;

        if (difference < 0) {
            _difference = uint(-difference);
        } else {
            _difference = uint(difference);
        }
    }

    /**
     * Finds the difference between each uint with it's neighbor (a to b, b to c, etc.)
     * and returns a uint array with the absolute integer difference of each pairing.
     */
    function diffWithNeighbor(
        uint _a,
        uint _b,
        uint _c,
        uint _d
    ) public pure returns (uint[] memory) {
        uint[] memory results = new uint[](3);

        results[0] = _absSubtractor(_a, _b);
        results[1] = _absSubtractor(_b, _c);
        results[2] = _absSubtractor(_c, _d);

        return results;
    }

    /**
     * Changes the _base by the value of _modifier. Base is always >= 1000. Modifiers can be
     * between positive and negative 100;
     */
    function applyModifier(
        uint _base,
        int _modifier
    ) public pure returns (int) {
        return int(_base) + _modifier;
    }

    /**
     * Pop the last element from the supplied array, and return the popped
     * value (unlike the built-in function)
     */
    uint[] arr;

    function popWithReturn() public returns (uint _element) {
        uint index = arr.length - 1;
        _element = arr[index];

        arr.pop();
    }

    // The utility functions below are working as expected
    function addToArr(uint _num) public {
        arr.push(_num);
    }

    function getArr() public view returns (uint[] memory) {
        return arr;
    }

    function resetArr() public {
        delete arr;
    }
}
