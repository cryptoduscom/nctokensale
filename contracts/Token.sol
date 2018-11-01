pragma solidity 0.4.24;

import "openzeppelin-solidity/contracts/token/ERC20/StandardToken.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract Token is StandardToken, Ownable {

  uint256 private constant TOKEN_SUPPLY = 1 * 10**27;

  string public constant name = "Nitecrawler";
  string public constant symbol = "NCRL";
  uint8 public constant decimals = 18;

  event TransferringWithMessage(
    address indexed from,
    address indexed to,
    uint256 value,
    string message);

  constructor() public  {
    totalSupply_ = TOKEN_SUPPLY;
    balances[msg.sender] = TOKEN_SUPPLY;
  }

  function transferWithMsg(
    address _to,
    uint256 _value,
    string _msg
  )
    public returns (bool)
  {
    require(super.transfer(_to, _value));
    emit TransferringWithMessage(msg.sender, _to, _value, _msg);
    return true;
  }

  function transferFromWithMsg(
    address _from,
    address _to,
    uint256 _value,
    string _msg
  )
    public returns (bool)
  {
    require(super.transferFrom(_from, _to, _value));
    emit TransferringWithMessage(_from, _to, _value, _msg);
    return true;
  }

}
