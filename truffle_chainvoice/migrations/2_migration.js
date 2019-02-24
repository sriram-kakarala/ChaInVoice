var InvoiceGovernanceContract = artifacts.require("./InvoiceGovernanceContract.sol");

module.exports = function(deployer) {
  deployer.deploy(InvoiceGovernanceContract);
};
