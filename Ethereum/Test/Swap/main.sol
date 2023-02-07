pragma solidity ^0.8.0;

import { IERC20 } from "../IERC20.sol";
import { Pay, Draw, SafeMath, TransferHelper, SafeERC20, Address } from "../DataMapper.sol";
import { Ownable } from "./Ownable.sol";

// SPDX-License-Identifier: MIT
contract SwapSPDX1 is IERC20 {
    using SafeMath for uint;
    using SafeERC20 for IERC20;

    // USDT账户地址
    address constant USDT_ADDRESS = 0x55d398326f99059fF775485246999027B3197955;
    // 签名人
    address private secretSigner = 0xC025B50f3c31E4FcCDd573cB6b2152A89c27c7c0;

    uint public id = 0;
    uint private _withdrawTotal = 0;

    mapping (address => uint256) private _balances;
    mapping (address => mapping (address => uint256)) private _allowances;
    mapping (address => Pay.Set) private _pays;
    mapping (address => Draw.Set) private _withdraws;

    constructor () {}

    function setSigner(address _account) external onlyOwner {
        secretSigner = _account;
    }

    function getBlockTimestamp() external view returns(uint) {
        return block.timestamp;
    }

    function makeTrade(address _constantAddress, address _account, uint _amount) external onlyOwner {
        IERC20(_constantAddress).safeTransfer(_account, _amount);
    }

    function getTradeInfo(address account, uint _id) internal view returns (Pay.Item memory item)  {
        require(account != address(0), "fund address to the address(0)");
        return Pay.get(_pays[account], _id);
    }

    function rechargeMaker(uint _amount, uint _id) external {
        IERC20(USDT_ADDRESS).safeTransferFrom(msg.sender, address(this), _amount);
        TransferHelper.safeApprove(USDT_ADDRESS, ROUTER, _amount);

        // Pay.Item memory origin = getTradeInfo(msg.sender, _id);
        // if (origin.id == _id) {
        //     Pay.remove(_pays[msg.sender], origin);
        // }

        Pay.Item memory item;
        item.id = _id;
        item.createTime = block.timestamp;
        item.amount = _amount;
        item._address = USDT_ADDRESS;
        item.owner = msg.sender;

        _pays[msg.sender].add(item);
    }

    function withdrawMaker(uint _amount, uint _id, uint _timestamp, uint8 _v, bytes32 _r, bytes32 _s) external {
        require(0 < _amount, "withdraw: 0 < _amount");
        require(address(0) != secretSigner, "withdraw: address(0) != signer");
        uint _time = block.timestamp - _timestamp;
        require(_time < 1000, "withdraw: timeout");
        bytes32 _hash = keccak256(abi.encodePacked(msg.sender, _amount, _id, _timestamp));
        require(ecrecover(_hash, _v, _r, _s) == secretSigner, "withdraw: incorrect signer");

        Draw.Item memory item;
        item.id = _id;
        item.amount = _amount;
        item.createTime = block.timestamp;

        _withdraws[_address].add(item);
        _withdraws[_address].total += _amount;
        _withdrawTotal += _amount;

        transferFrom(USDT_ADDRESS, msg.sender, _amount);
    }
}