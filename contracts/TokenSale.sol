pragma solidity 0.4.24;

import "openzeppelin-solidity/contracts/lifecycle/Pausable.sol";

contract TokenSale is Pausable {

  bool public isFinalized = false;
  bool public isStarted = false;

  event Finalized();
  event Started();
  event Invested(address purchaser, address beneficiary, uint256 amount);

  modifier whenStarted() {
    require(isStarted);
    _;
  }

  modifier whenNotFinalized() {
    require(!isFinalized);
    _;
  }

  constructor() public  {
  }

  function start() public onlyOwner {
    require(!isStarted);
    emit Started();
    isStarted = true;
  }

  function finalize() public onlyOwner {
    require(!isFinalized);
    emit Finalized();
    isFinalized = true;
  }

  function () external payable {
    invest(msg.sender);
  }

  function invest(address _beneficiary)
    public
    whenStarted
    whenNotPaused
    whenNotFinalized
    payable {

    uint256 _weiAmount = msg.value;
    require(_beneficiary != address(0));
    require(_weiAmount != 0);

    emit Invested(msg.sender, _beneficiary, _weiAmount);

    owner.transfer(_weiAmount);
  }
}
