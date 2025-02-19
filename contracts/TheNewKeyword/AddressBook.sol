// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract AddressBook is Ownable {
    struct Contact {
        uint id;
        string firstName;
        string lastName;
        uint[] phoneNumbers;
    }

    Contact[] contacts;
    mapping(uint => bool) ids;

    error ContactNotFound(uint _id);

    constructor(address _owner) Ownable(_owner) {}

    function addContact(
        uint _id,
        string calldata _firstName,
        string calldata _lastName,
        uint[] calldata _phoneNumbers
    ) external onlyOwner {
        contacts.push(Contact(_id, _firstName, _lastName, _phoneNumbers));
        ids[_id] = true;
    }

    function deleteContact(uint _id) external onlyOwner {
        if (!ids[_id]) {
            revert ContactNotFound(_id);
        }

        delete contacts[_id];
        ids[_id] = false;
    }

    function getContact(
        uint _id
    ) external view onlyOwner returns (Contact memory _contact) {
        if (!ids[_id]) {
            revert ContactNotFound(_id);
        }

        uint length = contacts.length;

        for (uint i = 0; i < length; i++) {
            if (_id == contacts[i].id) {
                _contact = contacts[i];
            }
        }
    }

    function getAllContacts() external view returns (Contact[] memory) {
        return contacts;
    }
}
