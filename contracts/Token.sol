pragma solidity 0.4.24;

import "openzeppelin-solidity/contracts/token/ERC20/CappedToken.sol";

contract Token is CappedToken {

  uint256 private constant TOKEN_SUPPLY = 1 * 10**27;

  string public constant name = "Nitecrawler";
  string public constant symbol = "NCRL";
  uint8 public constant decimals = 18;

  event TransferingWithMessage(string message);

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
    emit TransferingWithMessage(_msg);
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
    emit TransferingWithMessage(_msg);
    return super.transferFrom(_from, _to, _value);
  }

}
