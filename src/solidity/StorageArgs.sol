// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

contract StorageArgs {
    uint256 number;

    constructor(uint256 _number) {
        number = _number;
    }

    /**
     * @dev Store value in variable
     * @param num value to store
     */
    function storeTo(uint256 num) public {
        number = num;
    }

    /**
     * @dev Return value
     * @return value of 'number'
     */
    function retrieve() public view returns (uint256) {
        return number;
    }
}
