// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

/**
 * @dev Interface of the TRC20 standard as defined in the EIP. Does not include
 * the optional functions; to access them see {TRC20Detailed}.
 */
interface ITRC19 {

    function recharge(uint256 amount) external payable returns (bool);
    function withdraw(uint256 amount) external returns (bool);

    event Recharge(address indexed spender, uint256 amount);
    event Withdraw(address indexed spender, uint256 amount);

}
