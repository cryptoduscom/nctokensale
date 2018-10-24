import EVMRevert from 'openzeppelin-solidity/test/helpers/EVMRevert';

const BigNumber = web3.BigNumber;
const should = require('chai')
  .use(require('chai-as-promised'))
  .use(require('chai-bignumber')(BigNumber))
  .should();
const Ico = artifacts.require("./Ico")

contract('IcoTest', function (accounts) {
  let owner = accounts[0];
  let investor = accounts[1];

  beforeEach(async function () {
    this.ico = await Ico.new({from: owner})
  });

  describe('changing state', function() {
    it('should not accept payments while not started', async function() {
      await this.ico.invest(investor, {from: investor, value: 1e18}).should.be.rejectedWith(EVMRevert);
    });
    it('should accept payments when started', async function() {
      await this.ico.start();
      await this.ico.invest(investor, {from: investor, value: 1e18}).should.be.fulfilled;
    });
    it('should not accept payments when paused', async function() {
      await this.ico.start();
      await this.ico.invest(investor, {from: investor, value: 1e18}).should.be.fulfilled;
      await this.ico.pause();
      await this.ico.invest(investor, {from: investor, value: 1e18}).should.be.rejectedWith(EVMRevert);
    });
    it('should accept payments when unpaused', async function() {
      await this.ico.start();
      await this.ico.invest(investor, {from: investor, value: 1e18}).should.be.fulfilled;
      await this.ico.pause();
      await this.ico.invest(investor, {from: investor, value: 1e18}).should.be.rejectedWith(EVMRevert);
      await this.ico.unpause();
      await this.ico.invest(investor, {from: investor, value: 1e18}).should.be.fulfilled;
    });
    it('should not accept payments when finalized', async function() {
      await this.ico.start();
      await this.ico.invest(investor, {from: investor, value: 1e18}).should.be.fulfilled;
      await this.ico.finalize();
      await this.ico.invest(investor, {from: investor, value: 1e18}).should.be.rejectedWith(EVMRevert);
    });
  });
  describe('forwarding funds', function() {
    it('should forward funds to ico owner', async function() {
      const preInvestBalance = web3.eth.getBalance(owner);
      await this.ico.start();
      await this.ico.invest(investor, {from: investor, value: 1e18}).should.be.fulfilled;
      const postInvestBalance = web3.eth.getBalance(owner);
      postInvestBalance.should.be.bignumber.gt(preInvestBalance);

    });
  });
});
