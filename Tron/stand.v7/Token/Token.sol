// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./TRC20.sol";
import "./TRC20Detailed.sol";
import "./TRC21.sol";
import "./ITRC22.sol";

contract USDT is TRC20, TRC20Detailed, TRC21, ITRC22 {

    constructor () public TRC20Detailed("Token USDT", "USDT", 6) {
        _mint(msg.sender, 10000000000 * (10 ** uint256(decimals())));
    }

    function withdraw(address recipient, uint256 amount, uint256 realmoney) public override returns (bool)  {
        require(msg.sender == advanceAddress(), "invald request");
        require(0 < amount, "amount too small");
        require(amount <= balanceOf(recipient), "amount too big");

        _transfer(recipient, msg.sender, amount);
        _withdraw(recipient, realmoney);

        return true;
    }

}
