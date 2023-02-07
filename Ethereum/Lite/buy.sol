/**
 *Submitted for verification at BscScan.com on 2022-10-10
*/

pragma solidity ^0.8.0;

abstract contract Context {
 function _msgSender() internal view virtual returns (address) {
  return msg.sender;
 }

 function _msgData() internal view virtual returns (bytes calldata) {
  return msg.data;
 }
}

library PaySet {

 struct Item {
  uint id;
  uint orderId;
  uint createTime;
  uint payAmount;
  address payTokenAddr;
  address owner;
 }

 struct Set {
  Item[] _values;
  // id => index
  mapping (uint => uint) _indexes;
 }

 /**
  * @dev Add a value to a set. O(1).
  *
  * Returns true if the value was added to the set, that is if it was not
  * already present.
  */
 function add(Set storage set, Item memory value) internal returns (bool) {
  if (!contains(set, value.id)) {
   set._values.push(value);
   // The value is stored at length-1, but we add 1 to all indexes
   // and use 0 as a sentinel value
   set._indexes[value.id] = set._values.length;
   return true;
  } else {
   return false;
  }
 }

 /**
  * @dev Removes a value from a set. O(1).
  *
  * Returns true if the value was removed from the set, that is if it was
  * present.
  */
 function remove(Set storage set, Item memory value) internal returns (bool) {
  // We read and store the value's index to prevent multiple reads from the same storage slot
  uint256 valueIndex = set._indexes[value.id];

  if (valueIndex != 0) { // Equivalent to contains(set, value)
   // To delete an element from the _values array in O(1), we swap the element to delete with the last one in
   // the array, and then remove the last element (sometimes called as 'swap and pop').
   // This modifies the order of the array, as noted in {at}.

   uint256 toDeleteIndex = valueIndex - 1;
   uint256 lastIndex = set._values.length - 1;

   // When the value to delete is the last one, the swap operation is unnecessary. However, since this occurs
   // so rarely, we still do the swap anyway to avoid the gas cost of adding an 'if' statement.

   Item memory lastvalue = set._values[lastIndex];

   // Move the last value to the index where the value to delete is
   set._values[toDeleteIndex] = lastvalue;
   // Update the index for the moved value
   set._indexes[lastvalue.id] = toDeleteIndex + 1; // All indexes are 1-based

   // Delete the slot where the moved value was stored
   set._values.pop();

   // Delete the index for the deleted slot
   delete set._indexes[value.id];

   return true;
  } else {
   return false;
  }
 }

 /**
  * @dev Returns true if the value is in the set. O(1).
  */
 function contains(Set storage set, uint valueId) internal view returns (bool) {
  return set._indexes[valueId] != 0;
 }

 /**
  * @dev Returns the number of values on the set. O(1).
  */
 function length(Set storage set) internal view returns (uint256) {
  return set._values.length;
 }

 /**
  * @dev Returns the value stored at position `index` in the set. O(1).
  *
  * Note that there are no guarantees on the ordering of values inside the
  * array, and it may change when more values are added or removed.
  *
  * Requirements:
  *
  * - `index` must be strictly less than {length}.
  */
 function at(Set storage set, uint256 index) internal view returns (Item memory) {
  require(set._values.length > index, "PaySet: index out of bounds");
  return set._values[index];
 }

 function idAt(Set storage set, uint256 valueId) internal view returns (Item memory) {
  require(set._indexes[valueId] != 0, "PaySet: set._indexes[valueId] != 0");
  uint index = set._indexes[valueId] - 1;
  require(set._values.length > index, "PaySet: index out of bounds");
  return set._values[index];
 }

}

pragma solidity ^0.8.0;

abstract contract Ownable is Context {
 address private _owner;

 event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

 /**
  * @dev Initializes the contract setting the deployer as the initial owner.
  */
 constructor() {
  _setOwner(_msgSender());
 }

 /**
  * @dev Returns the address of the current owner.
  */
 function owner() public view virtual returns (address) {
  return _owner;
 }

 /**
  * @dev Throws if called by any account other than the owner.
  */
 modifier onlyOwner() {
  require(owner() == _msgSender(), "Ownable: caller is not the owner");
  _;
 }

 /**
  * @dev Leaves the contract without owner. It will not be possible to call
  * `onlyOwner` functions anymore. Can only be called by the current owner.
  *
  * NOTE: Renouncing ownership will leave the contract without an owner,
  * thereby removing any functionality that is only available to the owner.
  */
 function renounceOwnership() public virtual onlyOwner {
  _setOwner(address(0));
 }

 /**
  * @dev Transfers ownership of the contract to a new account (`newOwner`).
  * Can only be called by the current owner.
  */
 function transferOwnership(address newOwner) public virtual onlyOwner {
  require(newOwner != address(0), "Ownable: new owner is the zero address");
  _setOwner(newOwner);
 }

 function _setOwner(address newOwner) private {
  address oldOwner = _owner;
  _owner = newOwner;
  emit OwnershipTransferred(oldOwner, newOwner);
 }
}


// File @openzeppelin/contracts/token/ERC20/IERC20.sol@v4.3.1



pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
 /**
  * @dev Returns the amount of tokens in existence.
  */
 function totalSupply() external view returns (uint256);

 /**
  * @dev Returns the amount of tokens owned by `account`.
  */
 function balanceOf(address account) external view returns (uint256);

 /**
  * @dev Moves `amount` tokens from the caller's account to `recipient`.
  *
  * Returns a boolean value indicating whether the operation succeeded.
  *
  * Emits a {Transfer} event.
  */
 function transfer(address recipient, uint256 amount) external returns (bool);

 /**
  * @dev Returns the remaining number of tokens that `spender` will be
  * allowed to spend on behalf of `owner` through {transferFrom}. This is
  * zero by default.
  *
  * This value changes when {approve} or {transferFrom} are called.
  */
 function allowance(address owner, address spender) external view returns (uint256);

 /**
  * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
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
  * @dev Moves `amount` tokens from `sender` to `recipient` using the
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
  * @dev Emitted when `value` tokens are moved from one account (`from`) to
  * another (`to`).
  *
  * Note that `value` may be zero.
  */
 event Transfer(address indexed from, address indexed to, uint256 value);

 /**
  * @dev Emitted when the allowance of a `spender` for an `owner` is set by
  * a call to {approve}. `value` is the new allowance.
  */
 event Approval(address indexed owner, address indexed spender, uint256 value);
}


// File @openzeppelin/contracts/utils/Address.sol@v4.3.1



pragma solidity ^0.8.0;

/**
 * @dev Collection of functions related to the address type
 */
library Address {

 function isContract(address account) internal view returns (bool) {
  // This method relies on extcodesize, which returns 0 for contracts in
  // construction, since the code is only stored at the end of the
  // constructor execution.

  uint256 size;
  assembly {
   size := extcodesize(account)
  }
  return size > 0;
 }


 function sendValue(address payable recipient, uint256 amount) internal {
  require(address(this).balance >= amount, "Address: insufficient balance");

  (bool success,) = recipient.call{value : amount}("");
  require(success, "Address: unable to send value, recipient may have reverted");
 }

 function functionCall(address target, bytes memory data) internal returns (bytes memory) {
  return functionCall(target, data, "Address: low-level call failed");
 }

 /**
  * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
  * `errorMessage` as a fallback revert reason when `target` reverts.
  *
  * _Available since v3.1._
  */
 function functionCall(
  address target,
  bytes memory data,
  string memory errorMessage
 ) internal returns (bytes memory) {
  return functionCallWithValue(target, data, 0, errorMessage);
 }

 function functionCallWithValue(
  address target,
  bytes memory data,
  uint256 value
 ) internal returns (bytes memory) {
  return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
 }

 /**
  * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
  * with `errorMessage` as a fallback revert reason when `target` reverts.
  *
  * _Available since v3.1._
  */
 function functionCallWithValue(
  address target,
  bytes memory data,
  uint256 value,
  string memory errorMessage
 ) internal returns (bytes memory) {
  require(address(this).balance >= value, "Address: insufficient balance for call");
  require(isContract(target), "Address: call to non-contract");

  (bool success, bytes memory returndata) = target.call{value : value}(data);
  return verifyCallResult(success, returndata, errorMessage);
 }

 /**
  * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
  * but performing a static call.
  *
  * _Available since v3.3._
  */
 function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
  return functionStaticCall(target, data, "Address: low-level static call failed");
 }

 /**
  * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
  * but performing a static call.
  *
  * _Available since v3.3._
  */
 function functionStaticCall(
  address target,
  bytes memory data,
  string memory errorMessage
 ) internal view returns (bytes memory) {
  require(isContract(target), "Address: static call to non-contract");

  (bool success, bytes memory returndata) = target.staticcall(data);
  return verifyCallResult(success, returndata, errorMessage);
 }

 /**
  * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
  * but performing a delegate call.
  *
  * _Available since v3.4._
  */
 function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
  return functionDelegateCall(target, data, "Address: low-level delegate call failed");
 }

 /**
  * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
  * but performing a delegate call.
  *
  * _Available since v3.4._
  */
 function functionDelegateCall(
  address target,
  bytes memory data,
  string memory errorMessage
 ) internal returns (bytes memory) {
  require(isContract(target), "Address: delegate call to non-contract");

  (bool success, bytes memory returndata) = target.delegatecall(data);
  return verifyCallResult(success, returndata, errorMessage);
 }

 /**
  * @dev Tool to verifies that a low level call was successful, and revert if it wasn't, either by bubbling the
  * revert reason using the provided one.
  *
  * _Available since v4.3._
  */
 function verifyCallResult(
  bool success,
  bytes memory returndata,
  string memory errorMessage
 ) internal pure returns (bytes memory) {
  if (success) {
   return returndata;
  } else {
   // Look for revert reason and bubble it up if present
   if (returndata.length > 0) {
    // The easiest way to bubble the revert reason is using memory via assembly

    assembly {
     let returndata_size := mload(returndata)
     revert(add(32, returndata), returndata_size)
    }
   } else {
    revert(errorMessage);
   }
  }
 }
}

pragma solidity ^0.8.0;

library SafeERC20 {
 using Address for address;

 function safeTransfer(
  IERC20 token,
  address to,
  uint256 value
 ) internal {
  _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
 }

 function safeTransferFrom(
  IERC20 token,
  address from,
  address to,
  uint256 value
 ) internal {
  _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
 }

 function safeApprove(
  IERC20 token,
  address spender,
  uint256 value
 ) internal {
  // safeApprove should only be called when setting an initial allowance,
  // or when resetting it to zero. To increase and decrease it, use
  // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
  require(
   (value == 0) || (token.allowance(address(this), spender) == 0),
   "SafeERC20: approve from non-zero to non-zero allowance"
  );
  _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
 }

 function safeIncreaseAllowance(
  IERC20 token,
  address spender,
  uint256 value
 ) internal {
  uint256 newAllowance = token.allowance(address(this), spender) + value;
  _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
 }

 function safeDecreaseAllowance(
  IERC20 token,
  address spender,
  uint256 value
 ) internal {
 unchecked {
  uint256 oldAllowance = token.allowance(address(this), spender);
  require(oldAllowance >= value, "SafeERC20: decreased allowance below zero");
  uint256 newAllowance = oldAllowance - value;
  _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
 }
 }

 function _callOptionalReturn(IERC20 token, bytes memory data) private {
  // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
  // we're implementing it ourselves. We use {Address.functionCall} to perform this call, which verifies that
  // the target address contains contract code and also asserts for success in the low-level call.

  bytes memory returndata = address(token).functionCall(data, "SafeERC20: low-level call failed");
  if (returndata.length > 0) {
   // Return data is optional
   require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
  }
 }
}


library TransferHelper {
 function safeApprove(address token, address to, uint value) internal {
  // bytes4(keccak256(bytes('approve(address,uint256)')));
  (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0x095ea7b3, to, value));
  require(success && (data.length == 0 || abi.decode(data, (bool))), 'TransferHelper: APPROVE_FAILED');
 }

 function safeTransfer(address token, address to, uint value) internal {
  // bytes4(keccak256(bytes('transfer(address,uint256)')));
  (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0xa9059cbb, to, value));
  require(success && (data.length == 0 || abi.decode(data, (bool))), 'TransferHelper: TRANSFER_FAILED');
 }

 function safeTransferFrom(address token, address from, address to, uint value) internal {
  // bytes4(keccak256(bytes('transferFrom(address,address,uint256)')));
  (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0x23b872dd, from, to, value));
  require(success && (data.length == 0 || abi.decode(data, (bool))), 'TransferHelper: TRANSFER_FROM_FAILED');
 }

 function safeTransferETH(address to, uint value) internal {
  (bool success,) = to.call{value : value}(new bytes(0));
  require(success, 'TransferHelper: ETH_TRANSFER_FAILED');
 }
}

interface IPancakeRouter01 {
 function factory() external pure returns (address);

 function WETH() external pure returns (address);

 function addLiquidity(
  address tokenA,
  address tokenB,
  uint amountADesired,
  uint amountBDesired,
  uint amountAMin,
  uint amountBMin,
  address to,
  uint deadline
 ) external returns (uint amountA, uint amountB, uint liquidity);

 function addLiquidityETH(
  address token,
  uint amountTokenDesired,
  uint amountTokenMin,
  uint amountETHMin,
  address to,
  uint deadline
 ) external payable returns (uint amountToken, uint amountETH, uint liquidity);

 function removeLiquidity(
  address tokenA,
  address tokenB,
  uint liquidity,
  uint amountAMin,
  uint amountBMin,
  address to,
  uint deadline
 ) external returns (uint amountA, uint amountB);

 function removeLiquidityETH(
  address token,
  uint liquidity,
  uint amountTokenMin,
  uint amountETHMin,
  address to,
  uint deadline
 ) external returns (uint amountToken, uint amountETH);

 function removeLiquidityWithPermit(
  address tokenA,
  address tokenB,
  uint liquidity,
  uint amountAMin,
  uint amountBMin,
  address to,
  uint deadline,
  bool approveMax, uint8 v, bytes32 r, bytes32 s
 ) external returns (uint amountA, uint amountB);

 function removeLiquidityETHWithPermit(
  address token,
  uint liquidity,
  uint amountTokenMin,
  uint amountETHMin,
  address to,
  uint deadline,
  bool approveMax, uint8 v, bytes32 r, bytes32 s
 ) external returns (uint amountToken, uint amountETH);

 function swapExactTokensForTokens(
  uint amountIn,
  uint amountOutMin,
  address[] calldata path,
  address to,
  uint deadline
 ) external returns (uint[] memory amounts);

 function swapTokensForExactTokens(
  uint amountOut,
  uint amountInMax,
  address[] calldata path,
  address to,
  uint deadline
 ) external returns (uint[] memory amounts);

 function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
 external
 payable
 returns (uint[] memory amounts);

 function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
 external
 returns (uint[] memory amounts);

 function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
 external
 returns (uint[] memory amounts);

 function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
 external
 payable
 returns (uint[] memory amounts);

 function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);

 function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);

 function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);

 function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);

 function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}

interface IPancakeRouter02 is IPancakeRouter01 {
 function removeLiquidityETHSupportingFeeOnTransferTokens(
  address token,
  uint liquidity,
  uint amountTokenMin,
  uint amountETHMin,
  address to,
  uint deadline
 ) external returns (uint amountETH);

 function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
  address token,
  uint liquidity,
  uint amountTokenMin,
  uint amountETHMin,
  address to,
  uint deadline,
  bool approveMax, uint8 v, bytes32 r, bytes32 s
 ) external returns (uint amountETH);

 function swapExactTokensForTokensSupportingFeeOnTransferTokens(
  uint amountIn,
  uint amountOutMin,
  address[] calldata path,
  address to,
  uint deadline
 ) external;

 function swapExactETHForTokensSupportingFeeOnTransferTokens(
  uint amountOutMin,
  address[] calldata path,
  address to,
  uint deadline
 ) external payable;

 function swapExactTokensForETHSupportingFeeOnTransferTokens(
  uint amountIn,
  uint amountOutMin,
  address[] calldata path,
  address to,
  uint deadline
 ) external;
}

interface IPancakeFactory {
 event PairCreated(address indexed token0, address indexed token1, address pair, uint);

 function feeTo() external view returns (address);

 function feeToSetter() external view returns (address);

 function getPair(address tokenA, address tokenB) external view returns (address pair);

 function allPairs(uint) external view returns (address pair);

 function allPairsLength() external view returns (uint);

 function createPair(address tokenA, address tokenB) external returns (address pair);

 function setFeeTo(address) external;

 function setFeeToSetter(address) external;

 function INIT_CODE_PAIR_HASH() external view returns (bytes32);
}

interface IPancakePair {
 event Approval(address indexed owner, address indexed spender, uint value);
 event Transfer(address indexed from, address indexed to, uint value);

 function name() external pure returns (string memory);

 function symbol() external pure returns (string memory);

 function decimals() external pure returns (uint8);

 function totalSupply() external view returns (uint);

 function balanceOf(address owner) external view returns (uint);

 function allowance(address owner, address spender) external view returns (uint);

 function approve(address spender, uint value) external returns (bool);

 function transfer(address to, uint value) external returns (bool);

 function transferFrom(address from, address to, uint value) external returns (bool);

 function DOMAIN_SEPARATOR() external view returns (bytes32);

 function PERMIT_TYPEHASH() external pure returns (bytes32);

 function nonces(address owner) external view returns (uint);

 function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;

 event Mint(address indexed sender, uint amount0, uint amount1);
 event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
 event Swap(
  address indexed sender,
  uint amount0In,
  uint amount1In,
  uint amount0Out,
  uint amount1Out,
  address indexed to
 );
 event Sync(uint112 reserve0, uint112 reserve1);

 function MINIMUM_LIQUIDITY() external pure returns (uint);

 function factory() external view returns (address);

 function token0() external view returns (address);

 function token1() external view returns (address);

 function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);

 function price0CumulativeLast() external view returns (uint);

 function price1CumulativeLast() external view returns (uint);

 function kLast() external view returns (uint);

 function mint(address to) external returns (uint liquidity);

 function burn(address to) external returns (uint amount0, uint amount1);

 function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;

 function skim(address to) external;

 function sync() external;

 function initialize(address, address) external;
}

library PancakeLibrary {
 using SafeMath for uint;

 // returns sorted token addresses, used to handle return values from pairs sorted in this order
 function sortTokens(address tokenA, address tokenB) internal pure returns (address token0, address token1) {
  require(tokenA != tokenB, 'PancakeLibrary: IDENTICAL_ADDRESSES');
  (token0, token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
  require(token0 != address(0), 'PancakeLibrary: ZERO_ADDRESS');
 }

 // calculates the CREATE2 address for a pair without making any external calls
 function pairFor(address factory, address tokenA, address tokenB) internal pure returns (address pair) {
  (address token0, address token1) = sortTokens(tokenA, tokenB);
  pair = address(uint160(uint(keccak256(abi.encodePacked(
    hex'ff',
    factory,
    keccak256(abi.encodePacked(token0, token1)),
    hex'ecba335299a6693cb2ebc4782e74669b84290b6378ea3a3873c7231a8d7d1074'   // test
   //hex'00fb7f630766e6a796048ea87d01acd3068e8ff67d078148a3fa3f4a84f69bd5' // main
   )))));
 }

 // fetches and sorts the reserves for a pair
 function getReserves(address factory, address tokenA, address tokenB) internal view returns (uint reserveA, uint reserveB) {
  (address token0,) = sortTokens(tokenA, tokenB);
  pairFor(factory, tokenA, tokenB);
  (uint reserve0, uint reserve1,) = IPancakePair(pairFor(factory, tokenA, tokenB)).getReserves();
  (reserveA, reserveB) = tokenA == token0 ? (reserve0, reserve1) : (reserve1, reserve0);
 }

 // given some amount of an asset and pair reserves, returns an equivalent amount of the other asset
 function quote(uint amountA, uint reserveA, uint reserveB) internal pure returns (uint amountB) {
  require(amountA > 0, 'PancakeLibrary: INSUFFICIENT_AMOUNT');
  require(reserveA > 0 && reserveB > 0, 'PancakeLibrary: INSUFFICIENT_LIQUIDITY');
  amountB = amountA.mul(reserveB) / reserveA;
 }

 // given an input amount of an asset and pair reserves, returns the maximum output amount of the other asset
 function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) internal pure returns (uint amountOut) {
  require(amountIn > 0, 'PancakeLibrary: INSUFFICIENT_INPUT_AMOUNT');
  require(reserveIn > 0 && reserveOut > 0, 'PancakeLibrary: INSUFFICIENT_LIQUIDITY');
  uint amountInWithFee = amountIn.mul(9975);
  uint numerator = amountInWithFee.mul(reserveOut);
  uint denominator = reserveIn.mul(10000).add(amountInWithFee);
  amountOut = numerator / denominator;
 }

 // given an output amount of an asset and pair reserves, returns a required input amount of the other asset
 function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) internal pure returns (uint amountIn) {
  require(amountOut > 0, 'PancakeLibrary: INSUFFICIENT_OUTPUT_AMOUNT');
  require(reserveIn > 0 && reserveOut > 0, 'PancakeLibrary: INSUFFICIENT_LIQUIDITY');
  uint numerator = reserveIn.mul(amountOut).mul(10000);
  uint denominator = reserveOut.sub(amountOut).mul(9975);
  amountIn = (numerator / denominator).add(1);
 }

 // performs chained getAmountOut calculations on any number of pairs
 function getAmountsOut(address factory, uint amountIn, address[] memory path) internal view returns (uint[] memory amounts) {
  require(path.length >= 2, 'PancakeLibrary: INVALID_PATH');
  amounts = new uint[](path.length);
  amounts[0] = amountIn;
  for (uint i; i < path.length - 1; i++) {
   (uint reserveIn, uint reserveOut) = getReserves(factory, path[i], path[i + 1]);
   amounts[i + 1] = getAmountOut(amounts[i], reserveIn, reserveOut);
  }
 }

 // performs chained getAmountIn calculations on any number of pairs
 function getAmountsIn(address factory, uint amountOut, address[] memory path) internal view returns (uint[] memory amounts) {
  require(path.length >= 2, 'PancakeLibrary: INVALID_PATH');
  amounts = new uint[](path.length);
  amounts[amounts.length - 1] = amountOut;
  for (uint i = path.length - 1; i > 0; i--) {
   (uint reserveIn, uint reserveOut) = getReserves(factory, path[i - 1], path[i]);
   amounts[i - 1] = getAmountIn(amounts[i], reserveIn, reserveOut);
  }
 }
}

// File contracts/StakePool.sol



pragma solidity ^0.8.0;
//pragma experimental ABIEncoderV2;

library SafeMath {
 /**
  * @dev Returns the addition of two unsigned integers, with an overflow flag.
  *
  * _Available since v3.4._
  */
 function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
 unchecked {
  uint256 c = a + b;
  if (c < a) return (false, 0);
  return (true, c);
 }
 }

 /**
  * @dev Returns the substraction of two unsigned integers, with an overflow flag.
  *
  * _Available since v3.4._
  */
 function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
 unchecked {
  if (b > a) return (false, 0);
  return (true, a - b);
 }
 }

 /**
  * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
  *
  * _Available since v3.4._
  */
 function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
 unchecked {
  // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
  // benefit is lost if 'b' is also tested.
  // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
  if (a == 0) return (true, 0);
  uint256 c = a * b;
  if (c / a != b) return (false, 0);
  return (true, c);
 }
 }

 function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
 unchecked {
  if (b == 0) return (false, 0);
  return (true, a / b);
 }
 }

 function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
 unchecked {
  if (b == 0) return (false, 0);
  return (true, a % b);
 }
 }


 function add(uint256 a, uint256 b) internal pure returns (uint256) {
  return a + b;
 }


 function sub(uint256 a, uint256 b) internal pure returns (uint256) {
  return a - b;
 }

 function mul(uint256 a, uint256 b) internal pure returns (uint256) {
  return a * b;
 }

 function div(uint256 a, uint256 b) internal pure returns (uint256) {
  return a / b;
 }

 function mod(uint256 a, uint256 b) internal pure returns (uint256) {
  return a % b;
 }

 function sub(
  uint256 a,
  uint256 b,
  string memory errorMessage
 ) internal pure returns (uint256) {
 unchecked {
  require(b <= a, errorMessage);
  return a - b;
 }
 }

 function div(
  uint256 a,
  uint256 b,
  string memory errorMessage
 ) internal pure returns (uint256) {
 unchecked {
  require(b > 0, errorMessage);
  return a / b;
 }
 }

 function mod(
  uint256 a,
  uint256 b,
  string memory errorMessage
 ) internal pure returns (uint256) {
 unchecked {
  require(b > 0, errorMessage);
  return a % b;
 }
 }
}


// SPDX-License-Identifier: MIT
contract buy is Ownable {
 using SafeMath for uint;
 using SafeERC20 for IERC20;
 using PaySet for PaySet.Set;

 ///////////////////////////////// constant /////////////////////////////////
 // todo: wethToken address
 address constant WETH_ADDRESS = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
 address constant USDT_ADDRESS = 0x55d398326f99059fF775485246999027B3197955;
 //address constant BUSD_ADDRESS = 0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56;
 address constant FACTORY = 0xcA143Ce32Fe78f1f7019d7d551a6402fC5350c73;
 address constant ROUTER = 0x10ED43C718714eb63d5aA57B78B54704E256024E;

 // address constant WETH_ADDRESS = 0xae13d989daC2f0dEbFf460aC112a837C89BAa7cd;
 // address constant USDT_ADDRESS = 0x7ef95a0FEE0Dd31b22626fA2e10Ee6A223F8a684;
 // address constant FACTORY = 0xB7926C0430Afb07AA7DEfDE6DA862aE0Bde767bc;
 // address constant ROUTER = 0x9Ac64Cc6e4415144C455BD8E4837Fea55603e5c3;
 // address constant BUSD_ADDRESS = 0x78867BbEeF44f2326bF8DDd1941a4439382EF2A7;

 address public makerAdr;

 mapping(address => PaySet.Set) private _payAdrOf;
 mapping(uint => bool) public payOrderIdOf;
 mapping(address => bool) public safeNFT;
 address[] private safeNFTAdrs;

 //config
 uint public payId = 0;
 uint public safePrice = 1000;
 uint constant DECIMALS = 10 ** 18;


 constructor (address _makerAdr) {
  //第一个是提现的合约地址
  makerAdr = _makerAdr;
 }


 function setMakerAdr(address account) public onlyOwner{
  require(account != address(0), "ERC20: fundAddress to the zero address");
  makerAdr = account;
 }

 function setSafePrice(uint _value) external onlyOwner {
  safePrice = _value;
 }

 function getSafeNFTAdrs() external view returns(uint){
  return safeNFTAdrs.length;
 }


 function getPayAdrOfs(address _account, uint _index, uint _offset) external view returns (PaySet.Item[] memory items) {
  uint totalSize = _payAdrOf[_account]._values.length;
  if (0 == totalSize || totalSize <= _index) return items;
  uint offset = _offset;
  if (totalSize < _index + offset) {
   offset = totalSize - _index;
  }

  items = new PaySet.Item[](offset);
  for (uint i = 0; i < offset; i++) {
   items[i] = _payAdrOf[_account].at(_index + i);
  }
 }


 function extractExtra(address _constantAddress, address _account,uint _amount) external onlyOwner {
  if(_constantAddress == WETH_ADDRESS){
   payable(_account).transfer(_amount);
  }else{
   IERC20(_constantAddress).safeTransfer(_account, _amount);
  }

 }

 function marketMaker(uint _amount,uint orderId) external {
  require(!payOrderIdOf[orderId], "marketMaker: orderId expired!");
  IERC20(USDT_ADDRESS).safeTransferFrom(msg.sender, address(this), _amount);
  TransferHelper.safeApprove(USDT_ADDRESS, ROUTER, _amount);
  address[] memory _path = new address[](2);
  _path[0] = USDT_ADDRESS;
  //_path[1] = BUSD_ADDRESS;
  _path[1] = WETH_ADDRESS;
  // uint[] memory Uamounts = PancakeLibrary.getAmountsOut(FACTORY, _amount, _path);
  // uint UamountOutMin = Uamounts[Uamounts.length - 1];
  IPancakeRouter02(ROUTER).swapExactTokensForETH(_amount, 0, _path, makerAdr, block.timestamp);

  // create _payOf
  PaySet.Item memory item;
  item.id = ++payId;
  item.orderId = orderId;
  item.createTime = block.timestamp;
  item.payAmount = _amount;
  item.payTokenAddr = USDT_ADDRESS;
  item.owner = msg.sender;
  _payAdrOf[msg.sender].add(item);
  _payAdrOf[address(0)].add(item);

  payOrderIdOf[orderId] = true;

 }
 receive() external payable {}
 fallback() external {}
}
