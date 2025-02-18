// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

library DivideLibrary {
    function divide(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "Cannot divide by zero");
        return a / b;
    }
}
