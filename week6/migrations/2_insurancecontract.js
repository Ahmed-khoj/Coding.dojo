const insurancecontract = artifacts.require("insurancecontract");

module.exports = function(deployer) {
  deployer.deploy(insurancecontract);
};
