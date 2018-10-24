import EVMRevert from 'openzeppelin-solidity/test/helpers/EVMRevert';

const BigNumber = web3.BigNumber;
const truffleAssert = require('truffle-assertions');
const should = require('chai')
  .use(require('chai-as-promised'))
  .use(require('chai-bignumber')(BigNumber))
  .should();
const Token = artifacts.require("./Token")

contract('TokenTest', function (accounts) {
  let owner = accounts[0];
  let investor = accounts[1];

  beforeEach(async function () {
    this.token = await Token.new({from: owner})
  });

  describe('should add message when trasferning tokens with message', function() {
    it('should add message when transfering tokens with transferWithMsg', async function() {
      let tx = await this.token.transferWithMsg(investor, 1e18, 'Test_with_msg!', {from: owner});
      truffleAssert.eventEmitted(tx, 'TransferringWithMessage', (ev) => {
          return ev.message === 'Test_with_msg!';
      });
    });
    it('should add message when transfering tokens with transferFromWithMsg', async function() {
      await this.token.approve(owner, 1e18, {from: owner});
      let tx = await this.token.transferFromWithMsg(owner, investor, 1e18, 'Test_from_with_msg!');
      truffleAssert.eventEmitted(tx, 'TransferringWithMessage', (ev) => {
          return ev.message === 'Test_from_with_msg!';
      });
    });
  });
});
