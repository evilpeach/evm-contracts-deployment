// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

library HelperLibrary {
    function calculateSquare(uint256 num) internal pure returns (uint256) {
        return num * num;
    }
}