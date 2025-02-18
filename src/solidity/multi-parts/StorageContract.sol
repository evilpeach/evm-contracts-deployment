// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract StorageContract {
    uint256 private storedValue;

    function setStoredValue(uint256 newValue) external {
        storedValue = newValue;
    }

    function getStoredValue() external view returns (uint256) {
        return storedValue;
    }
}