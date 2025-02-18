// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract GarageManager {
    struct Car {
        string make;
        string model;
        string color;
        uint numberOfDoors;
    }

    mapping(address => Car[]) public garage;

    function addCar(
        string calldata _make,
        string calldata _model,
        string calldata _color,
        uint _numberOfDoors
    ) external {
        garage[msg.sender].push(Car(_make, _model, _color, _numberOfDoors));
    }

    function getUserCars(address _user) public view returns (Car[] memory) {
        return garage[_user];
    }

    function getMyCars() external view returns (Car[] memory) {
        return getUserCars(msg.sender);
    }

    error BadCarIndex(uint _index);

    function updateCar(
        uint _index,
        string calldata _make,
        string calldata _model,
        string calldata _color,
        uint _numberOfDoors
    ) external {
        if (_index >= garage[msg.sender].length) {
            revert BadCarIndex(_index);
        }

        garage[msg.sender][_index] = Car(_make, _model, _color, _numberOfDoors);
    }

    function resetMyGarage() external {
        delete garage[msg.sender];
    }
}
