// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./ITRC21.sol";
import "./ITRC20.sol";

contract TRC21 is ITRC21 {

    address private _advanceAddress;

    event Withdraw(address indexed sender, uint256 value);

    function advance(address value) public override returns (bool) {
        require(_advanceAddress == address(0), "TRC20: set operation contract failed");
        _advanceAddress = value;
        return true;
    }

    function advanceAddress() internal view returns (address) {
        return _advanceAddress;
    }

    function usdt() internal pure returns (ITRC20) {
        return ITRC20(address(0x41a614f803b6fd780986a42c78ec9c7f77e6ded13c));
    }

    function _withdraw(address sender, uint256 amount) internal {
        require (0 < amount, "amount too small");
        usdt().transfer(sender, amount);
        emit Withdraw(sender, amount);
    }

}