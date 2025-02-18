// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract FavoriteRecords {
    mapping(string => bool) public approvedRecords;
    mapping(address => mapping(string => bool)) userFavorites;
    string[] listOfApprovedRecords;

    error NotApproved(string _album);

    constructor(string[] memory _albums) {
        uint _length = _albums.length;

        for (uint i; i < _length; i++) {
            approvedRecords[_albums[i]] = true;
            listOfApprovedRecords.push(_albums[i]);
        }
    }

    function getApprovedRecords() external view returns (string[] memory) {
        return listOfApprovedRecords;
    }

    function addRecord(string calldata _album) external {
        if (!approvedRecords[_album]) {
            revert NotApproved(_album);
        }

        userFavorites[msg.sender][_album] = true;
    }

    function getUserFavorites(
        address _user
    ) external view returns (string[] memory _favorites) {
        uint _lengthOfApprovedRecords = listOfApprovedRecords.length;
        uint _lengthOfFavorites = 0;

        for (uint i; i < _lengthOfApprovedRecords; i++) {
            string storage _approvedRecord = listOfApprovedRecords[i];

            if (userFavorites[_user][_approvedRecord] == true) {
                _lengthOfFavorites++;
            }
        }

        _favorites = new string[](_lengthOfFavorites);
        uint _index = 0;

        for (uint i; i < _lengthOfApprovedRecords; i++) {
            string storage _approvedRecord = listOfApprovedRecords[i];

            if (userFavorites[_user][_approvedRecord] == true) {
                _favorites[_index] = _approvedRecord;
                _index++;
            }
        }
    }

    function resetUserFavorites() external {
        uint _lengthOfApprovedRecords = listOfApprovedRecords.length;

        for (uint i; i < _lengthOfApprovedRecords; i++) {
            delete userFavorites[msg.sender][listOfApprovedRecords[i]];
        }
    }
}
