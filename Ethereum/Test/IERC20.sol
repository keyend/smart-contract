// SPDX-License-Identifier: MIT
// file IERC20.sol
pragma solidity ^0.8.0;

interface IERC20 {
    /**
    * 总发行量
    * Returns the amount of tokens in existence.
    */
    function totalSupply() external view returns (uint256);

    /**
     * 查看地址余额
     * Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * 从自己帐户给指定地址转账
     * Moves `amount` tokens from the caller's account to `recipient`.
     * Returns a boolean value indicating whether the operation succeeded.
     * Emits a {Transfer} event.
     */
    function transfer(address recipient, uint256 amount) external returns (bool);

    /**
     * 查看被授权人还可以使用的代币余额
     * Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * 授权指定帐户使用你拥有的代币
     * Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * 从一个地址转账至另一个地址，该函数只能是通过approver授权的用户可以调用
     * Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    /**
    * Returns the token decimals.
    * 代币支持的小数点后位数，若无特别需求，我们一般默认采用18位
    */
    function decimals() external view returns (uint8);

    /**
    * Returns the token symbol.
    * 代币符号或简称, 如:BTC
    */
    function symbol() external view returns (string memory);

    /**
    * Returns the token name.
    * 代币名称, 如:BitCoin
    */
    function name() external view returns (string memory);

    /**
    * Returns the bep token owner.
    */
    function getOwner() external view returns (address);

    /**
     * 定义事件，发生代币转移时触发
     * Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * 定义事件 授权时触发
     * Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    event WithdrawReward(address indexed user, uint amount);
}