// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {SillyStringUtils} from "./SillyStringUtils.sol";

contract ImportsExercise {
    using SillyStringUtils for string;

    SillyStringUtils.Haiku public haiku;

    function saveHaiku(
        string calldata _line1,
        string calldata _line2,
        string calldata _line3
    ) external {
        haiku = SillyStringUtils.Haiku(_line1, _line2, _line3);
    }

    function getHaiku() external view returns (SillyStringUtils.Haiku memory) {
        return haiku;
    }

    function shruggieHaiku()
        external
        view
        returns (SillyStringUtils.Haiku memory _haiku)
    {
        _haiku = haiku;
        _haiku.line3 = _haiku.line3.shruggie();
    }
}
