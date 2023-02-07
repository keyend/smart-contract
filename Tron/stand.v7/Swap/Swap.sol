// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./Detailed.sol";

contract Swap is Detailed {

    constructor(address tokenAddress) public Detailed() {
        initialize(tokenAddress);
    }

    function recharge(uint256 amount) public payable override returns (bool) {
        _recharge(msg.sender, amount);
        return true;
    }

    function withdraw(uint256 amount) public override returns (bool) {
        _withdraw(msg.sender, amount);
        return true;
    }

}
