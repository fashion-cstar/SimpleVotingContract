// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
import { ethers, upgrades } from 'hardhat';

require('dotenv').config();

async function deployVotingFactory() {
  const factory = await ethers.getContractFactory('VotingFactory');
  const votingFactory = await factory.deploy();  
  console.log('VotingFactory contract deployed: %s', votingFactory.address);
}

async function main() {
  await deployVotingFactory();
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
