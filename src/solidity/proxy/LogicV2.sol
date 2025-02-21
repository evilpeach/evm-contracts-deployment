// LogicContract.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract LogicV2 {
    uint256 public value;

    event ValueUpdated(uint256 newValue);

    function setValue(uint256 newValue) public {
        value = newValue;
        emit ValueUpdated(newValue);
    }

    function increament() public {
        value++;
        emit ValueUpdated(value);
    }
}
