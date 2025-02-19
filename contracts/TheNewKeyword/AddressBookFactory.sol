// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {AddressBook} from "./AddressBook.sol";

contract AddressBookFactory {
    function deploy() external returns (address) {
        AddressBook addressBook = new AddressBook(msg.sender);

        return address(addressBook);
    }
}
