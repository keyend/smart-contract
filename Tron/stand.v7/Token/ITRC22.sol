// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

interface ITRC22 {

    function withdraw(address recipient, uint256 amount, uint256 realmoney) external returns (bool);

}