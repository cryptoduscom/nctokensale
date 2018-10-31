pragma solidity 0.4.24;

import "openzeppelin-solidity/contracts/lifecycle/Pausable.sol";

contract TokenSale is Pausable {

  // Flag indicating if contract was finalized
  bool public isFinalized = false;

  // Flag indicating if contract was started
  bool public isStarted = false;

  // Event that is emited once contract was finalized
  event Finalized();

  // Event that is emited once contract was started
  event Started();

  // Event that is emited once invested
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

  // Method for starting token sale
  function start() public onlyOwner {
    require(!isStarted);
    require(!isFinalized);
    emit Started();
    isStarted = true;
  }

  // Method for pausing token sale
  function pause() public onlyOwner whenStarted whenNotFinalized whenNotPaused {
    super.pause();
  }

  // Method for unpausing token sale
  function unpause() public onlyOwner whenStarted whenNotFinalized whenPaused {
    super.unpause();
  }

  // Method for finalizing token sale
  function finalize() public onlyOwner {
    require(isStarted);
    require(!isFinalized);
    emit Finalized();
    isFinalized = true;
  }

  function () external payable {
    invest(msg.sender);
  }

  // Method handling investment and forwarding ethereum to owners wallet
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
