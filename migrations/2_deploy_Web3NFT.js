const Web3NFT = artifacts.require('Web3NFT');

module.exports = (deployer) => {
  // Deploys the contract
  deployer.deploy(Web3NFT);
};