var AssetTransferControl = artifacts.require("./AssetTransferControl.sol");

module.exports = function(deployer) {
  deployer.deploy(AssetTransferControl);

};
