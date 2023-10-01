// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  const youtubeFactory = await hre.ethers.getContractFactory("Youtube");
  const yt = await youtubeFactory.attach("0xdc64a140aa3e981100a9beca4e685f962f0cf6c9");

  const setText = await yt.setText("INI ADALAH TEXT PERTAMA");
  console.log(setText);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
