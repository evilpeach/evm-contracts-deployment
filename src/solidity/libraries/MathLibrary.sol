// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

// Define a library named MathLibrary
library MathLibrary {
    // Function to add two unsigned integers
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    // Function to subtract one unsigned integer from another
    function subtract(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "Subtraction underflow");
        return a - b;
    }
}
