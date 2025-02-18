// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "./libraries/MathLibrary.sol";
import "./libraries/MultiplyLibrary.sol";
import "./libraries/DivideLibrary.sol";

// Define a contract named Calculator that uses multiple libraries
contract Calculator {
    // Import functions from MathLibrary for uint256 type
    using MathLibrary for uint256;
    using MultiplyLibrary for uint256;
    using DivideLibrary for uint256;

    // Function to add two numbers using the library's add function
    function addNumbers(
        uint256 num1,
        uint256 num2
    ) public pure returns (uint256) {
        return num1.add(num2);
    }

    // Function to subtract two numbers using the library's subtract function
    function subtractNumbers(
        uint256 num1,
        uint256 num2
    ) public pure returns (uint256) {
        return num1.subtract(num2);
    }

    // Function to multiply two numbers using the library's multiply function
    function multiplyNumbers(
        uint256 num1,
        uint256 num2
    ) public pure returns (uint256) {
        return num1.multiply(num2);
    }

    // Function to divide two numbers using the library's divide function
    function divideNumbers(
        uint256 num1,
        uint256 num2
    ) public pure returns (uint256) {
        require(num2 != 0, "Cannot divide by zero");
        return num1.divide(num2);
    }
}
