// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "./HelperLibrary.sol";
import "./StorageContract.sol";

contract MainContract {
    using HelperLibrary for uint256;

    StorageContract private storageContract;

    // constructor(address _storageContractAddress) {
    //     storageContract = StorageContract(_storageContractAddress);
    // }

    constructor() {
        storageContract = new StorageContract();
    }

    function storeAndSquareValue(uint256 value) external {
        uint256 squaredValue = value.calculateSquare();
        storageContract.setStoredValue(squaredValue);
    }

    function retrieveStoredValue() external view returns (uint256) {
        return storageContract.getStoredValue();
    }
}