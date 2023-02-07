// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./ITRC20.sol";
import "./ITRC19.sol";
import "./ITRC21.sol";
import "./SafeMath.sol";
import "./ITRC22.sol";

abstract contract Detailed is ITRC19 {

    using SafeMath for uint;

    address constant _usdt = address(0x41a614f803b6fd780986a42c78ec9c7f77e6ded13c);
    uint256 constant _slip = 8;
    uint256 constant _decimals = 6;

    struct Attribute {
        address token;

        uint256 totalSupply;
        uint256 poolTotal;
        uint256 liquidity;
        uint256 oldprice;
        uint256 newprice;
    }

    Attribute private _attr;

    constructor() public {
        _attr.oldprice = places();
        _attr.newprice = places();
    }

    function initialize(address value) internal {
        _attr.token = value;
        _attr.totalSupply = ITRC20(value).totalSupply();
        _attr.poolTotal = _attr.totalSupply;
        _attr.liquidity = 0;

        ITRC21(value).advance(address(this));
    }

    function places() public pure returns (uint256) {
        return 10 ** decimals();
    }

    function decimals() public pure returns (uint256) {
        return _decimals;
    }

    function valueOf() public view returns (uint256) {
        return usdt().balanceOf(_attr.token);
    }

    function token() internal view virtual returns (ITRC20) {
        return ITRC20(tokenAddress());
    }

    function tokenAddress() internal view virtual returns (address) {
        return _attr.token;
    }

    function usdt() internal pure returns (ITRC20) {
        return ITRC20(usdtAddress());
    }

    function usdtAddress() internal pure returns (address) {
        return _usdt;
    }

    function balanceOf() public view returns (uint256) {
        return token().balanceOf(msg.sender);
    }

    function slip() public pure returns (uint256) {
        return _slip * places() / 10;
    }

    function pool() public view returns (uint256) {
        return _attr.poolTotal;
    }

    function liquidity() public view returns (uint256) {
        return _attr.liquidity;
    }

    function oldprice() public view returns (uint256) {
        return _attr.oldprice;
    }

    function unitprice() public view returns (uint256) {
        return _attr.newprice;
    }

    function amplitude() public view returns (uint256) {
        return (unitprice() * places()) / oldprice();
    }

    function _withdraw(address sender, uint256 amount) internal {
        uint256 _newprice = _attr.newprice;
        uint256 _realmoney = amount.mul(_newprice).div(10).mul(_slip) / (10 ** _decimals);
        require (0 < _realmoney, "amount too small");

        ITRC22(tokenAddress()).withdraw(sender, amount, _realmoney);

        uint256 _liquidity = _attr.liquidity;
        uint256 _poolTotal = _attr.poolTotal;
        uint256 _total = _attr.totalSupply;

        _attr.oldprice = _newprice;
        _attr.newprice = (_liquidity.sub(_realmoney) * (10 ** _decimals)).div(_total.sub(_poolTotal).sub(amount));
        _attr.poolTotal = _poolTotal.add(amount);
        _attr.liquidity = _liquidity.sub(_realmoney);

        emit Withdraw(sender, amount);
    }

    function _recharge(address sender, uint256 amount) internal {
        uint256 _newprice = _attr.newprice;
        uint256 _realmoney = amount.mul(_newprice) / (10 ** _decimals);
        require (0 < _realmoney, "amount too small");

        uint256 _realamount = amount;
        uint256 _liquidity = _attr.liquidity;
        uint256 _total = _attr.totalSupply;
        uint256 _poolTotal = _attr.poolTotal;

        if (_liquidity > 0) {
            _realamount = amount * _slip / 10;
            _attr.oldprice = _newprice;
            _attr.newprice = (_liquidity.add(_realmoney) * (10 ** _decimals)).div(_total.sub(_poolTotal).add(_realamount));
        }

        usdt().transferFrom(sender, tokenAddress(), _realmoney);
        token().approve(address(this), _realamount);
        token().transferFrom(address(this), sender, _realamount);

        _attr.poolTotal = _poolTotal.sub(_realamount);
        _attr.liquidity = _liquidity.add(_realmoney);

        emit Recharge(sender, amount);
    }
}
