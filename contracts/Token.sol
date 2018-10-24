pragma solidity 0.4.24;

import "openzeppelin-solidity/contracts/token/ERC20/StandardToken.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract Token is StandardToken, Ownable {

  uint256 private constant TOKEN_SUPPLY = 1 * 10**27;

  string public constant name = "Nitecrawler";
  string public constant symbol = "NCRL";
  uint8 public constant decimals = 18;

  event TransferringWithMessage(string message);

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
    emit TransferringWithMessage(_msg);
    return super.transfer(_to, _value);
  }

  function transferFromWithMsg(
    address _from,
    address _to,
    uint256 _value,
    string _msg
  )
    public returns (bool)
  {
    emit TransferringWithMessage(_msg);
    return super.transferFrom(_from, _to, _value);
  }

}
