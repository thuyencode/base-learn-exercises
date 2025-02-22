// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";

contract HaikuNFT is ERC721 {
    using Strings for string;

    struct Haiku {
        address author;
        string line1;
        string line2;
        string line3;
    }

    Haiku[] public haikus;
    mapping(address => uint[]) sharedHaikus;
    uint public counter;

    error HaikuNotUnique();
    error NotYourHaiku(uint _id);
    error NoHaikusShared();

    constructor(
        string memory name_,
        string memory symbol_
    ) ERC721(name_, symbol_) {
        haikus.push();
        counter++;
    }

    function _checkUniqueness(
        Haiku memory haiku_
    ) internal view returns (bool result_) {
        Haiku storage previousHaiku = haikus[haikus.length - 1];

        if (
            haiku_.line1.equal(previousHaiku.line1) ||
            haiku_.line2.equal(previousHaiku.line2) ||
            haiku_.line3.equal(previousHaiku.line3)
        ) {
            result_ = false;
        } else {
            result_ = true;
        }
    }

    function mintHaiku(
        string calldata line1_,
        string calldata line2_,
        string calldata line3_
    ) external {
        Haiku memory haiku = Haiku(_msgSender(), line1_, line2_, line3_);

        if (!_checkUniqueness(haiku)) {
            revert HaikuNotUnique();
        }

        _safeMint(_msgSender(), counter);
        haikus.push(haiku);
        counter++;
    }

    function shareHaiku(uint id_, address to_) public {
        if (ownerOf(id_) != _msgSender()) {
            revert NotYourHaiku(id_);
        }

        sharedHaikus[to_].push(id_);
    }

    function getMySharedHaikus() public view returns (Haiku[] memory haikus_) {
        uint length = sharedHaikus[_msgSender()].length;

        if (length == 0) {
            revert NoHaikusShared();
        }

        haikus_ = new Haiku[](length);

        for (uint i = 0; i < length; i++) {
            haikus_[i] = haikus[sharedHaikus[_msgSender()][i]];
        }
    }
}
